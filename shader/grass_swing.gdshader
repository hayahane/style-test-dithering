shader_type spatial;

render_mode cull_disabled, world_vertex_coords;

global uniform vec3 wind_vector;

void vertex()
{
	float distance_to_root = VERTEX.y;
	vec4 positionWS = MODEL_MATRIX * vec4(VERTEX,1.0);
	positionWS.xyz += wind_vector * distance_to_root;
	VERTEX = positionWS.xyz;
	
	vec3 bitangent = cross(NORMAL,TANGENT);
	mat3 tangent_matrix = mat3(TANGENT,bitangent,NORMAL);
}

void fragment()
{
	ALBEDO = NORMAL;
}