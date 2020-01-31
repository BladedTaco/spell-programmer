/// @description create menu
if !(instance_exists(obj_menu)) {
	//get hex and bubble size
	var _b = bubble_size
	var _h = (hex_size + lengthdir_y(hex_size, -30))/2
	
	//get mouse x and y cells
	var _my = round((mouse_y - y)/(2*_h))
	var _mx = round((mouse_x - x - _b*((abs(_my) mod 2) == 1))/(2*_b))*2 + ((abs(_my) mod 2) == 1)
	
	//create the menu object
	with (instance_create_depth(x + _mx*bubble_size, y + _my*hex_size*1.5, 0, obj_menu)) {
		pos_x = _mx
		pos_y = _my
		//get the spell part in the cell
		child = instance_nearest(x, y, obj_spell_part_hex)
		if (child != noone) {
			if (point_distance(x, y, child.x, child.y) > 20) {
				child = noone;
			}
		}
	}
}