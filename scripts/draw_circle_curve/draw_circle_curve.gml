/// @description draw_circle_curve(x,y,r,bones,ang,angadd,width,outline)
/// @param x
/// @param y
/// @param r
/// @param bones
/// @param ang
/// @param angadd
/// @param width
/// @param outline

/*
x,y — Center of circle.
r — Radius.
bones — Amount of bones. More bones = more quality, but less speed. Minimum — 3.
ang — Angle of first circle's point.
angadd — Angle of last circle's point (relative to ang). 
width — Width of circle (may be positive or negative).
outline — 0 = curve, 1 = sector. 
*/
/*
var xx,yy,R,B,A,Aa,W,a,lp,lm,dp,dm,AAa,Wh,Out,i;
xx=argument0
yy=argument1
R=argument2
B=max(3,argument3)
A=argument4
Aa=argument5
W=argument6
Out=argument7

a=Aa/B
Wh=W/2
lp=R+Wh
lm=R-Wh
AAa=A+Aa
if Out
{
//OUTLINE
draw_primitive_begin(pr_trianglestrip) //Change to pr_linestrip, to see how it works.
draw_vertex(xx+lengthdir_x(lm,A),yy+lengthdir_y(lm,A)) //First point.
for(i=1; i<=B; i+=1)
{
dp=A+a*i
dm=dp-a
draw_vertex(xx+lengthdir_x(lp,dm),yy+lengthdir_y(lp,dm))
draw_vertex(xx+lengthdir_x(lm,dp),yy+lengthdir_y(lm,dp))
}
draw_vertex(xx+lengthdir_x(lp,AAa),yy+lengthdir_y(lp,AAa))
draw_vertex(xx+lengthdir_x(lm,AAa),yy+lengthdir_y(lm,AAa)) //Last two points to make circle look right.
//OUTLINE
}
else
{
//SECTOR
draw_primitive_begin(pr_trianglefan) //Change to pr_linestrip, to see how it works.
draw_vertex(xx,yy) //First point in the circle's center.
for(i=1; i<=B; i+=1)
{
dp=A+a*i
dm=dp-a
draw_vertex(xx+lengthdir_x(lp,dm),yy+lengthdir_y(lp,dm))
}
draw_vertex(xx+lengthdir_x(lp,AAa),yy+lengthdir_y(lp,AAa)) //Last point.
//SECTOR
}
draw_primitive_end()


//*/

var _x, _y, _r, _w, _rad, _initdir, _arc;
_x = argument[0]
_y = argument[1]
_r = argument[2]
_initdir = (3600 - argument[3]) mod 360; //flip direction so its the correct direction in shader
_arc = argument[4]
_w = argument[5]/2
_rad = _r + _w

shader_set(shd_arc)
var _uniform = shader_get_uniform(shd_arc, "u_circle")
shader_set_uniform_f(_uniform, _x, _y, _rad)
_uniform = shader_get_uniform(shd_arc, "u_arc")
shader_set_uniform_f(_uniform, _r - _w, degtorad(_initdir), degtorad(_initdir + _arc))
draw_rectangle(_x - _rad, _y - _rad, _x + _rad, _y + _rad, false)
shader_reset()
