//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;

uniform vec3 u_circle;
uniform sampler2D u_sampler;
uniform float u_dir;
uniform vec2 u_dim;
uniform float u_size;

void main()
{
	vec4 col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	//give colours
	col.r = (v_vPosition.x - u_circle[0] + u_circle[2])/u_circle[2];
	col.g = (v_vPosition.y - u_circle[1] + u_circle[2])/u_circle[2];
	col.b = (-v_vPosition.y + u_circle[1] - v_vPosition.x + u_circle[0] + u_circle[2])/u_circle[2];
	
	//within circle
	col.a *= float(((v_vPosition.x - u_circle[0]) * (v_vPosition.x - u_circle[0]))
	+ ((v_vPosition.y - u_circle[1]) * (v_vPosition.y - u_circle[1]))
	< u_circle[2]*u_circle[2]);
		
	//not near anything on application surface
	vec4 alt_col = texture2D(u_sampler, v_vPosition.xy/u_dim.xy);
	float mul = u_size;
	float a_mul = u_size*sqrt(2.0)/2.0;
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(mul, 0.0))/u_dim.xy);
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(-mul, 0.0))/u_dim.xy);
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(0.0, mul))/u_dim.xy);
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(a_mul, a_mul))/u_dim.xy);
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(-a_mul, a_mul))/u_dim.xy);
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(0.0, -mul))/u_dim.xy);
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(a_mul, -a_mul))/u_dim.xy);
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(-a_mul, -a_mul))/u_dim.xy);
	col.a *= 1.0 - float(max(alt_col.r, max(alt_col.g, alt_col.b)) > 0.001); //draw on no colour

	//get positions / vectors
	vec2 pos = vec2(
		(u_circle[0] - v_vPosition.x),
		(u_circle[1] - v_vPosition.y)
	);
	vec2 sq_pos = vec2(
		(u_circle[0] - v_vPosition.x)*(u_circle[0] - v_vPosition.x),
		(u_circle[1] - v_vPosition.y)*(u_circle[1] - v_vPosition.y)
	);
	pos -= 0.5;
	vec2 vec = vec2(
		sqrt(sq_pos.x + sq_pos.y), 
		(atan(-pos.y,pos.x) + float(pos.y > 0.0)*6.283185307179586476925286766559) / 6.283185307179586476925286766559
	);
	
	vec[1] -= u_dir;
	//add double spriral pattern
	vec2 temp;
	temp.x = mod(12.0*vec[1], 1.0) + mod(vec[0], u_size*4.0)/(u_size*4.0);
	temp.y = -mod(12.0*vec[1], 1.0) + mod(vec[0], u_size*4.0)/(u_size*4.0);
	temp.x = (float(temp.x > 0.9) * float(temp.x < 1.1)) + (float(temp.y > -0.1) * float(temp.y < 0.1));
	
	
	//add border
	alt_col = vec4(0.0, 0.0, 0.0, 0.0);
	mul *= 2.0;
	a_mul *= 2.0;
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(mul, 0.0))/u_dim.xy);
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(-mul, 0.0))/u_dim.xy);
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(0.0, mul))/u_dim.xy);
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(a_mul, a_mul))/u_dim.xy);
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(-a_mul, a_mul))/u_dim.xy);
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(0.0, -mul))/u_dim.xy);
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(a_mul, -a_mul))/u_dim.xy);
	alt_col += texture2D(u_sampler, (v_vPosition.xy - vec2(-a_mul, -a_mul))/u_dim.xy);
	temp.x += float(max(alt_col.r, max(alt_col.g, alt_col.b)) > 0.001); //add on colour
	//temp.x -= float(abs(alt_col.r - alt_col.g) < 0.01) * float(abs(alt_col.r - alt_col.b) < 0.01) * float(abs(alt_col.r - 0.00390625) < 0.001);
	//add outer border
	temp.x += float(sq_pos.x + sq_pos.y > (u_circle[2] - u_size)*(u_circle[2] - u_size));
	
	col.a *= temp.x;
	
    gl_FragColor = col;
}