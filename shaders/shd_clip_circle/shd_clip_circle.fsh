//a shader to restrict drawing to an area
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;
//
uniform vec3 u_circle;
uniform vec3 u_alt_circle;
//

void main() {
	
	vec4 col = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	
	//limit to within the circles
	col.a *= float(
		//not in first circle
		(((v_vPosition.x - u_circle[0]) * (v_vPosition.x - u_circle[0]))
		+ ((v_vPosition.y - u_circle[1]) * (v_vPosition.y - u_circle[1]))
		> u_circle[2]*u_circle[2])
		//not in second circle
		&& (((v_vPosition.x - u_alt_circle[0]) * (v_vPosition.x - u_alt_circle[0]))
		+ ((v_vPosition.y - u_alt_circle[1]) * (v_vPosition.y - u_alt_circle[1]))
		> u_alt_circle[2]*u_alt_circle[2])
		//between the circles
		&& ((v_vPosition.x + 10.0 > min(u_circle[0], u_alt_circle[0]))
		&& (v_vPosition.y + 10.0 > min(u_circle[1], u_alt_circle[1]))
		&& (v_vPosition.x - 10.0 < max(u_circle[0], u_alt_circle[0]))
		&& (v_vPosition.y - 10.0 < max(u_circle[1], u_alt_circle[1]))) 
	);
	
    gl_FragColor = col;
}
