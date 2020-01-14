//a shader to restrict drawing to an area
varying vec4 v_vColour;
varying vec3 v_vPosition;
//
uniform vec4 u_bounds;
uniform float _dir;
//
void main() {
    vec4 col = v_vColour;
	
	vec3 r_pos = vec3(v_vPosition);
	r_pos.x = (v_vPosition.x)*cos(_dir) - (v_vPosition.y)*sin(_dir);
	r_pos.y = (v_vPosition.x)*sin(_dir) + (v_vPosition.y)*cos(_dir);

    col.a *= float(r_pos.x >= u_bounds[0] && r_pos.y >= u_bounds[1]
        && r_pos.x < u_bounds[2] && r_pos.y < u_bounds[3]);
    gl_FragColor = col;
}