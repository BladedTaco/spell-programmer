//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 pos;
uniform float u_age;
uniform float u_dim;

const float res = 60.0;

//uniform vec3 u_smooth;

/*algorithm
make a 1/res resolution grid
get noise values by smoothing between 4 nearest pixels (gpu interpolation )
then smooth by a second grid
move the grids along z space

*/


//Golden noise, basically fast dRNG 
const float PHI = 1.61803398874989484820459; // Φ = Golden Ratio 
float gold_noise(vec2 pos, float seed) {
    return fract(tan(distance(pos*PHI, pos)*seed)*pos.x);
}

vec3 n(vec2 pos, float seed) {
	//normalize x and y
	vec2 p_xy = normalize(vec2(gold_noise(pos, seed), gold_noise(pos, seed + 1.0)));
	//return norm(xy), z
	return vec3(p_xy, gold_noise(pos, seed + 2.0));
}

vec3 noise(vec3 pos, float seed) {
	//a mix on the 8 points surrounding a position
	pos = pos/res;
	vec3 f_pos = floor(pos);
	pos = fract(pos);
	
	////smoothstep
	//vec3 smooth = u_smooth.xyz;
	//if(smooth.x > 0.5) pos.x = smoothstep(0.0, 1.0, pos.x);
	//if(smooth.y > 0.5) pos.y = smoothstep(0.0, 1.0, pos.y); 
	//if(smooth.z > 0.5) pos.z = smoothstep(0.0, 1.0, pos.z); 
	
	return mix(
		mix(
			mix(n(f_pos.xy + vec2(0.0, 0.0), seed + 10.5), n(f_pos.xy + vec2(1.0, 0.0), seed + 10.5), pos.x),
			mix(n(f_pos.xy + vec2(0.0, 1.0), seed + 10.5), n(f_pos.xy + vec2(1.0, 1.0), seed + 10.5), pos.x),
			pos.y
		),
		mix(
			mix(n(f_pos.xy + vec2(0.0, 0.0), seed + 11.5), n(f_pos.xy + vec2(1.0, 0.0), seed + 11.5), pos.x),
			mix(n(f_pos.xy + vec2(0.0, 1.0), seed + 11.5), n(f_pos.xy + vec2(1.0, 1.0), seed + 11.5), pos.x),
			pos.y
		),
		pos.z
	);
}

vec3 n_noise(vec3 pos, float seed) {
	// get noise colour
	vec3 col = noise(pos, seed);
	//shift away from averages values
	col.r += 0.15*float(col.r > 0.5) - 0.15*float(col.r < 0.5);
	col.g += 0.15*float(col.g > 0.5) - 0.15*float(col.b < 0.5);
	return vec3(clamp(col.xy, 0.0, 1.0), col.z);
}

void main()
{

	//noise returns a vec3 between [0.0, 1.0]
	vec2 real_pos = pos.xy;
	vec4 col = vec4(n_noise(vec3(real_pos + res, u_age), floor(u_age/res)), 1.0);
	//vec4 col = vec4(noise(vec3(real_pos + res, u_age), 0.0), 1.0);

	gl_FragColor = col;
}
