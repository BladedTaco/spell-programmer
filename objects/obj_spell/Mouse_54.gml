/// @description create menu
if (menu_available and !instance_exists(obj_menu)) {
	var _m = mouse_to_tile(id)
	var _mx = _m[0]
	var _my = _m[1]
	
	//create the menu object
	instance_create_depth(x + _mx*bubble_size, y + _my*hex_size*HEX_MUL, 0, obj_menu).init(id, _mx, _my)
}