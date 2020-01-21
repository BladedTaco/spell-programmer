///@func draw_connector(x1, y1, x2, y2, text, colour, size, alt_size, age, scale)
///@param x1
///@param y1
///@param x2
///@param y2
///@param text
///@param colour
///@param size - the size of the endpoint circle
///@param alt_size - the size of the startpoint circle
///@param age - the age of the circle / animation index
///@param scale - the scale of the connector
///@desc draws a connecting rod from point a to b

var _x1, _y1, _x2, _y2, _x3, _y3, _string, _colour, _size, _alt_size, _age, _len, _dir, _off, _spd, _scl;

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
_scl = argument[9]
_len = point_distance(_x1, _y1, _x2, _y2)
_dir = point_direction(_x1, _y1, _x2, _y2)
_off = string_width(_string)
_spd = _off/60



//set untextured shader
shader_set(shd_clip_circle_no_tex)
var u_circle = shader_get_uniform(shd_clip_circle_no_tex, "u_circle")
shader_set_uniform_f(u_circle, _x1, _y1, _alt_size - 1);
u_circle = shader_get_uniform(shd_clip_circle_no_tex, "u_alt_circle")
shader_set_uniform_f(u_circle, _x2, _y2, _size - 1);

//draw connector
draw_set_colour(_colour)
draw_line_width(_x1, _y1, _x2, _y2, 24*_scl)

//draw inner
draw_set_colour(COLOUR.CONNECTOR)
draw_line_width(_x1, _y1, _x2, _y2, 18*_scl)
		
//get age altered
_age = _age*_spd mod _off

shader_reset(); //reset shader

//set textured shader
shader_set(shd_clip_circle)
var u_circle = shader_get_uniform(shd_clip_circle, "u_circle")
shader_set_uniform_f(u_circle, _x1, _y1, _alt_size - 1);
u_circle = shader_get_uniform(shd_clip_circle, "u_alt_circle")
shader_set_uniform_f(u_circle, _x2, _y2, _size - 1);


//draw text
draw_set_colour(_colour)
draw_set_halign(fa_left)
draw_set_valign(fa_middle)
gpu_set_texfilter(false)
draw_text_transformed(
	_x1 + _scl*lengthdir_x(_age - _off, _dir), _y1 + _scl*lengthdir_y(_age - _off, _dir),
	string_repeat(_string, 1 + ceil((_len - _size)/_off)/_scl),
	_scl, _scl, _dir
)
gpu_set_texfilter(true)

shader_reset();