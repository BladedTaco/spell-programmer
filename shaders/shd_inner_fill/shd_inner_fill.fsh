//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;

uniform vec3 u_circle;
uniform float u_dir;
uniform float u_size;

void main()
{
	vec4 col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	//within circle
	col.a *= float(((v_vPosition.x - u_circle[0]) * (v_vPosition.x - u_circle[0]))
	+ ((v_vPosition.y - u_circle[1]) * (v_vPosition.y - u_circle[1]))
	< u_circle[2]*u_circle[2]);
		

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
	
	

	col.a *= temp.x;
	
    gl_FragColor = col;
}