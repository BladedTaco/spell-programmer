/// @description 
if (!keyboard_check(vk_shift)) {
	age = (age + 1) mod 360
	sub_age[0] = (sub_age[0] + 1/2) mod 360
	sub_age[1] = (sub_age[1] + 1/3) mod 360
	sub_age[2] = (sub_age[2] + 1/4) mod 360
	true_age++;
}

if (update_wires > 0) {
	update_wires--
	if (update_wires = 0) {
		//update wires
		event_user(0)
		for (var i = 0; i < array_length_1d(wire_heads); i++) {
			with (wire_heads[i]) {
				get_wire_data()	
			}
		}	
	}
}

if (keyboard_check_pressed(vk_shift)) {
	for (var i = 0; i < children_number; i++ ) {
		show_debug_message(children[| i])	
	}
}