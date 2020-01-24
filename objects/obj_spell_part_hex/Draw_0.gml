/// @description 

//make trick extend out
//after that make nested
//draw everything as a clockwise and anticlocwise surface


if (surface_exists(clockwise_surface) and surface_exists(anticlockwise_surface)) {
	x = spell.x + bubble_size*pos_x
	y = spell.y + hex_size*pos_y*1.5

	//set variables
	var _dir = spell.age*visible;
	var _mid = max_size/2 + 2
	var _x1, _y1, _x2, _y2;
	//get offset to draw surfaces at
	_x1 = _mid - lengthdir_x(sqrt(2)*(max_size+5),- _dir + 135)/2
	_y1 = _mid - lengthdir_y(sqrt(2)*(max_size+5), -_dir + 135)/2
	_x2 = _mid - lengthdir_x(sqrt(2)*(max_size+5), _dir + 135)/2
	_y2 = _mid - lengthdir_y(sqrt(2)*(max_size+5), _dir + 135)/2
	
	//create circle surface and clear it
	if (!surface_exists(circle_surface)) {
		circle_surface = surface_create(max_size + 4, max_size + 4)	
	}
	surface_set_target(circle_surface)
	draw_clear_alpha(c_black, 0)

	//back polygon
	draw_set_colour(COLOUR.EMPTY)
	draw_polygon(_mid, _mid, hex_size, 90, 6, true)
	
	//set the shader and draw the surfaces
	shader_set(shd_surface_empty)
	draw_surface_ext(clockwise_surface, _x1, _y1, 1, 1, -_dir + 180, c_white, 1)
	draw_surface_ext(anticlockwise_surface, _x2, _y2, 1, 1, _dir + 180, c_white, 1)
	shader_reset();

	//front polygon
	draw_set_colour(image_blend)
	draw_polygon(_mid, _mid, hex_size, 90, 6, false)

	//draw the sprite
	gpu_set_texfilter(false)
	draw_sprite_ext(sprite_index, 0, _mid, _mid, 1, 1, 0, image_blend, 1)
	
	
	//reset the draw target and draw the surface
	surface_reset_target();
	
	draw_circle(x, y, size, true)
	shader_set(shd_empty)
	draw_surface_ext(circle_surface, x - _mid*image_xscale, y - _mid*image_xscale, image_xscale, image_xscale, 0, c_white, 1)
	shader_reset()
	gpu_set_texfilter(true)

	//draw connectors
	for (var i = 0; i < children_number; i++) {
		with (children[i]) {
			draw_connector(other.x, other.y, x, y, name, image_blend, size, other.size*other.image_xscale, _dir, 1)
		}
	}
	draw_surface(clockwise_surface, 50, 50)
	draw_surface(anticlockwise_surface, 500, 500)
	
} else {
	max_size = hex_size*2
	//handle surfaces
	if (surface_exists(clockwise_surface)) {
		surface_free(clockwise_surface)	
	} 
	if (surface_exists(anticlockwise_surface)) {
		surface_free(anticlockwise_surface)	
	}
	clockwise_surface = surface_create(max_size + 4, max_size + 4)
	anticlockwise_surface = surface_create(max_size + 4, max_size + 4)
	
	
	var _dir = 0

	x = abs(max_size)/2 + 2
	y = abs(max_size)/2 + 2
	//clear surfaces and draw backing
	surface_set_target(clockwise_surface)
	draw_clear_alpha(c_black, 0)
	draw_set_colour(COLOUR.EMPTY)
	draw_circle(x, y, size, false)
	draw_set_colour(image_blend)
	draw_circle_outline(x, y, size)
	surface_reset_target();

	//clear connector queue
	connector_queue = [];

	switch (type) {
		case TYPE.BASIC:
		
			surface_set_target(clockwise_surface)
	
			//circles
			draw_set_colour(COLOUR.EMPTY)
			draw_circle(x, y, size, false)
			draw_set_colour(image_blend)
			draw_circle_outline(x, y, size)
			draw_text_circle_spaced(x, y, name, size - 10, 180, _dir)
			draw_circle_outline(x, y, size - 20)
			
			surface_reset_target();
	
		break;
	
		case TYPE.COUNTER:
			draw_set_colour(image_blend)
			var _str;
			for (var o = 0; o < string_length(string(value)); o++) {
				//counter
				var _num = real(string_char_at(string(value), o+1))
				var _sign = sign((o/2 != round(o/2)) - 0.5)
				_sign += (_sign + 1)/2
				switch (string_length(string(value)) - o) {
					case 1:	_str = "ONE "; break;
					case 2:	_str = "TEN "; break;	
					case 3:	_str = "HUN "; break;
					case 4:	_str = "THO "; break;	
				}
				if (_sign < 1) {
					surface_set_target(anticlockwise_surface);
				} else {
					surface_set_target(clockwise_surface);
				}
				
				draw_text_circle(
					x, y, string_repeat(_str, 10), size - 10 - o*20,
					180, -_dir*_sign
				)
				draw_circle_curve(
					x,y, size - 10 - o*20,
					(_num/10)*64, _dir*_sign,
					_num*36, 22, 1
				)
				draw_circle_outline(x, y, size - o*20 - 20)
				surface_reset_target();
			}
			_sign = sign((o/2 != round(o/2)) - 0.5)
			_sign += (_sign + 1)/2
			if (_sign < 1) {
				surface_set_target(anticlockwise_surface);
			} else {
				surface_set_target(clockwise_surface);
			}
			draw_text_circle_spaced(x, y, name, size - o*20 - 10, 180, -_dir*_sign)
			draw_circle_outline(x, y, size - o*20 - 20)
			surface_reset_target();
		break;
	
		case TYPE.SHELL:
			
		break;
	
		case TYPE.TRICK:
		
		case TYPE.CONVERTER:
			
		
			//name
			surface_set_target(clockwise_surface);
			draw_set_colour(image_blend)
			draw_text_circle_spaced(x, y, name, size - 30, 180, _dir)
			draw_circle_outline(x, y, size - 40)
			draw_circle_outline(x, y, size - 20)
			surface_reset_target();
			
			
			//input text
			surface_set_target(anticlockwise_surface);
			draw_set_colour(image_blend)
			draw_circle_outline(x, y, size)
			for (var i = 0; i < input_number; i++) {
				draw_set_colour(input_colour[i])
				draw_text_circle(x, y, inputs[i] + "   ", size - 10, 180, -(_dir + zero_angle + (360/children_number)*i - (children_number-2)*180/children_number), 360/children_number, true)
			}
			surface_reset_target();
		break;
	
	
		default:
			show_debug_message("unexpected type")
		break;
	}
}