/// @description create menu
if !(instance_exists(obj_menu)) {
	//get hex and bubble size
	//var _b = bubble_size
	//var _h = (hex_size + lengthdir_y(hex_size, -30))/2
	
	////get mouse x and y cells
	//var _my = round((mouse_y - y)/(2*_h))
	//var _mx = round((mouse_x - x - _b*((abs(_my) mod 2) == 1))/(2*_b))*2 + ((abs(_my) mod 2) == 1)
	
	var _m = mouse_to_tile(id)
	var _mx = _m[0]
	var _my = _m[1]
	
	var _child = cell_data(id, _mx, _my)
	
	//create the menu object
	with (instance_create_depth(x + _mx*bubble_size, y + _my*hex_size*HEX_MUL, 0, obj_menu)) {
		pos_x = _mx
		pos_y = _my
		child = _child
		spell = other.id
		event_user(0)
	}
}