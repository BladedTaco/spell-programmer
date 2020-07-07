//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying float alpha;

void main()
{
	//apply alpha fade effect
    gl_FragColor = vec4(1.0, 1.0, 1.0, alpha) * v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
