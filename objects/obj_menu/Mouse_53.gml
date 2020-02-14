/// @description - check for selection

if (active) { //if active
	if (point_in_circle(mouse_x, mouse_y, x, y, 80)) { //primary check
		//item check
		var _x, _y, _dir, _sep, i;
		selected = -1;
		_sep = 60//360/menu_length
		for (i = 0; i < menu_length; i++) {
			if (menu_active[i]) {
				_dir = min(life*6*(life/20), 120) - i*_sep - 30 //add a spin out animation
				_x = round(x + lengthdir_x(min(life*3, 60), _dir))
				_y = round(y + lengthdir_y(min(life*3, 60), _dir))
				if (point_in_circle(mouse_x, mouse_y, _x, _y, 20)) {
					selected = i
					break;
				}
			}
		}
	
		//execute menu command
		if (selected >= 0) {
			event_user(1)
		}
	}
}