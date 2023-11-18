/// @description drag circle

if (movable) {
	//move self
	if (event_data != -1) {
		x_diff = event_data[? "diffX"]
		y_diff = event_data[? "diffY"]
	} else {
		x_diff = drag_diff_x	
		y_diff = drag_diff_y
	}
	
	x += x_diff
	y += y_diff 
	
	//move any menus
	if (instance_exists(obj_menu)) {
		with (obj_menu) {
			x += other.x_diff
			y += other.y_diff
		}
	}
}