/// @description 
value = -1;
pos_x = 0;
pos_y = 0;

menu_data = [MENU.TIL, MENU.OUT, MENU.VAL, MENU.NAM, MENU.MOV, MENU.SEL]
menu_options = ["Set Tile", "Set Output", "Set Value", "Set Ports", "Move Tile", "Select Group"]
menu_sprite = [spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null]
menu_active = [true, false, false, false, false, false];
menu_angle = [0, 0, 0, 0, 0, 0];
menu_length = 6;

parent = noone;
child = noone;
active = true;
selected = 0;
spell = noone;

life = 0;
image_alpha = 0

name = string(pos_x) + "," + string(pos_y)
single = false; //only performs a single action

//show_debug_message(id)