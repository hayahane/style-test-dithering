vec3 rgb_to_hsv(vec3 color)
{
	vec4 k = vec4(0.0,-1.0/3.0,2.0/3.0,-1.0);
	vec4 p = mix(vec4(color.bg,k.wz),vec4(color.gb,k.xy),step(color.b,color.g));
	vec4 q = mix(vec4(p.xyw, color.r), vec4(color.r,p.yzx), step(p.x,color.r));
	float d = q.x - min(q.w,q.y);
	float e = 1.0e-10;
	return vec3(abs(q.z+(q.w-q.y)/(6.0*d+e)), d/(q.x+e),q.x);
}

vec3 hsv_to_rgb(vec3 color)
{
	vec3 rgb = clamp(abs(mod(color.x*6.0 + vec3(0.0,4.0,2.0), 6.0)-3.0)-1.0,0,1);
	rgb = rgb * rgb * (3.0-2.0*rgb);
	return color.z * mix(vec3(1), rgb, color.y);
}