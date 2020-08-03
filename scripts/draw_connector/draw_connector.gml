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
function draw_connector() {

	var _x1, _y1, _x2, _y2, _x3, _y3, _string, _colour, _size, _alt_size, _age, _len, _dir, _off, _spd, _scl;

	var _s = 15


	_x1 = argument[0]
	_y1 = argument[1]
	_x2 = argument[2]
	_y2 = argument[3]
	_x3 = min(_x1, _x2) - _s
	_y3 = min(_y1, _y2) - _s
	_string = argument[4]
	if (_string = "") {
		_string = " "	
	}
	_colour = argument[5]
	_size = argument[6]
	_alt_size = argument[7]
	_age = argument[8]
	_scl = argument[9]
	_len = point_distance(_x1, _y1, _x2, _y2)
	_dir = point_direction(_x1, _y1, _x2, _y2)
	_off = string_width(_string)
	_spd = _off/90



	//set untextured shader
	shader_set(shd_clip_circle_no_tex_rotate)
	var u_circle = shader_get_uniform(shd_clip_circle_no_tex_rotate, "u_alt_circle")
	shader_set_uniform_f(u_circle, _x2, _y2, _size - 1);
	u_circle = shader_get_uniform(shd_clip_circle_no_tex_rotate, "u_circle")
	shader_set_uniform_f(u_circle, _x1, _y1, _alt_size - 1);
	u_circle = shader_get_uniform(shd_clip_circle_no_tex_rotate, "u_dir")
	shader_set_uniform_f(u_circle, -_dir)
	u_circle = shader_get_uniform(shd_clip_circle_no_tex_rotate, "v_circle")
	shader_set_uniform_f(u_circle, _x1, _y1, _alt_size - 1);
	u_circle = shader_get_uniform(shd_clip_circle_no_tex_rotate, "v_dir")
	shader_set_uniform_f(u_circle, -_dir)	


	//draw connector
	draw_set_colour(_colour)
	draw_rectangle(_x1, _y1 - 12*_scl, _x1 + _len, _y1 + 12*_scl, false)

	//draw inner
	draw_set_colour(COLOUR.CONNECTOR)
	draw_rectangle(_x1, _y1 - 9*_scl, _x1 + _len, _y1 + 9*_scl, false)	
		
		
	//get age altered
	_age = _age*_spd mod _off

	shader_reset(); //reset shader

	if (_string != "") {
		//set textured shader
		shader_set(shd_clip_circle_rotate)
		var u_circle = shader_get_uniform(shd_clip_circle_rotate, "u_circle")
		shader_set_uniform_f(u_circle, _x1, _y1, _alt_size - 1);
		u_circle = shader_get_uniform(shd_clip_circle_rotate, "u_alt_circle")
		shader_set_uniform_f(u_circle, _x2, _y2, _size - 1);
		u_circle = shader_get_uniform(shd_clip_circle_rotate, "u_dir")
		shader_set_uniform_f(u_circle, -_dir)
		u_circle = shader_get_uniform(shd_clip_circle_rotate, "v_circle")
		shader_set_uniform_f(u_circle, _x1, _y1, _alt_size - 1);
		u_circle = shader_get_uniform(shd_clip_circle_rotate, "v_dir")
		shader_set_uniform_f(u_circle, -_dir)

		//draw text
		draw_set_colour(_colour)
		draw_set_halign(fa_left)
		draw_set_valign(fa_middle)

		//flip text both ways if left half facing direction
		if (abs(_dir - 180) < 90) {
			draw_set_halign(fa_right)
			var _str = string_repeat(_string, 1 + ceil((_len - _size)/_off)/_scl)
			draw_text_transformed(
				_x1 - _scl*_age,  _y1 + 0.5,
				_str, -_scl, -_scl, 0
			)
			draw_set_halign(fa_left)
		} else { //draw text normally
			var _str = string_repeat(_string, 1 + ceil((_len - _size)/_off)/_scl)
			draw_text_transformed(
				_x1 - _scl*_age,  _y1 + 0.5,
				_str, _scl, _scl, 0
			)
		}
		
		shader_reset();
	}
}
