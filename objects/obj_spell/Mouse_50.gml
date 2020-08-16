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

switch (drag_action) {
	case DRAG.NONE: break;
	case DRAG.CONNECTOR:
		if is_struct(drag_tile) {
			draw_later
				draw_connector(
					mouse_x, mouse_y, x + drag_tile.pos_x*bubble_size, y + drag_tile.pos_y*hex_size*HEX_MUL,
					drag_tile.name, c_white, 40, 20, age, 1
				)
				draw_circle_outline(mouse_x, mouse_y, 20)
				draw_circle_outline(x + drag_tile.pos_x*bubble_size, y + drag_tile.pos_y*hex_size*HEX_MUL, 40)
				
				var _other = get_mouse_tile(id)
				var _m = mouse_to_tile(id, 30)
				if is_struct(_other) and (cell_distance(drag_tile.pos_x, drag_tile.pos_y, _other.pos_x, _other.pos_y) == 1) {
					//check for lööps brötha
					if ((hover_time == 0) and check_for_loops(drag_tile, _other)) {
						//loop found, show connection bad
						hover_time = -infinity
					}
					// dragging to populated tile
					hover_time++
					draw_set_colour(_other.image_blend)
					draw_circle_curve(mouse_x, mouse_y, 20, 90, 360*hover_time/hover_max, 20)	
					if (hover_time == hover_max) {
						//add connector to path
						//drag_path[drag_path_length++] = new connector(drag_tile, _other).override(
						//	drag_tile.name, drag_tile.image_blend, 20, 20, 1
						//)
						drag_path[drag_path_length++] = new connector(drag_tile, _other).connect()
						
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
						_other = set_tile(id, _m[0], _m[1], SPELLS.wire)
						//_other = new_spell_tile(_m[0], _m[1], SPELLS.wire)
						drag_path[drag_path_length++] = _other
						//add connector to path
						drag_path[drag_path_length++] = new connector(drag_tile, _other).connect()
						//drag_path[drag_path_length++] = new connector(drag_tile, _other).override( 
						//	drag_tile.name, /*c_white*/drag_tile.image_blend, 20, 20, 1
						//)
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
				
				//draw cross when can't connect
				if (hover_time < 0) {
					draw_set_colour(c_maroon)
					draw_cross(mouse_x, mouse_y, 20, 3)
				}
				
				
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