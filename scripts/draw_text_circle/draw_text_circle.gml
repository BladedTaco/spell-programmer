///@func draw_text_circle(x, y, str, radius, initdir, arc*, spaced*, centered*, keep_string*, keep_size*)
///@param x - xposition of the circle
///@param y - yposition of the circle
///@param str - the string
///@param radius - radius of the circle, negative flips the text
///@param initdir - the direction to start from
///@param arc* - (360) how far around the circle
///@param spaced* - (false) if the text should be distributed around the circle
///@param centered* - (true) if it should be centered on the initdir (true), or start from (false)
///@param keep_string* - (false) if the base string should be used for centering
///@param keep_size* - (false) if the letters should keep the original size
///@desc using a shader, draws the string in a circular arc with the given parameters
function draw_text_circle() {

	//define localvars
	var _str = argument[2], _arc = 1, _dir = -argument[4], _spaced = false, _shader = shd_circle;

	//check for arc
	if (argument_count > 5) {
		_arc = argument[5]/360
		//check for spaced
		if (argument_count > 6) {
			_spaced = argument[6]
			_str = string_repeat(_str, max(floor(2*pi*abs(argument[3] + 10)/string_width(_str))*_arc*argument[6], 1))
			//check for centered
			if (argument_count > 7) {
				if (argument[6]) {
					_dir = _dir + _arc*180*!argument[7]
				} else {
					_dir = _dir + radtodeg(string_width(_str)/argument[3]/2*!argument[7])
				}
				//check for keep_string
				if (argument_count > 8) {
					if (argument[8]) {
						_str = argument[2]
					}
					if (argument_count > 9) {
						if (argument[9]) {
							_shader = shd_circle_unscaled
							_str = string_spaced(_str)
						}
					}
				}
			}
		}
	}
	
	//set the shader and its uniforms
	shader_set(_shader)
	var uniform = shader_get_uniform(_shader, "u_circle")
	shader_set_uniform_f(uniform, argument[0], argument[1], argument[3])
	uniform = shader_get_uniform(_shader, "u_dir")
	shader_set_uniform_f(uniform, degtorad(_dir))
	uniform = shader_get_uniform(_shader, "u_size")
	shader_set_uniform_f(uniform, string_width(_str))
	uniform = shader_get_uniform(_shader, "u_arc")
	shader_set_uniform_f(uniform, _arc)
	uniform = shader_get_uniform(_shader, "u_spaced")
	shader_set_uniform_f(uniform, _spaced)
	uniform = shader_get_uniform(_shader, "u_len")
	shader_set_uniform_f(uniform, string_length(_str))

	//draw the text
	draw_text(argument[0], argument[1], _str)
	
	//reset shader
	shader_reset();

}

