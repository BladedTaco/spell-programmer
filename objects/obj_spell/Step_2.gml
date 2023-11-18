
if (true_age > 3) {

if (mouse_check_button_pressed(mb_left) or mouse_check_button(mb_left)) {
	//event_perform(ev_mouse, ev_global_left_button)	
	event_perform(ev_gesture, ev_global_gesture_dragging)
}
if (mouse_check_button_released(mb_left)) {
	event_perform(ev_mouse, ev_global_left_release)	
}

if (!menu_exists and mouse_check_button_pressed(mb_right)) {
	event_perform(ev_mouse, ev_global_right_press)	
}
}