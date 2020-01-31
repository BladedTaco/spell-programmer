/// @description 
if (instance_exists(child)) {
	with (child) {
		var _chonk = false;
		if (value < 100) {
			_chonk = true
		}
		value += (keyboard_check(vk_up) - keyboard_check(vk_down))*power(10, other.value)
		value = clamp(value, 0, 99999999) //must be between 0 and 1-hundred million
		if ((value >= 100) and _chonk) {
			if (
				  cell_empty(pos_x - 2, pos_y) 
				+ cell_empty(pos_x - 1, pos_y - 1)
				+ cell_empty(pos_x + 1, pos_y - 1)
				+ cell_empty(pos_x + 2, pos_y)
				+ cell_empty(pos_x + 1, pos_y + 1)
				+ cell_empty(pos_x - 1, pos_y + 1) > 0
			) { //space not available
				value = 99
			}
		}
		other.value += keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left)
		other.value = clamp(other.value, 0, 10)
		if (type = TYPE.COUNTER) {
			size = base_size + string_length(string(value))*20
			cell_size = size*2/sqrt(3)
		}
	}
}