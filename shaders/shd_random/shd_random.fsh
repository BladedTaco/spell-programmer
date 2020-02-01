//
// Simple passthrough fragment shader
//
varying vec2 pos;
uniform float u_age;
vec2 new_pos;
float angle;
float len;

float PHI = 1.61803398874989484820459;  // Φ = Golden Ratio   

float gold_noise(in vec2 xy, in float seed) {
       return fract(tan(distance(xy*PHI, xy)*seed)*xy.x);
}

void main()
{
	
	new_pos.x = pos.x - 1024.0;
	new_pos.y = pos.y - 512.0;
	
	len = sqrt(new_pos.x*new_pos.x + new_pos.y*new_pos.y);
	angle = atan(new_pos.y, new_pos.x);
	new_pos.x = pos.x + ceil(u_age*cos(angle));
	new_pos.y = pos.y + ceil(u_age*sin(angle));
	
    gl_FragColor = vec4(
		gold_noise(new_pos, 1.0),
		gold_noise(new_pos, 2.0),
		gold_noise(new_pos, 3.0),
		1.0*float(gold_noise(new_pos, 4.0) > 0.95)
	);
}


