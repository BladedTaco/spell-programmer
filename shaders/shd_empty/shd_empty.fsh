//
// removes near black colours
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;


void main()
{
	vec4 col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	col.a *= float(max(col.r, max(col.g, col.b)) > 0.01);
	
    gl_FragColor = col;
}