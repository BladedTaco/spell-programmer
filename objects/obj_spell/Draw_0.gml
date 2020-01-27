/// @description 
if (global.spell_part = obj_spell_part_hex) {
	
	if (!surface_exists(spell_surface)) {
		spell_surface = surface_create(room_width, room_height)	
	}
	
	surface_set_target(spell_surface)
	draw_clear_alpha(c_black, 0)
	
	//shell
	var _dir = age
	//name circle
	draw_set_colour(c_black)
	draw_circle(x, y, size + 90, false)
	draw_set_colour(COLOUR.SPELL)
	draw_text_circle_spaced(x, y, name, size + 10, 180, _dir + 60)

	//name circle outer
	draw_set_colour(COLOUR.TRICK)
	draw_circle(x, y, size + 20, true)
	draw_circle(x, y, size + 90, true)
	
	//icon outer
	var _l, _d, _px, _py, _max;
	_l = size + 55
	_max = floor((_l*3)/sprite_width)
	for (i = 0; i < _max; i++) {
		_d = -_dir - 360*i/_max
		_px = x + lengthdir_x(_l, _d)
		_py = y + lengthdir_y(_l, _d)
		draw_sprite_ext(sprite_index, image_index, _px, _py, 1, 1, _d - 90, image_blend, 1)
	}
	
	
	//hexagons
	for (var i = 0; i < children_number; i++) {
		with (children[i]) {
			//update position
			x = spell.x + (bubble_size+6)*pos_x
			y = spell.y + (hex_size+6)*pos_y*1.5
			
			//back polygon backing
			draw_set_colour(COLOUR.EMPTY)
			draw_polygon(x, y, cell_size, 90, 6, true)
			
			//front polygon
			draw_set_colour(image_blend)
			draw_polygon(x, y, cell_size, 90, 6, false)
		}
	}
	
	//connectors
	for (var i = 0; i < children_number; i++) {
		with (children[i]) {
			//draw connectors
			for (var o = 0; o < children_number; o++) {
				with (children[o]) {
					draw_connector(other.x, other.y, x, y, name, image_blend, size, other.size, spell.age, 1)
				}
			}
		}
	}
	
	
	
	for (var i = 0; i < children_number; i++) {
		with (children[i]) {
			//draw circle
			event_perform(ev_draw, 0)
		}
	}
	
	
	
	
	
	
	surface_reset_target();
	
	
	//do filling (not done on surface)
	draw_set_colour(COLOUR.SPELL)
	draw_circle(x, y, size, true)
	shader_set(shd_fill)
	var uniform = shader_get_sampler_index(shd_fill, "u_sampler")
	texture_set_stage(uniform, surface_get_texture(spell_surface))
	uniform = shader_get_uniform(shd_fill, "u_circle")
	shader_set_uniform_f(uniform, x, y, size - 20)
	uniform = shader_get_uniform(shd_fill, "u_dir")
	shader_set_uniform_f(uniform, (age mod 360)/360)
	uniform = shader_get_uniform(shd_fill, "u_size")
	shader_set_uniform_f(uniform, 20)
	uniform = shader_get_uniform(shd_fill, "u_dim")
	shader_set_uniform_f(uniform, room_width, room_height)
	draw_rectangle(x - size, y - size, x + size, y + size, false)
	shader_reset();
	
	//draw the spell_surface
	shader_set(shd_empty)
	draw_surface(spell_surface, 0, 0)
	shader_reset();
	
}