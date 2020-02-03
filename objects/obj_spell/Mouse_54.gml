/// @description create menu
if !(instance_exists(obj_menu)) {
	//get hex and bubble size
	var _b = bubble_size
	var _h = (hex_size + lengthdir_y(hex_size, -30))/2
	
	//get mouse x and y cells
	var _my = round((mouse_y - y)/(2*_h))
	var _mx = round((mouse_x - x - _b*((abs(_my) mod 2) == 1))/(2*_b))*2 + ((abs(_my) mod 2) == 1)
	
	var _spell = [];
	var _pos = [];
	var _child = noone;
	
	for (var i = 0; i < children_number; i++) {
		_spell = spell[i]
		_pos = _spell[4]
		if ((_pos[0] = _mx) and (_pos[1] = _my)) {
			_child = children[i]
			break;
		}
	}
	
	//create the menu object
	with (instance_create_depth(x + _mx*bubble_size, y + _my*hex_size*1.5, 0, obj_menu)) {
		pos_x = _mx
		pos_y = _my
		child = _child
	}
}