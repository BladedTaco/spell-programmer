/// @description drag circle

if (!instance_exists(obj_menu)) {
	x_diff = event_data[? "diffX"]
	y_diff = event_data[? "diffY"]
	x += x_diff
	y += y_diff 
}