//a shader to restrict drawing to an area
attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;
// YOU CANT USE UNIFORMS IN BOTH PARTS
uniform vec3 v_circle;
uniform float v_dir;

vec2 rotate(float px, float py, float rx, float ry) {
	rx = rx - px;
	ry = ry - py;
	float theta = radians(v_dir);
	return vec2(px + rx * cos(theta) - ry * sin(theta), py + ry * cos(theta) + rx * sin(theta));
}

void main() {
	vec2 pos = rotate(v_circle[0], v_circle[1], in_Position.x, in_Position.y);
	
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(pos.x, pos.y, in_Position.z, 1.0);
	
    v_vPosition = vec3(pos.x, pos.y, in_Position.z);
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}