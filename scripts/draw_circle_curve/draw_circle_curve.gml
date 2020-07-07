/// @description draw_circle_curve(x, y, r, initdir, arc, width)
/// @param x - the x position of the circles center
/// @param y - the y position of the circles center
/// @param r - the middle radius of the arc
/// @param initdir - the direction the arc starts from
/// @param arc - the angle size of the arc
/// @param width - the width of the arc
function draw_circle_curve() {


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



}
