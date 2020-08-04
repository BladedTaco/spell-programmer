/// @description 
//set dir
var _dir = age
var _sub_dir = sub_age
draw_sprite_ext(spr_add_motion, 0, 25, 25, 1, 1, _dir, c_white, 1)

//create and prep the surface
if (!surface_exists(spell_surface)) {
	spell_surface = surface_create(surface_size, surface_size)	
	half_surface_size = surface_size/2
}
surface_set_target(spell_surface)
draw_clear_alpha(c_black, 0)

var _cx = half_surface_size, _cy = half_surface_size;

//name circle
draw_set_colour(c_black)
draw_circle(_cx, _cy, size + 90, false)
draw_set_colour(COLOUR.SPELL)
draw_text_circle(_cx, _cy, name, size + 10, -_sub_dir[1], 360, true, true)

//name circle outer
draw_set_colour(COLOUR.TRICK)
draw_circle_outline(_cx, _cy, size + 20)
draw_circle_outline(_cx, _cy, size + 90)
	
//icon outer
var _l, _d, _px, _py, _max;
_l = size + 55
_max = floor((_l*3)/sprite_width)
for (i = 0; i < _max; i++) {
	_d = _sub_dir[1] - 360*i/_max
	_px = _cx + lengthdir_x(_l, _d)
	_py = _cy + lengthdir_y(_l, _d)
	draw_sprite_ext(sprite_index, image_index, _px, _py, 1, 1, _d - 90, image_blend, 1)
}
	
	
//hexagons
for (var i = 0; i < children_number; i++) {
	with (children[| i]) {
		//update position
		update_pos()
		//draw backing hexagons
		draw_backing()
	}
}

//connectors
for (var i = 0; i < children_number; i++) {
	with (children[| i]) {
		//draw connectors
		//for (var o = 0; o < children_number; o++) {
		//	with (children[| o]) {
		//		draw_connector(other.x, other.y, x, y, other.connector_name[o], image_blend, size, other.size, spell.age, 1)
		//	}
		//}
		draw_connectors()
	}
}
	
	
var _str;
for (var i = 0; i < children_number; i++) {
	with (children[| i]) {
		//draw circle
		//event_perform(ev_draw, 0)
		draw()
	}
}

//debug, draw tile data
if (keyboard_check(vk_shift) and global.debug) {
	//draw each tiles data
	var _str;
	for (var i = 0; i < children_number; i++) {
		with (children[| i]) {
			draw_debug()
			////draw input list
			//_str = list_to_string(input_tile)
			//draw_set_colour(c_gray)
			//draw_rectangle(x - size, y - size - 15, x - size + string_width(_str), y - size, false)
			//draw_set_colour(c_white)
			//draw_text(x - size, y - size - 8, _str)
			////draw children list
			//_str = list_to_string(children)
			//draw_set_colour(c_gray)
			//draw_rectangle(x - size, y - size - 30, x - size + string_width(_str), y - size-15, false)
			//draw_set_colour(c_white)
			//draw_text(x - size, y - size - 23, _str)
			////draw name
			//_str = string(index) + ": " + string(self.name)
			//draw_set_colour(c_gray)
			//draw_rectangle(x - size, y - size - 45, x - size + string_width(_str), y - size-30, false)
			//draw_set_colour(c_white)
			//draw_text(x - size, y - size - 38, _str)
		}
	}
	//draw wire heads
	for (i = 0; i < array_length(wire_heads); i++) {
		with (wire_heads[i]) {
			draw_sprite(spr_menu_null, 0, x, y)	
		}
	}
}

surface_reset_target();

if (global.shaders) {
	//create and clear surface
	if (!surface_exists(alt_particle_surface)) {
		alt_particle_surface = surface_create(surface_size, surface_size)	
	}
	surface_set_target(alt_particle_surface);
	draw_clear_alpha(c_black, 0)
	
	//do filling (not done on surface)
	draw_set_colour(COLOUR.SPELL)
	draw_circle_outline(_cx, _cy, size)
	shader_set(shd_fill)
	var uniform = shader_get_sampler_index(shd_fill, "u_sampler")
	texture_set_stage(uniform, surface_get_texture(spell_surface))
	uniform = shader_get_uniform(shd_fill, "u_circle")
	shader_set_uniform_f(uniform, _cx, _cy, size - 20)
	uniform = shader_get_uniform(shd_fill, "u_dir")
	shader_set_uniform_f(uniform, (age mod 360)/360)
	uniform = shader_get_uniform(shd_fill, "u_size")
	shader_set_uniform_f(uniform, 20)
	uniform = shader_get_uniform(shd_fill, "u_border")
	shader_set_uniform_f(uniform, 4)
	uniform = shader_get_uniform(shd_fill, "u_border_mul")
	shader_set_uniform_f(uniform, 4)
	uniform = shader_get_uniform(shd_fill, "u_dim")
	shader_set_uniform_f(uniform, surface_size, surface_size)
	draw_rectangle(_cx - size, _cy - size, _cx + size, _cy + size, false)
	shader_reset();
	
	
	surface_reset_target();
	
	surface_set_target(spell_surface)
	draw_surface(alt_particle_surface, 0, 0)
	surface_reset_target();


	//draw noise effect

	//create noise surface if needed
	if (!surface_exists(noise_surface)) {
		//create surface and clear it
		noise_surface = surface_create(surface_size, surface_size)	
	}
	surface_set_target(noise_surface)
	draw_clear_alpha(c_black, 0)
	//randomly populate the surface
	shader_set(shd_perlin_noise)
	var _uniform = shader_get_uniform(shd_perlin_noise, "u_age")
	shader_set_uniform_f(_uniform, true_age/3)
	_uniform = shader_get_uniform(shd_perlin_noise, "u_dim")
	shader_set_uniform_f(_uniform, surface_size)
	draw_rectangle(0, 0, surface_size, surface_size, false)
	shader_reset()
	surface_reset_target();

	if (keyboard_check(vk_space)) {
		draw_surface(noise_surface, 0, 0)
	}

	//create particle surface if needed
	if (!surface_exists(particle_surface)) {
		particle_surface = surface_create(surface_size, surface_size)	
		surface_set_target(particle_surface)
		draw_clear_alpha(c_black, 0)
		surface_reset_target();
	}



	//draw the circle to the surface
	surface_set_target(alt_particle_surface)
	draw_clear_alpha(c_black, 0)
	draw_surface_ext(particle_surface, -x_diff, -y_diff, 1, 1, 0, c_white, 0.99)

	shader_set(shd_random_alpha)
	var _uniform = shader_get_uniform(shd_random_alpha, "u_age")
	shader_set_uniform_f(_uniform, true_age)
	_uniform = shader_get_uniform(shd_random_alpha, "u_alpha")
	shader_set_uniform_f(_uniform, 0.991)
	draw_surface(spell_surface, 0, 0)
	shader_reset();
	surface_reset_target();

	surface_set_target(particle_surface)

	draw_clear_alpha(c_black, 0)


	gpu_set_texfilter(false)
	//draw the next iteration of the particle surface to the alt
	shader_set(shd_noise_movement)
	var _uniform = shader_get_sampler_index(shd_noise_movement, "s_noise")
	texture_set_stage(_uniform, surface_get_texture(noise_surface))
	_uniform = shader_get_sampler_index(shd_noise_movement, "s_particle")
	texture_set_stage(_uniform, surface_get_texture(alt_particle_surface))
	_uniform = shader_get_uniform(shd_noise_movement, "u_dim")
	shader_set_uniform_f(_uniform, surface_size, surface_size)
	_uniform = shader_get_uniform(shd_noise_movement, "mul")
	shader_set_uniform_f(_uniform, 6)
	draw_rectangle(0, 0, surface_size, surface_size, false)
	shader_reset();
	surface_reset_target();
	gpu_set_texfilter(true)

	surface_set_target(alt_particle_surface)
	draw_clear_alpha(c_black, 0)
	shader_set(shd_empty_threshold)
	_uniform = shader_get_uniform(shd_empty_threshold, "u_num")
	shader_set_uniform_f(_uniform, 0.1)
	draw_surface(particle_surface, 0, 0)
	shader_reset();
	surface_reset_target();

	//manipulate noise surface


	shader_set(shd_alpha)
	draw_surface(alt_particle_surface, x - half_surface_size, y - half_surface_size)
	shader_reset();
}

if !(mouse_check_button(mb_middle) and global.debug) {
	//draw the spell_surface
	shader_set(shd_alpha_spell)
	draw_surface(spell_surface, x - half_surface_size, y - half_surface_size)
	shader_reset();
}

x_diff = 0;
y_diff = 0;

if (keyboard_check(vk_shift) and global.debug) {
	//draw the spell objects data
	draw_set_colour(c_white)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	draw_set_alpha(0.7)
	_str = list_to_string(spell, true, false)
	draw_rectangle(10, 100 - age*3*(string_height(_str) div 1000), 10 + string_width(_str), 100 + string_height(_str), false)
	draw_set_alpha(1)
	draw_set_colour(c_black)
	draw_text(10, 100, _str)
}


//highlight cell mouse is in
if (children_number > 0) {
	var _m = mouse_to_tile(id)
	var _mx = _m[0]
	var _my = _m[1]
	draw_set_colour(c_white)
	draw_set_alpha(0.5)
	draw_polygon(x + _mx*bubble_size, y + _my*hex_size*HEX_MUL, hex_size, 90, 6, true)
	draw_set_alpha(1)
}

while (draw_queue_size > 0) {
	draw_queue_size -= 1
	var f = draw_queue[draw_queue_size]
	f()
}

for (var i = 0; i < drag_path_length; i++) {
	drag_path[i].draw()	
}
//draw_set_colour(c_black)
//for (var i = 0; i < 400; i++) {
//	_px = mouse_x + (i%20)*4 - 40
//	_py = mouse_y + (i div 20)*4 - 40
//	if (point_in_hex(_px, _py, x, y, hex_size - 30, 90)) {
//		draw_circle(_px, _py, 1, false)
//	} else {
//		draw_circle(_px, _py, 2, true)
//	}
//}


//if keyboard_check_pressed(vk_up) {
//	surface_save(spell_surface, "output.png")
//}


////circle test debug
//draw_text_circle(
//				50, 100, "01234567", 40,	
//				_dir, 360, true, false, true, true
//			)
//draw_text_circle(
//				150, 100, "0123456789", 40,
//				180, 360, true, false, true, true
//			)
			
//draw_line(0, 100, 300, 100)
//draw_line(50, 0, 50, 200)
//draw_line(150, 0, 150, 200)

//draw_line(0, 50, 150, 200) 
//draw_line(0, 150, 150, 0) 

//draw_line(100, 50, 250, 200) 
//draw_line(100, 150, 250, 0) 