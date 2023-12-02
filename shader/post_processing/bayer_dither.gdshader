shader_type spatial;

#include "res://shader/shader_include/color_convert.gdshaderinc"

render_mode unshaded, depth_test_disabled;

global uniform vec4 color_filter;
uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_nearest;
const float bayer_pattern[16] = {0.0,8.0,2.0,10.0,
								12.0,4.0,14.0,6.0,
								3.0,11.0,1.0,9.0,
								15.0,7.0,13.0,5.0};

void vertex()
{
	POSITION = vec4(VERTEX,1.0);
}

void fragment() {
	vec3 scene_color = texture(screen_texture, SCREEN_UV).xyz;
	vec3 color = rgb_to_hsv(scene_color);
	int index = int(SCREEN_UV.x * VIEWPORT_SIZE.x) % 4 * 4 
			+ int(SCREEN_UV.y * VIEWPORT_SIZE.y) % 4;
	float threshold = bayer_pattern[index] / 16.0;
	color.z *= step(clamp(threshold + 0.001,0,0.999),color.z);
	ALBEDO = hsv_to_rgb(color) * color_filter.rgb;
}