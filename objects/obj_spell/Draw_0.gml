/// @description 
if (global.spell_part = obj_spell_part_hex) {
	
	//hexagons
	for (var i = 0; i < children_number; i++) {
		with (children[i]) {
			//update position
			x = spell.x + (bubble_size+6)*pos_x
			y = spell.y + (hex_size+6)*pos_y*1.5
			
			//back polygon backing
			draw_set_colour(COLOUR.EMPTY)
			draw_polygon(x, y, cell_size, 90, 6, true)
			
			//front polygon
			draw_set_colour(image_blend)
			draw_polygon(x, y, cell_size, 90, 6, false)
		}
	}
	
	//connectors
	for (var i = 0; i < children_number; i++) {
		with (children[i]) {
			//draw connectors
			for (var o = 0; o < children_number; o++) {
				with (children[o]) {
					draw_connector(other.x, other.y, x, y, name, image_blend, size, other.size, spell.age, 1)
				}
			}
		}
	}
	
	
	
	for (var i = 0; i < children_number; i++) {
		with (children[i]) {
			//draw circle
			event_perform(ev_draw, 0)
		}
	}
	
}