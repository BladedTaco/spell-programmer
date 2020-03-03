/// @description 
//set dir
var _dir = age
var _sub_dir = sub_age
draw_sprite_ext(spr_add_motion, 0, 25, 25, 1, 1, _dir, c_white, 1)

//create and prep the surface
if (!surface_exists(spell_surface)) {
	spell_surface = surface_create(surface_size, surface_size)	
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
	if (children[i] != noone) {
		with (children[i]) {
			//update position
			x = other.half_surface_size + bubble_size*pos_x
			y = other.half_surface_size + hex_size*pos_y*1.5
			
			//back polygon backing
			draw_set_colour(COLOUR.EMPTY)
			draw_polygon(x, y, cell_size, 90, 6, true)
			
			//front polygon
			draw_set_colour(image_blend)
			draw_polygon(x, y, cell_size, 90, 6, false)
		}
	}
}
	
//connectors
for (var i = 0; i < children_number; i++) {
	if (children[i] != noone) {
		with (children[i]) {
			//draw connectors
			for (var o = 0; o < children_number; o++) {
				if (children[o] != noone) {
					with (children[o]) {
						draw_connector(other.x, other.y, x, y, name, image_blend, size, other.size, spell.age, 1)
					}
				}
			}
		}
	}
}
	
	
	
for (var i = 0; i < children_number; i++) {
	if (children[i] != noone) {
		with (children[i]) {
			//draw circle
			event_perform(ev_draw, 0)
		}
	}
}
	
for (i = 0; i < array_length_1d(wire_heads); i++) {
	with (wire_heads[i]) {
		draw_sprite(spr_menu_null, 0, x, y)	
	}
}
	
surface_reset_target();
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
shader_set_uniform_f(_uniform, true_age*3)
_uniform = shader_get_uniform(shd_perlin_noise, "u_dim")
shader_set_uniform_f(_uniform, surface_size)
draw_rectangle(0, 0, surface_size, surface_size, false)
shader_reset()
surface_reset_target();


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
	
//draw the spell_surface
shader_set(shd_alpha_spell)
draw_surface(spell_surface, x - half_surface_size, y - half_surface_size)
shader_reset();

x_diff = 0;
y_diff = 0;