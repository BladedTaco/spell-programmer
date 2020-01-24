/// @description 

//make trick extend out
//after that make nested
//draw everything as a clockwise and anticlocwise surface

	var _dir = spell.age
	
	//backing circle
	draw_set_colour(COLOUR.EMPTY)
	draw_circle(x, y, size, false)
	
	//draw the sprite
	draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, image_blend, 1)
	
	//draw circle outline
	draw_set_colour(image_blend)
	draw_circle_outline(x, y, size)

	switch (type) {
		case TYPE.BASIC:
			//draw name and its ring
			draw_text_circle_spaced(x, y, name, size - 10, 180, _dir)
			draw_circle_outline(x, y, size - 20)
		break;
	
		case TYPE.COUNTER:
			draw_set_colour(image_blend)
			var _str, _sign = -1;
			//draw the name and its ring
			var o = string_length(string(value));
			draw_text_circle_spaced(x, y, name, size - o*20 - 10, 180, _dir)
			draw_circle_outline(x, y, size - o*20 - 20)
			//for each ring
			for (--o; o >= 0; o--) {
				//get the number, direction of rotation, and string
				var _num = real(string_char_at(string(value), o+1))
				switch (string_length(string(value)) - o) {
					case 1:	_str = "ONE "; break;
					case 2:	_str = "TEN "; break;	
					case 3:	_str = "HUN "; break;
					case 4:	_str = "THO "; break;	
				}
				
				//draw the text fill
				draw_text_circle(
					x, y, string_repeat(_str, 10), size - 10 - o*20,
					180, _dir*_sign
				)
				//draw the fill bar
				draw_circle_curve(
					x,y, size - 10 - o*20,
					(_num/10)*64, -_dir*_sign,
					_num*36, 22, 1
				)
				//draw the ring
				draw_circle_outline(x, y, size - o*20 - 20)
				_sign = -_sign
			}
		break;
		
		case TYPE.SHELL:
		case TYPE.WIRE:
		break;

		case TYPE.TRICK:
		
		case TYPE.CONVERTER:
			
		
			//name and rings
			draw_set_colour(image_blend)
			draw_text_circle_spaced(x, y, name, size - 30, 180, _dir)
			draw_circle_outline(x, y, size - 40)
			draw_circle_outline(x, y, size - 20)
			
			
			//input text
			draw_set_colour(image_blend)
			draw_circle_outline(x, y, size)
			for (var i = 0; i < input_number; i++) {
				draw_set_colour(input_colour[i])
				draw_text_circle(x, y, inputs[i] + "   ", size - 10, 180, -(_dir + zero_angle + (360/children_number)*i - (children_number-2)*180/children_number), 360/children_number, true)
			}
		break;
	
	
		default:
			show_debug_message("unexpected type")
		break;
	}
	