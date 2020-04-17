//a shader to restrict drawing to an area
//varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;
varying vec2 v_vTexcoord;
//
uniform vec3 u_circle;
uniform vec3 u_alt_circle;
uniform float u_dir;
//

#define M_PI 3.1415926535897932384626433832795

void main() {
	
	vec4 col = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	vec2 pos = v_vPosition.xy;
	
	//limit to within the circles
	//not in first circle
	col.a *= float(
		(((pos.x - u_circle[0]) * (pos.x - u_circle[0]))
		+ ((pos.y - u_circle[1]) * (pos.y - u_circle[1]))
		> u_circle[2]*u_circle[2])
	);
	//not in second circle
	col.a *= float(
		(((pos.x - u_alt_circle[0]) * (pos.x - u_alt_circle[0]))
		+ ((pos.y - u_alt_circle[1]) * (pos.y - u_alt_circle[1]))
		> u_alt_circle[2]*u_alt_circle[2])
	);
	//between the circles
	float plane = atan(u_circle.y - u_alt_circle.y, u_circle.x - u_alt_circle.x);
	col.a *= float(
		(mod(atan(u_circle.y - pos.y, u_circle.x - pos.x) - plane + .5*M_PI, 2.0*M_PI) < M_PI)
		&& (mod(atan(pos.y - u_alt_circle.y, pos.x - u_alt_circle.x) - plane + .5*M_PI, 2.0*M_PI) < M_PI)
	); 
	
    gl_FragColor = col;
}
