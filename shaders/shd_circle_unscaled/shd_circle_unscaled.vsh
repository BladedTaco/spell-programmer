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
uniform float u_len;

const float PI = 3.14159265358979;
const float tau = PI*2.0;
const float half_pi = PI/2.0;

void main()
{

	//get the length
	float _len = u_circle.z - in_Position.y + u_circle.y;
	
	//get direction
	float letter = u_size/u_len;
	float _dir = u_spaced*tau*u_arc/u_size; //spaced
	_dir += (1.0 - u_spaced)/u_circle.z; //not spaced
	
	
	float _x = u_circle.x - in_Position.x;
	float over = mod(0.5*_x / letter, 1.0);
	float is_over = float(over > 0.0);
	
	//_x = _x + over*letter;
	//_x = float(int(over))*(2.0*letter) + float(over > 0.0)*letter;
	//_x = 0.0;	
			
	//_x = _x - letter*is_over;
	
	_x = float(int(0.5*_x/letter))*2.0*letter;
	
	
	_dir = u_dir - _x*_dir; //actual dir

	//get the position
    vec4 object_space_pos = vec4( 
		u_circle.x + _len*cos(_dir) + (is_over - 0.5)*letter*cos(_dir + half_pi),
		u_circle.y + _len*sin(_dir) + (is_over - 0.5)*letter*sin(_dir + half_pi),
		in_Position.z, 1.0
	);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
	//passthroughs
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

