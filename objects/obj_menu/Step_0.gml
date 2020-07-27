/// @description 
if (is_struct(child)) {
	with (child) {
		//value += (keyboard_check(vk_up) - keyboard_check(vk_down))*power(10, other.value)
		
		//if (radius = 1) { //small counter
		//	value = clamp(value, 0, 99) //must be between 0 and 1-hundred million
		//} else { //big counter
		//	value = clamp(value, 0, 99999999) //must be between 0 and 1-hundred million
		//}
		

		//other.value += keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left)
		//other.value = clamp(other.value, 0, 10)
		if (type = TYPE.COUNTER) {
			size = COUNTER_SIZE
			cell_size = size*2/sqrt(3)
		}
	}
}

life++;

