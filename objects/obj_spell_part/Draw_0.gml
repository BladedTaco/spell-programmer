/// @description 

//make trick extend out
//after that make nested
//draw everything as a clockwise and anticlocwise surface


if (surface_exists(clockwise_surface) and surface_exists(anticlockwise_surface)) {
	if (visible) {
		x = mouse_x
		y = mouse_y
	}
	
	draw_children_new(false)

	//set variables
	var _dir = image_angle + spell.age*visible;
	var _off = 1 + (children_number == 0) //make revolving children appear to be rotating better
	var _mid = max_size/2 + 2
	var _x1, _y1, _x2, _y2;
	//get offset to draw surfaces at
	_x1 = _mid - lengthdir_x(sqrt(2)*(max_size+5),- _dir + 135)/2
	_y1 = _mid - lengthdir_y(sqrt(2)*(max_size+5), -_dir + 135)/2
	_x2 = _mid - lengthdir_x(sqrt(2)*(max_size+5), _dir*_off + 135)/2
	_y2 = _mid - lengthdir_y(sqrt(2)*(max_size+5), _dir*_off + 135)/2
	
	//create circle surface and clear it
	if (!surface_exists(circle_surface)) {
		circle_surface = surface_create(max_size + 4, max_size + 4)	
	}
	surface_set_target(circle_surface)
	draw_clear_alpha(c_black, 0)
	
	//set the shader and draw the surfaces
	shader_set(shd_surface_empty)
	draw_surface_ext(clockwise_surface, _x1, _y1, 1, 1, -_dir + 180, c_white, 1)
	draw_surface_ext(anticlockwise_surface, _x2, _y2, 1, 1, _dir*_off + 180, c_white, 1)
	shader_reset();

	//draw the sprite
	gpu_set_texfilter(false)
	draw_sprite_ext(sprite_index, 0, _mid, _mid, 1, 1, image_angle - 180*(!visible), image_blend, 1)
	
	
	//reset the draw target and draw the surface
	surface_reset_target();
	
	shader_set(shd_empty)
	draw_surface_ext(circle_surface, x - _mid*image_xscale, y - _mid*image_xscale, image_xscale, image_xscale, 0, c_white, 1)
	shader_reset()
	gpu_set_texfilter(true)
	
	
	
	for (i = 0; i < children_number; i++) {
		with (children[i]) {
			event_perform(ev_draw, 0)	
		}
	}
	
	
	//draw connectors
	for (var i = 0; i < array_length_1d(connector_queue); i++) {
		with (connector_queue[i]) {
			draw_connector(other.x, other.y, x, y, name, image_blend, size*image_xscale*(1 + 3*(children_number > 0)), other.size*other.image_xscale, _dir, 1/(1+other.level*0.5))
		}
	}
	
} else {
	
	image_xscale = 1/power(2, level)
	
	//handle surfaces
	if (surface_exists(clockwise_surface)) {
		surface_free(clockwise_surface)	
	} 
	if (surface_exists(anticlockwise_surface)) {
		surface_free(anticlockwise_surface)	
	}
	clockwise_surface = surface_create(max_size + 4, max_size + 4)
	anticlockwise_surface = surface_create(max_size + 4, max_size + 4)
	
	
	var _dir = 90
	var _len = size*2;

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
			draw_children();
			var _len = size*4
			var _dir = image_angle + 90 //make sure its done clockwise
	
			var _mul = 1 - size_ratio //value from 0.5 - 1
			//connector rods
			if (_mul > 0.5) {//not max size
				//draw_connector()
			
			}
		
		
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
			draw_children();
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
			draw_children();
		break;
	
		case TYPE.TRICK:
		
		case TYPE.CONVERTER:
		
			surface_set_target(clockwise_surface);
			//big back disc
			draw_set_colour(COLOUR.EMPTY)
			draw_circle(x, y, size*4 + 5, false)	
			draw_set_colour(image_blend)
			draw_circle_outline(x, y, size*4)
		
			surface_reset_target()
			
			surface_set_target(anticlockwise_surface);
			//name circle
			draw_set_colour(image_blend)
			draw_circle(x, y, size*2.6, false)
			draw_set_colour(COLOUR.EMPTY)
			draw_circle(x, y, size*2.6 - 10, false)
		
			draw_set_colour(image_blend)
			shader_set(shd_inner_fill)
			var uniform = shader_get_uniform(shd_inner_fill, "u_circle")
			shader_set_uniform_f(uniform, x, y, size*2.6 - 5)
			uniform = shader_get_uniform(shd_inner_fill, "u_dir")
			shader_set_uniform_f(uniform, (_dir mod 360)/360)
			uniform = shader_get_uniform(shd_inner_fill, "u_size")
			shader_set_uniform_f(uniform, 10)

			draw_rectangle(x - size*2.6, y - size*2.6, x + size*2.6, y + size*2.6, false)
			shader_reset();
		
			surface_reset_target()
		

			//name
			surface_set_target(clockwise_surface);
			draw_set_colour(COLOUR.SPELL)
			draw_text_circle_spaced(x, y, obj_spell.name, size*2.6 + 10, 180, _dir + 60)


			//name circle outer
			draw_set_colour(image_blend)
			draw_circle_outline(x, y, size*2.6 + 20)
	
			//icon outer
			var _l, _d, _px, _py, _max;
			_l = size*3.4
			_max = floor((_l*3)/sprite_width*image_xscale)
			for (i = 0; i < _max; i++) {
				_d = -_dir - 360*i/_max
				_px = x + lengthdir_x(_l, _d)
				_py = y + lengthdir_y(_l, _d)
				draw_sprite_ext(sprite_index, image_index, _px, _py, 1, 1, _d - 90, image_blend, 1)
			}

			surface_reset_target();
		
			draw_children(false); //draw child circles
		
		
			if (!surface_exists(anticlockwise_surface)) {
				exit;	
			}
			
			//draw outer polygon
		var _d = 90 + zero_angle//dont know why this is needed, but polygons are offset otherwise
		_l = cos(degtorad(180/children_number))
			//draw_polygon(x, y, size*(mouse_x/200), _dir, children_number, false)
			
			draw_set_colour(COLOUR.EMPTY)
			draw_polygon(x, y, size/_l, _d, children_number, true)
		
		
			draw_set_colour(image_blend)
			draw_polygon(x, y, size/_l, _d, children_number, false)
			
		
			for (i = 0; i < children_number; i++) {
				with (children[i]) {
					if (children_number = 0) {
						event_perform(ev_draw, 0)
						
						get_rel_pos(other.id, i)
						
						surface_set_target(other.anticlockwise_surface);
						draw_set_colour(COLOUR.EMPTY)
						draw_polygon(x, y, size/_l, _d, other.children_number, true)
						draw_set_colour(other.image_blend)
						draw_polygon(x, y, size/_l, _d, other.children_number, false)
						surface_reset_target()
					} else {
						event_perform(ev_draw, 0)	
					}
				}
			}
		
		
			//name
			surface_set_target(clockwise_surface);
			draw_set_colour(image_blend)
			draw_text_circle_spaced(x, y, name, size - 30, 180, _dir)
			draw_circle_outline(x, y, size - 40)
			draw_circle_outline(x, y, size - 20)
			surface_reset_target();
			
			
			//input text
			surface_set_target(anticlockwise_surface);
			draw_set_colour(COLOUR.SURFACE_EMPTY)
			draw_polygon(x, y, size/cos(degtorad(180/children_number)), _dir + zero_angle + 180/children_number, children_number, true)
			draw_set_colour(image_blend)
			draw_polygon(x, y, size/cos(degtorad(180/children_number)), _dir + zero_angle + 180/children_number, children_number, false)
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