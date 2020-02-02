//
// Simple passthrough fragment shader
//
uniform float u_age;
uniform float u_alpha;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 pos;

float PHI = 1.61803398874989484820459;  // Φ = Golden Ratio   

float gold_noise(in vec2 xy, in float seed) {
       return fract(tan(distance(xy*PHI, xy)*seed)*xy.x);
}

void main()
{
	vec4 col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	vec2 new_pos = pos.xy;
	col.a = 1.0*float(gold_noise(new_pos, u_age) > u_alpha)*float(col.r + col.g + col.b > 0.05);
    gl_FragColor = col;
}


