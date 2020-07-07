//draws vertices in a wave with alpha fade

attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 pos;
varying float time;
varying float alpha;

uniform float u_life;
uniform float u_middle;

// EDIT THESE VALUES TO ALTER THE EFFECT

#define M 0.15		// Time spent in small wave 
#define A 100.0		// Amplitude of small wave
#define T 70.0		// Half the time the effect takes in frames
#define H 400.0		// Amplitude of the big wave
#define S 5.0		// Speed of wave scrolling
#define L 40.0		// Length between wave peaks
#define Y 1.15		// Y-multiplier of alpha fade

void main()
{
	// get time to sweep through 1.0 to 0.0 to 1.0 exponentially
	time = pow((u_life - T)/T, 2.0);
	time = M * float(abs(time) < M) + time * float(abs(time) >= M);
	
	//alter the y position of the vertices
	pos = vec3(in_Position);
	pos.y += (float(time > M)*H*(time - M) + A)*time*sin(((pos.x - u_middle) + u_life*S)/L);
	
	//apply the position
    vec4 object_space_pos = vec4( pos.x, pos.y, pos.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
	//pass through variables to fragment shader
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
	alpha = 1.0 - time*Y;
}
