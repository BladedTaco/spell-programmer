/// @description 

//make trick extend out
//after that make nested
//draw everything as a clockwise and anticlocwise surface

	var _dir = spell.age
	
	//backing circle
	draw_set_colour(COLOUR.EMPTY)
	draw_circle(x, y, size, false)
	
	if (colour_cycle) {
		var i = _dir*colour_number div 360
		var o = (_dir*colour_number mod 360)/360
		//smooth out transitions
		if (o < 0.5) {
			o = o*o*o*o //o^4
			o = 8*o //8o^4
		} else {
			o -= 1;
			o = o*o*o*o //(o - 1)^4
			o = 1 - 8*o //1 - 8(o - 1)^4
		}
		image_blend = merge_colour(colours[i], colours[i+1], o)
	}
	
	//draw the sprite
	draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, image_blend, 1)
	
	//draw circle outline
	draw_set_colour(image_blend)
	draw_circle_outline(x, y, size)

	switch (type) {
		case TYPE.WIRE:
		case TYPE.BASIC:
			//draw name and its ring
			draw_text_circle(x, y, name, size - 10, _dir, 360, true)
			draw_circle_outline(x, y, size - 20)
		break;
	
		case TYPE.BIN_COUNTER:
		case TYPE.COUNTER:
			draw_set_colour(image_blend)
			var _str, _sign = -1;
			_str = "0"
			//draw the name and its ring
			var o = string_length(string(value));
			o = 1
			draw_text_circle(x, y, name, size - o*20 - 10, _dir, 360, true)
			draw_circle_outline(x, y, size - o*20 - 20)
			
			bin_value = scr_int_to_bin(value)
			//show_debug_message(value)
			//show_debug_message(bin_value)
			
			//draw the fill bar
			draw_set_colour( - image_blend)
			var _sz = 360/string_length(bin_value)
			for (o = string_length(bin_value)-1; o >= 0; o--) {
				if string_char_at(bin_value, o+1) == 1 {
					//draw the fill bar
					draw_set_colour(image_blend)
					draw_circle_curve(
						x, y, size - 10,
						-o*_sz + _dir*_sign,
						_sz, 21
					)
					//middle light
					draw_set_colour( - image_blend)
					draw_circle_curve(
						x, y, size - 10,
						-o*_sz + _dir*_sign,
						_sz/2, 5
					)
					//text backing circle
					draw_circle(
						x + lengthdir_x(size - 10, 180 + _dir*_sign - (o+0.6)*_sz),
						y + lengthdir_y(size - 10, 180 + _dir*_sign - (o+0.6)*_sz),
						8, false
					)
				}
				//starter
				draw_circle_curve(
					x, y, size - 10,
					-o*_sz + _dir*_sign,
					_sz/5, 19
				)
			}
			
			//draw the ring
			draw_set_colour(image_blend)
			draw_circle_outline(x, y, size - o*20 - 40)
			_sign = -_sign
			
			//draw the text fill
			//draw_set_colour(-image_blend)
			draw_text_circle(
				x, y, bin_value, size - 10,
				-_dir*_sign - _sz/2, 360, true, false, true, true
			)
			
			//draw the start marker
			var _x, _y;
			_x = x + lengthdir_x(size - 7, 180 -_dir*_sign)
			_y = y + lengthdir_y(size - 7, 180 -_dir*_sign)
			draw_set_color(COLOUR.BLACK)
			draw_polygon(_x, _y, 16, -_dir*_sign, 3, true)
			draw_set_colour(COLOUR.MARKER)
			draw_polygon(_x, _y, 8, -_dir*_sign, 3, false, 4)
		
		break;
		//case TYPE.COUNTER:
		//	draw_set_colour(image_blend)
		//	var _str, _sign = -1;
		//	//draw the name and its ring
		//	var o = string_length(string(value));
		//	draw_text_circle(x, y, name, size - o*20 - 10, _dir, 360, true)
		//	draw_circle_outline(x, y, size - o*20 - 20)
		//	//for each ring
		//	for (--o; o >= 0; o--) {
		//		//get the number, direction of rotation, and string
		//		var _num = real(string_char_at(string(value), o+1))
		//		switch (string_length(string(value)) - o) {
		//			case 1:	_str = " ONE "; break;
		//			case 2:	_str = " TEN "; break;	
		//			case 3:	_str = " HUND "; break;
		//			case 4:	_str = " THOUSAND "; break;	
		//			case 5:	_str = " TEN THOU "; break;	
		//			case 6:	_str = " HUND THOU "; break;	
		//			case 7:	_str = " MILLION "; break;
		//			case 8:	_str = " TEN MILLION "; break;
		//			default: _str = " PLEASE JUST STOP "; break;
		//		}
				
		//		//draw the text fill
		//		draw_text_circle(
		//			x, y, string_repeat(_str, 10), size - 10 - o*20,
		//			_dir*_sign, 360, true, false, true
		//		)
		//		//draw the fill bar
		//		draw_circle_curve(
		//			x, y, size - 10 - o*20,
		//			_dir*_sign,
		//			_num*36, 21
		//		)
		//		//draw the ring
		//		draw_circle_outline(x, y, size - o*20 - 20)
		//		_sign = -_sign
		//	}
		//break;
		
		case TYPE.SHELL:
		break;

		case TYPE.TRICK:
		
		case TYPE.CONVERTER:
			
		
			//name and rings
			draw_set_colour(image_blend)
			draw_text_circle(x, y, name, size - 30, _dir, 360, true, true)
			draw_circle_outline(x, y, size - 40)
			draw_circle_outline(x, y, size - 20)
			
			
			//input text
			draw_set_colour(image_blend)
			draw_circle_outline(x, y, size)
			for (var i = 0; i < input_number; i++) {
				draw_set_colour(input_colour[i])
				draw_text_circle(x, y, inputs[i] + "   ", size - 10, -(_dir + zero_angle + (360/input_number)*i - (input_number-2)*180/input_number), 360/input_number, false, true)
			}
		break;
	
	
		default:
			show_debug_message("unexpected type")
		break;
	}
	