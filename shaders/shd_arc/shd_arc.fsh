//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;

uniform vec3 u_circle;
uniform vec3 u_arc;

float tau = 2.0*3.14159265358979323;

void main()
{
	vec4 col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );

	
	vec2 pos = v_vPosition.xy;
	
	//get relative position
	pos.x -= u_circle[0];
	pos.y -= u_circle[1];
	
	//get angle
	float angle = atan(pos.y, pos.x) + tau/2.0;
	
	//square positions
	pos.x *= pos.x;
	pos.y *= pos.y;
	
	//limit to within the circles and arc
	col.a = 1.0 * float(
		//in first circle
		((pos.x + pos.y) < (u_circle[2]*u_circle[2]))
		//not in second circle
		&& ((pos.x + pos.y) > (u_arc[0]*u_arc[0]))
		//within arc endpoints
		&& (((angle > u_arc[1]) || (angle < u_arc[2] - tau)) && (angle < u_arc[2]))
	);
	
	//give output colour
    gl_FragColor = col;
}
