/// @description create menu
if !(instance_exists(obj_menu)) {
	//get hex and bubble size
	var _b = children[0].bubble_size + 6
	var _h = children[0].hex_size + 6
	
	//get mouse x and y cells
	var _my = round((mouse_y - y)/(2*_b))
	var _mx = round((mouse_x - x - _b*((abs(_my) mod 2) == 1))/(2*_b))*2 + ((abs(_my) mod 2) == 1)
	
	//create the menu object
	with (instance_create_depth(x + _mx*_b, y + _my*_h*1.5, 0, obj_menu)) {
		pos_x = _mx
		pos_y = _my
	}
}