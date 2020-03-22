/// @description 

draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_colour(c_white)

shader_set(shd_sotn_text)
var _uniform = shader_get_uniform(shd_sotn_text, "u_life")
shader_set_uniform_f(_uniform, life)
_uniform = shader_get_uniform(shd_sotn_text, "u_middle")
shader_set_uniform_f(_uniform, room_width/2)

draw_text_transformed(room_width/2, room_height/2, text, 3, 3, 0)

shader_reset();

life += 1

if (life = 140) {
	life = -40
}
