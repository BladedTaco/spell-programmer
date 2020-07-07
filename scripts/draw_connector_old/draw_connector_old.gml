///@func draw_connector(x1, y1, x2, y2, text, colour, size, alt_size, age)
///@param x1
///@param y1
///@param x2
///@param y2
///@param text
///@param colour
///@param size - the size of the endpoint circle
///@param alt_size - the size of the startpoint circle
///@param age - the age of the circle / animation index
///@desc draws a connecting rod from point a to b
function draw_connector_old() {

	var _x1, _y1, _x2, _y2, _x3, _y3, _string, _colour, _size, _alt_size, _age, _len, _dir, _off, _spd;

	var _s = 15


	_x1 = argument[0]
	_y1 = argument[1]
	_x2 = argument[2]
	_y2 = argument[3]
	_x3 = min(_x1, _x2) - _s
	_y3 = min(_y1, _y2) - _s
	_string = argument[4]
	_colour = argument[5]
	_size = argument[6]
	_alt_size = argument[7]
	_age = argument[8]
	_len = point_distance(_x1, _y1, _x2, _y2)
	_dir = point_direction(_x1, _y1, _x2, _y2)
	_off = string_width(_string)
	_spd = _off/60

	//setup surface
	var _surf = surface_create(abs(_x1 - _x2) + _s*2, abs(_y1 - _y2) + _s*2)
	surface_set_target(_surf)
	draw_clear_alpha(c_black, 0)

	//move positions back
	_x1 -= _x3
	_y1 -= _y3
	_x2 -= _x3
	_y2 -= _y3

	//draw connector
	draw_set_colour(_colour)
	draw_line_width(_x1, _y1, _x2, _y2, 24)

	//draw inner
	draw_set_colour(COLOUR.CONNECTOR)
	draw_line_width(_x1, _y1, _x2, _y2, 18)
		
	//get age altered
	_age = _age*_spd mod _off


	//draw text
	draw_set_colour(_colour)
	draw_set_halign(fa_left)
	draw_set_valign(fa_middle)
	draw_text_transformed(
		_x1 + lengthdir_x(_age - _off, _dir), _y1 + lengthdir_y(_age - _off, _dir),
		string_repeat(_string, 1 + ceil((_len - _size)/_off)),
		1, 1, _dir
	)

	surface_reset_target()

	//move back positions
	_x1 += _x3
	_y1 += _y3
	_x2 += _x3
	_y2 += _y3

	//set shader
	shader_set(shd_clip_circle)
	var u_circle = shader_get_uniform(shd_clip_circle, "u_circle")
	shader_set_uniform_f(u_circle, _x1, _y1, _alt_size - 1);
	u_circle = shader_get_uniform(shd_clip_circle, "u_alt_circle")
	shader_set_uniform_f(u_circle, _x2, _y2, _size - 1);

	//draw surface
	draw_surface(_surf, min(_x1, _x2) - _s, min(_y1, _y2) - _s)
	surface_free(_surf)

	shader_reset();


}
