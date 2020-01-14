/// @description 
size = 80
anim_index = 0
sides = 3
trick_sprite = spr_add_motion
trick_string = "ADD MOTION"
sub_sprite = [spr_construct_vector, spr_mana, spr_entity_caster]; //dir mana target
sub_colour = [c_aqua, c_fuchsia, c_green]; //dir mana target
sub_size = [0.5, random(0.5), random(0.5)];
sub_string = ["DIRECTION", "MANA", "TARGET", 9, ""]
sub_name = ["CONSTRUCT VECTOR", "MANA SOURCE", "CASTER"]
sub_string_spaced = []
mana = 37

start_x = x
start_y = y

var _max = array_length_1d(sub_string) - 3
//get total string length
for (var i = 0; i <= _max; i++) {
	sub_string[3] += string_length(sub_string[i])
	sub_string[4] += sub_string[i] + "   "
}

//get spaced sub string
for (i = 0; i <= _max; i++) { 
	//make an exmpty string of spaces
	sub_string_spaced[i] = sub_string[4]
	for (var o = 0; o <= _max; o++) {
		if (i!=o) { //not this one
			sub_string_spaced[i] = string_replace(
				sub_string_spaced[i], 
				sub_string[o], 
				string_repeat(" ", string_length(sub_string[o]))
			)
		}
	}
	
}

draw_set_circle_precision(64)