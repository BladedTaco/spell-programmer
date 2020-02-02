//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 pos;
float PI = 3.14159265358979026264;

float rand(vec2 c){
	return fract(sin(dot(c.xy ,vec2(12.9898,78.233))) * 43758.5453);
}
 
float noise(vec2 p, float freq ){
	float unit = 2048.0/freq;
	vec2 ij = floor(p/unit);
	vec2 xy = mod(p,unit)/unit;
	//xy = 3.*xy*xy-2.*xy*xy*xy;
	xy = .5*(1.-cos(PI*xy));
	float a = rand((ij+vec2(0.,0.)));
	float b = rand((ij+vec2(1.,0.)));
	float c = rand((ij+vec2(0.,1.)));
	float d = rand((ij+vec2(1.,1.)));
	float x1 = mix(a, b, xy.x);
	float x2 = mix(c, d, xy.x);
	return mix(x1, x2, xy.y);
}
 
float pNoise(vec2 p, int res){
	float persistance = .5;
	float n = 0.;
	float normK = 0.;
	float f = 4.;
	float amp = 1.;
	int iCount = 0;
	for (int i = 0; i<50; i++){
		n+=amp*noise(p, f);
		f*=2.;
		normK+=amp;
		amp*=persistance;
		if (iCount == res) break;
		iCount++;
	}
	float nf = n/normK;
	return nf*nf*nf*nf;
}


void main()
{
	vec2 real_pos = pos.xy;
	vec4 col = vec4(0.0, 0.0, 0.0, 1.0);
	//col = vec4(
	//	pNoise(real_pos, 6),
	//	pNoise(real_pos + vec2(2048.0, 2048.0), 2),
	//	pNoise(real_pos + vec2(-2048.0, -2048.0), 4),
	//	1.0
	//);
	
	float angle = atan(real_pos.y - 1024.0, real_pos.x - 1024.0);
	float dis = distance(vec2(1024.0, 1024.0), real_pos);
	col.r += 0.5 + 0.5*cos(angle); //tend towards moving outwards
	col.g += 0.5 + 0.5*sin(angle); //tend towards moving outwards
	col.b += 100.0/dis; //minimum speed
	
	gl_FragColor = col;
}
