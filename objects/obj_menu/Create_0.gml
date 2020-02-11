/// @description 
value = 0;
pos_x = 0;
pos_y = 0;

menu_options = ["1", "2", "3", "4", "5", "6"]
menu_sprite = [spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null]
menu_active = [true, true, true, true, true, true];

//get the length of the menu
menu_length = array_length_1d(menu_active)
while (menu_active[menu_length - 1] == false) {
	menu_length -= 1;	
}

life = 0;