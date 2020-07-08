//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;

uniform sampler2D s_noise;
uniform sampler2D s_particle;
uniform vec2 u_dim;

uniform float mul;

//the noise of the given pixel
vec4 noise(float x_off, float y_off) {
	return texture2D(s_noise, (v_vPosition.xy - vec2(x_off, y_off))/u_dim.xy);
}

//the actual given pixel
vec4 pixel(float x_off, float y_off) {
	return texture2D(s_particle, (v_vPosition.xy - vec2(x_off, y_off))/u_dim.xy);
}

void main()
{
    vec4 col = noise(0.0, 0.0); //get the noise of the given pixel
	col.b += 1.5; //minimum 1.5 pixel per frome
	vec4 outcol = pixel((col.r - 0.5)*col.b*mul, (col.g - 0.5)*col.b*mul);
	outcol.a = 0.995*float(outcol.a > 0.5);
	
	vec4 mincol = vec4(0.1, 0.1, 0.9, 0.9);
	vec4 maxcol = vec4(1.0, 1.0, 1.0, 1.0);
	vec4 mixcol = mix(mincol, maxcol, (col.b/3.0)*(col.b/2.0));
	
	outcol = mix(outcol, mixcol, 0.1);
	
	gl_FragColor = outcol;
}
