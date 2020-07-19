/// @description Insert description here
// You can write your code in this editor
var start = mouse_check_button_pressed(mb_left)

if (start) {
	drag_start_x = mouse_x
	drag_start_y = mouse_y
	drag_last_x = mouse_x
	drag_last_y = mouse_y
	drag_tile = get_mouse_tile(id)
}

drag_diff_x = mouse_x - drag_last_x
drag_diff_y = mouse_y - drag_last_y

if mouse_check_button_released(mb_left) {
	show_debug_message("released")
}

switch (drag_action) {
	case DRAG.NONE: break;
	case DRAG.CONNECTOR:
		if instance_exists(drag_tile) {
			draw_later
				draw_connector(
					mouse_x, mouse_y, x + drag_tile.pos_x*bubble_size, y + drag_tile.pos_y*hex_size*HEX_MUL,
					drag_tile.name, c_white, 40, 20, age, 1
				)
				draw_circle_outline(mouse_x, mouse_y, 20)
				draw_circle_outline(x + drag_tile.pos_x*bubble_size, y + drag_tile.pos_y*hex_size*HEX_MUL, 40)
				
				var _other = get_mouse_tile(id)
				var _m = mouse_to_tile(id, 30)
				if (_other != noone) and (cell_distance(drag_tile.pos_x, drag_tile.pos_y, _other.pos_x, _other.pos_y) == 1) {
					// dragging to populated tile
					hover_time++
					draw_set_colour(_other.image_blend)
					draw_circle_curve(mouse_x, mouse_y, 20, 90, 360*hover_time/hover_max, 20)	
					if (hover_time == hover_max) {
						//add connector to path
						drag_path[drag_path_length] = new connector(
							_other, drag_tile,
							drag_tile.name, /*c_white*/drag_tile.image_blend, 20, 20
						)
						drag_path_length++
						drag_path_length_max = drag_path_length
						obj_tools.set_context()
						
						
						//switch active tile
						drag_tile = _other
					}
				} else if drag_empty and (_m != noone) and (cell_distance(drag_tile.pos_x, drag_tile.pos_y, _m[0], _m[1]) == 1) {
					// dragging to empty tile
					hover_time++
					draw_set_colour(COLOUR.CONNECTOR)
					draw_circle_curve(mouse_x, mouse_y, 20, 90, 360*hover_time/hover_max, 20)	
					if (hover_time == hover_max) {
						//create new tile
						_other = set_tile(id, _m[0], _m[1], SPELL.CONNECTOR)
						//add connector to path
						drag_path[drag_path_length] = new connector(
							_other, drag_tile,
							drag_tile.name, /*c_white*/drag_tile.image_blend, 20, 20
						)
						drag_path_length++
						drag_path_length_max = drag_path_length
						obj_tools.set_context()
						
						//set wire properties
						_other.image_blend = drag_tile.image_blend
						_other.name = drag_tile.name
						
						//switch active tile
						drag_tile = _other
						
					}
				} else {
					hover_time = 0	
				}
				
				//moved to regular draw event
				//for (var i = 0; i < drag_path_length; i++) {
				//	drag_path[i].draw()	
				//}
				
			end_draw_later
		} else {
			x += drag_diff_x
			y += drag_diff_y 
	
			//move any menus
			if (instance_exists(obj_menu)) {
				with (obj_menu) {
					x += other.drag_diff_x
					y += other.drag_diff_y 
				}
			}
		}
	break;
}

drag_last_x = mouse_x
drag_last_y = mouse_y