///@func set_tile(spell, cell_x, cell_y, tile)
///@param spell - the spell object
///@param cell_x - the x position of the cell
///@param cell_y - the y position of the cell
///@param tile - the type of tile to set to the cell
///@desc handles changing or removing tiles from a given cell, returns the tile id

var _mx = argument[1]
var _my = argument[2]

with (argument[0]) { //with the spell object
	
	var _child = cell_data(id, _mx, _my)
	var i = 0;

	if (instance_exists(_child)) { //tile currently in space
		//change the existing tile
		if (argument[3] = SPELL.EMPTY) {
			//destroy the child (it handles its own cleanup)
			instance_destroy(_child)
			//calculate new size 
			size = 10;
			for (i = 0; i < children_number; i++) {
				with (children[| i]) {
					other.size = max(other.size, point_distance(0, 0, bubble_size*pos_x, hex_size*pos_y*HEX_MUL) + cell_size + 60)	
				}
			}
			return noone; //return no tile
		} else {
			//only update type and name
			var _s = spell[| i]
			_s[@ 0] = argument[3]
			with (children[| i]) {
				value = 0
				//get tile data
				tile = argument[3]
				var _array = obj_init.spell_data[tile]

				_s[@ 1] = _array[3]
				type = _array[0] 
				sprite_index = _array[1]
				image_blend = _array[2]
				name = _array[3]
				if (array_length_1d(_array) > 5) {
					inputs = _array[4]
					input_colour = _array[5]
					input_number = array_length_1d(inputs)
				}
			
				//handle size
				size = base_size;
				if (type = TYPE.COUNTER) {
					size = base_size + string_length(string(value))*20
					if (value >= 100) {
						radius = 2;
					}
				} else if (type != TYPE.BASIC) {
					if (type = TYPE.WIRE) {
						size -= 20
					} else {
						size += 20	
					}
				}
				cell_size = size*2/sqrt(3)
				other.size = max(other.size, point_distance(0, 0, bubble_size*pos_x, hex_size*pos_y*HEX_MUL) + cell_size + 60)
			}
			return children[| i] //return the given tile
		}
	} else { //no tile currently in space
		//create a new entry
		i = children_number;
		children_number += 1;
		//check for error
		if (argument[3] = SPELL.EMPTY) {
			show_debug_message("DELETING EMPTY TILE")	
			return noone
		}
		//change/make the entry
		ds_list_add(spell, [argument[3], "", 0, -1, [_mx, _my], -1])
		//make a new tile
		with (instance_create_depth(0, 0, 0, obj_spell_part_hex)) {
			ds_list_add(other.children, id) //give id
			//copypasta
			index = i; //give index
			spell = other.id
			level = 0;
			event_user(0) //get data
			//get bubble size
			if (size > other.bubble_size) {
				if (type != TYPE.COUNTER) {
					other.bubble_size = size
				}
			}
			
			//copypasta pt 2
			bubble_size = other.bubble_size 
			hex_size = other.hex_size 
			cell_size = size*2/sqrt(3)
			other.size = max(other.size, point_distance(0, 0, bubble_size*pos_x, hex_size*pos_y*HEX_MUL) + cell_size + 60)
			//update entry
			children = ds_list_create()
			other.spell[| i] = [argument[3], name, value, ds_list_create(), [_mx, _my], ds_list_create()] 
		}
		return children[| i]
	}
}


//	[SPELL.CONSTRUCT_VECTOR, " CONSTRUCT VECTOR ", 0, [6, 7, 8], [-3, 1]],