//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	//alpha is 
	col.a = max(col.r, max(col.g, col.b));
	col.a = min(col.a + (col.r + col.g + col.b)/4.0, 1.0);
	col.a *= col.a;
	col.a *= col.a;
	col.a -= 0.25;
    gl_FragColor = col;
}
