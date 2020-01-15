/// @description 

//make trick extend out
//after that make nested
//draw everything as a clockwise and anticlocwise surface


if (surface_exists(clockwise_surface) and surface_exists(anticlockwise_surface)) {
	var _dir = image_angle;
	shader_set(shd_empty)
	draw_surface_ext(clockwise_surface, x - max_size/2, y - max_size/2, 1, 1, -_dir, c_white, 1)
	draw_surface_ext(anticlockwise_surface, x - max_size/2, y - max_size/2, 1, 1, _dir, c_white, 1)
	shader_reset();
	draw_sprite_ext(sprite_index, 0, x, y, 1, 1, image_angle, image_blend, 1)
} else {
	//handle surfaces
	if (surface_exists(clockwise_surface)) {
		surface_free(clockwise_surface)	
	} 
	if (surface_exists(anticlockwise_surface)) {
		surface_free(anticlockwise_surface)	
	}
	clockwise_surface = surface_create(max_size + 4, max_size + 4)
	anticlockwise_surface = surface_create(max_size + 4, max_size + 4)
	
	
	var _dir = 90// + image_angle;
	var _len = size*2;
	if (visible) {
		x = max_size
		y = max_size
		_dir += spell.age
	}


	real_x = x
	real_y = y
	
	x = max_size/2 + 2
	y = max_size/2 + 2
	//clear surfaces and draw backing
	surface_set_target(clockwise_surface)
	draw_clear_alpha(c_black, 0)
	draw_set_colour(COLOUR.EMPTY)
	draw_circle(x, y, size, false)
	surface_reset_target();
	
	surface_set_target(anticlockwise_surface)
	draw_clear_alpha(c_black, 0)
	draw_set_colour(COLOUR.EMPTY)
	draw_circle(x, y, size, false)
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
			draw_circle(x, y, size, true)
			draw_text_circle_spaced(x, y, name + "   ", size - 10, 180, _dir)
			draw_circle(x, y, size - 20, true)
			
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
					_num*36, 20, 1
				)
				draw_circle(x, y, size - o*20 - 20, true)
				surface_reset_target();
			}
			_sign = sign((o/2 != round(o/2)) - 0.5)
			_sign += (_sign + 1)/2
			if (_sign < 1) {
				surface_set_target(anticlockwise_surface);
			} else {
				surface_set_target(clockwise_surface);
			}
			draw_text_circle_spaced(x, y, name + "   ", size - o*20 - 10, 180, -_dir*_sign)
			draw_circle(x, y, size - o*20 - 20, true)
			surface_reset_target();
		break;
	
		case TYPE.SHELL:
			draw_children();
		break;
	
		case TYPE.TRICK:
		
		case TYPE.CONVERTER:
		
			surface_set_target(anticlockwise_surface);
			//big back disc
			draw_set_colour(COLOUR.EMPTY)
			draw_circle(x, y, size*4 + 5, false)	
		
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
			draw_text_circle_spaced(x, y, obj_spell.name + "   ", size*2.6 + 10, 180, _dir + 60)


			//name circle outer
			draw_set_colour(image_blend)
			draw_circle(x, y, size*2.6 + 20, true)
	
			//icon outer
			var _l, _d, _px, _py, _max;
			_l = size*3.4
			_max = floor((_l*3)/sprite_width)
			for (i = 0; i < _max; i++) {
				_d = -_dir - 360*i/_max
				_px = x + lengthdir_x(_l, _d)
				_py = y + lengthdir_y(_l, _d)
				draw_sprite_ext(sprite_index, image_index, _px, _py, 1, 1, _d - 90, image_blend, 1)
			}

			surface_reset_target();
		
			//outer polygon (sized as triangle)
			//draw_set_colour(COLOUR.EMPTY)
			//draw_polygon(x, y, size*(mouse_x/200), _dir, children_number, true) //outer filled
			//draw_triangle(_px[0], _py[0], _px[1], _py[1], _px[2], _py[2], false);		
		
		
			draw_children(false); //draw child circles
		
		
			//draw outer polygon
		
			//draw_polygon(x, y, size*(mouse_x/200), _dir, children_number, false)
			
			draw_set_colour(COLOUR.EMPTY)
			draw_polygon(x, y, size/cos(degtorad(180/children_number)), _dir + zero_angle + 180/children_number, children_number, true)
		
		
			draw_set_colour(image_blend)
			draw_polygon(x, y, size/cos(degtorad(180/children_number)), _dir + zero_angle + 180/children_number, children_number, false)
			
		
			for (i = 0; i < children_number; i++) {
				with (children[i]) {
					if (children_number = 0) {
						event_perform(ev_draw, 0)
					
						surface_set_target(other.anticlockwise_surface);
						draw_set_colour(COLOUR.EMPTY)
						draw_polygon(x, y, size/cos(degtorad(180/other.children_number)), _dir + (360/other.children_number), other.children_number, true)
						draw_set_colour(other.image_blend)
						draw_polygon(x, y, size/cos(degtorad(180/other.children_number)), _dir + (360/other.children_number), other.children_number, false)
						surface_reset_target()
					} else {
						event_perform(ev_draw, 0)	
					}
				}
			}
		
		
			//name
			surface_set_target(anticlockwise_surface);
			draw_set_colour(image_blend)
			draw_text_circle_spaced(x, y, name + "   ", size - 30, 180, _dir)
			draw_circle(x, y, size - 40, true)
			draw_circle(x, y, size - 20, true)
			surface_reset_target();
			
			
			//input text
			surface_set_target(anticlockwise_surface);
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


	//draw self
	draw_set_colour(image_blend)
	draw_circle(x, y, size, true)
	draw_sprite_ext(sprite_index, 0, x, y, 1, 1, image_angle, image_blend, 1)


	//draw connectors
	for (var i = 0; i <array_length_1d(connector_queue); i++) {
		with (connector_queue[i]) {
			draw_connector(other.x, other.y, x, y, string_replace(name, " ", ""), image_blend, size, other.size, _dir)
		}
	}
	
	x = real_x
	y = real_y
}

if (visible) {
	if (!surface_exists(spell_surface)) {
		spell_surface = surface_create(width, height)
	}
	surface_set_target(spell_surface) 
	draw_clear_alpha(c_black, 0)
}
//draw_surface(clip_surface, 0, 0)






//draw capsule
if (children_number > 0) {
	draw_set_colour(image_blend)
	draw_circle(x, y, size*4, true)	
	if (type = TYPE.TRICK) {
		draw_set_colour(COLOUR.SPELL)
		draw_circle(x, y, max_size, true)
		shader_set(shd_fill)
		var uniform = shader_get_sampler_index(shd_fill, "u_sampler")
		texture_set_stage(uniform, surface_get_texture(clip_surface))
		uniform = shader_get_uniform(shd_fill, "u_circle")
		shader_set_uniform_f(uniform, x, y, max_size - 20)
		uniform = shader_get_uniform(shd_fill, "u_dir")
		shader_set_uniform_f(uniform, (_dir mod 360)/360)
		uniform = shader_get_uniform(shd_fill, "u_size")
		shader_set_uniform_f(uniform, 20)
		uniform = shader_get_uniform(shd_fill, "u_dim")
		shader_set_uniform_f(uniform, width, height)

		draw_rectangle(x - max_size, y - max_size, x + max_size, y + max_size, false)
		shader_reset();
	}
}


//draw connectors
for (var i = 0; i <array_length_1d(connector_queue); i++) {
	with (connector_queue[i]) {
		draw_connector(other.x, other.y, x, y, string_replace(name, " ", ""), image_blend, size, other.size, _dir)
	}
}

if (visible) { //base trick tile
	
	//draw the spell
	surface_reset_target();
	
	shader_set(shd_empty)
	if (keyboard_check(vk_space)) {
		//draw scaled with texture filtering
		gpu_set_texfilter(true)
		draw_surface_ext(spell_surface, 0, 0, mouse_x/500, mouse_x/500, 0, c_white, 1)
		gpu_set_texfilter(false)
	} else {
		//draw centered on mouse
		draw_surface(spell_surface, spell.x - max_size, spell.y - max_size)
		
		with (obj_spell_part) {
			if (point_in_circle(
			mouse_x - (other.spell.x - other.max_size),
			mouse_y - (other.spell.y - other.max_size),
			x, y, size)) {
				bubble_size += 10*(mouse_wheel_up() - mouse_wheel_down())
				bubble_size = max(bubble_size, size)
			}
		}
		if (point_in_circle(
			mouse_x - (spell.x - max_size),
			mouse_y - (spell.y - max_size),
			x, y, size)) {
				bubble_size += 10*(mouse_wheel_up() - mouse_wheel_down())
				bubble_size = max(bubble_size, size)
		}
	}
	shader_reset();
}


draw_text(100, 100, (mouse_x/200))