//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 u_circle;
uniform float u_dir;
uniform float u_size;
uniform float u_arc;
uniform float u_spaced;

const float tau = 3.14159265358979*2.0;

void main()
{

	//get the length
	float _len = u_circle.z - in_Position.y + u_circle.y;
	
	//get direction
	float _dir = u_spaced*tau*u_arc/u_size; //spaced
	_dir += (1.0 - u_spaced)/u_circle.z; //not spaced
	_dir = u_dir - (u_circle.x - in_Position.x)*_dir; //actual dir
	
	//get the position
    vec4 object_space_pos = vec4( 
		u_circle.x + _len*cos(_dir),
		u_circle.y + _len*sin(_dir),
		in_Position.z, 1.0
	);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
	//passthroughs
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
