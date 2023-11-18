/// @description 
value = -1;
pos_x = 0;
pos_y = 0;

menu_data = [MENU.TIL, MENU.OUT, MENU.VAL, MENU.NAM, MENU.MOV, MENU.SEL]
menu_options = ["Set Tile", "Set Output", "Set Value", "Set Ports", "Move Tile", "Select Group"]
menu_sprite = [spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null]
menu_active = [true, false, false, false, false, false];
menu_angle = [0, 0, 0, 0, 0, 0];
menu_length = 5;

parent = noone;
child = noone;
active = true;
selected = 0;
spell = noone;
left_click_action = false;
left_click_only = true;

life = 0;
image_alpha = 0

name = string(pos_x) + "," + string(pos_y)
single = false; //only performs a single action
group = -1;

///@func init(spell, pos_x, pos_y)
///@param spell - the spell object
///@param pos_x - the x coordinate of the menu child tile
///@param pos_y - the y coordinate of the menu child tile
///@desc properly initializes the base menu tile
init = function(_spell, _x, _y) {
	pos_x = _x
	pos_y = _y
	spell = _spell
	child = cell_data(spell, _x, _y)
	if (is_struct(child)) {
		menu_active[0] = !child.immutable //cant change immutable tiles
		menu_active[1] = child.type != TYPE.TRICK; //Set Output - not a trick tile
		menu_active[2] = child.variable_size; //Set Value - Counters only
		menu_active[3] = (child.input_number > 0); //Set Ports - Takes Inputs
		menu_active[4] = !child.immutable; //Move Tile - there is a child
		//menu_active[5] = !child.immutable; //Select Group - there is a child
	}
	//get the length of the menu
	menu_length = array_length(menu_active)
	while (menu_active[menu_length - 1] == false) {
		menu_length -= 1;	
	}

	name = string(pos_x) + "," + string(pos_y)
	active = true;
	life = 0;
}

///@func get_menu(child)
///@param child - the child the menu is responsible for
///@desc returns the menu object for the child, if there are multiple retuns first found
get_menu = function(_child) {
	with (obj_menu) {
		if (child == _child) {
			return id	
		}
	}
}