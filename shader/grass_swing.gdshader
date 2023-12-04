shader_type spatial;

render_mode cull_disabled, world_vertex_coords;

#include "shader_include/color_convert.gdshaderinc"

global uniform vec3 wind_vector;
global uniform float threshold;

void vertex()
{
	vec3 tan_point = TANGENT * 0.1 + VERTEX;
	BINORMAL = normalize(cross(NORMAL, TANGENT));
	vec3 binormal_point = BINORMAL * 0.1 + VERTEX;
	vec3 positionWS = VERTEX;
	positionWS += wind_vector * (positionWS.y - NODE_POSITION_WORLD.y);
	tan_point += wind_vector * (tan_point.y - NODE_POSITION_WORLD.y);
	binormal_point += wind_vector * (tan_point.y - NODE_POSITION_WORLD.y);
	
	VERTEX = positionWS;
	NORMAL = normalize(cross(tan_point - positionWS, binormal_point - positionWS));
	COLOR = vec4(NORMAL,0);
}

void fragment()
{
	//if (!FRONT_FACING) NORMAL *= -1.0;
	//ALBEDO = NORMAL;
}

void light() 
{
	float dot_result = dot(NORMAL,LIGHT);
	if (LIGHT_IS_DIRECTIONAL)
	{
		DIFFUSE_LIGHT += step(threshold, dot_result) * ATTENUATION * LIGHT_COLOR;
	}
	else
	{
		float v = rgb_to_hsv(DIFFUSE_LIGHT).z;
		vec3 color = DIFFUSE_LIGHT + ATTENUATION * LIGHT_COLOR;
		color = vec3(rgb_to_hsv(color).rg,v);
		DIFFUSE_LIGHT = hsv_to_rgb(color);
	}
}