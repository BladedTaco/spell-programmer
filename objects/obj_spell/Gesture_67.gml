/// @description drag circle

//move self
x_diff = event_data[? "diffX"]
y_diff = event_data[? "diffY"]
x += x_diff
y += y_diff 
	
//move any menus
if (instance_exists(obj_menu)) {
	with (obj_menu) {
		x += other.x_diff
		y += other.y_diff
	}
}