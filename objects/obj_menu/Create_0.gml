/// @description 
value = 0;
pos_x = 0;
pos_y = 0;

menu_data = [MENU.TIL, MENU.OUT, MENU.VAL, MENU.NAM, MENU.MOV, MENU.SEL]
menu_options = ["Set Tile", "Set Output", "Set Value", "Set Name", "Move Tile", "Select Group"]
menu_sprite = [spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null]
menu_active = [true, false, false, false, false, false];
menu_length = 6;

parent = noone;
child = noone;
active = false;
selected = 0;

life = 0;
image_alpha = 0