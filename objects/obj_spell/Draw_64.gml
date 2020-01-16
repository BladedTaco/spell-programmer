/// @description 
draw_sprite_ext(spr_add_motion, 0, 50, 50, 4, 4, age, c_white, 1)


for (var i = 0; i < instance_number(obj_spell_part); i++) {
	with (instance_find(obj_spell_part, i)) {
		if (bubble_size > size) {
			draw_healthbar(0, i*20, 100, i*20 + 20, 5*bubble_size/size, image_blend, c_red, c_white, 0, true, false)
		}
	}
}