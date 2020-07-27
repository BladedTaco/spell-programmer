/// @description handle base menu option disabling

/*
menu_options = ["Set Tile", "Set Output", "Set Value", "Set Name", "Move Tile", "Select Group"]
menu_sprite = [spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null]
menu_active = [true, false, false, false, false, false];
*/

if (is_struct(child)) {
	menu_active[1] = child.type != TYPE.TRICK; //Set Output - not a trick tile
	menu_active[2] = child.type = TYPE.COUNTER; //Set Value - Counters only
	menu_active[3] = (array_length_1d(child.inputs) > 0); //Set Ports - Takes Inputs
	menu_active[4] = true; //Move Tile - there is a child
	menu_active[5] = true; //Select Group - there is a child
}
//get the length of the menu
menu_length = array_length_1d(menu_active)
while (menu_active[menu_length - 1] == false) {
	menu_length -= 1;	
}

name = string(pos_x) + "," + string(pos_y)