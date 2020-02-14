///@func set_tile(spell, cell_x, cell_y, tile)
///@param spell - the spell object
///@param cell_x - the x position of the cell
///@param cell_y - the y position of the cell
///@param tile - the type of tile to set to the cell
///@desc handles changing or removing tiles from a given cell

var _mx = argument[1]
var _my = argument[2]

with (argument[0]) { //with the spell object
	var _spell = [];
	var _pos = [];
	var _child = noone;
	
	for (var i = 0; i < children_number; i++) {
		_spell = spell[i]
		_pos = _spell[4]
		if ((_pos[0] = _mx) and (_pos[1] = _my)) {
			_child = children[i]
			break;
		}
	}
	
	if (_child = noone) {
		 i = children_number
		 children_number += 1;
		 children[i] = noone;
	}
	
	
	if (instance_exists(_child)) {
		//change the existing tile
		if (argument[3] = SPELL.EMPTY) {
			spell[i] = [argument[3], "NAME", 0, -1, [_mx, _my]]
			//empty tile and spell data from slot
			children[i] = noone;
			instance_destroy(_child)
			if (i = children_number - 1) {
				children_number--	
			}
			size = 10;
			for (i = 0; i < children_number; i++) {
				with (children[i]) {
					other.size = max(other.size, point_distance(0, 0, bubble_size*pos_x, hex_size*pos_y*1.5) + cell_size + 60)	
				}
			}
			
		} else {
			//only update type and name
			var _s = spell[i]
			_s[@ 0] = argument[3]
			_s[@ 1] = "NAME"
			with (children[i]) {
				//get tile data
				tile = argument[3]
				var _array = obj_init.spell_data[tile]

				type = _array[0] 
				sprite_index = _array[1]
				image_blend = _array[2]
				if (array_length_1d(_array) > 4) {
					inputs = _array[3]
					input_colour = _array[4]
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
				other.size = max(other.size, point_distance(0, 0, bubble_size*pos_x, hex_size*pos_y*1.5) + cell_size + 60)
			}
		}
	} else {
		//change/make the entry
		spell[i] = [argument[3], "NAME", 0, -1, [_mx, _my]]
		//make a new tile
		with (instance_create_depth(0, 0, 0, obj_spell_part_hex)) {
			//copypasta
			index = i; //give index
			spell = other.id
			level = 0;
			other.children[i] = id; //give id
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
			other.size = max(other.size, point_distance(0, 0, bubble_size*pos_x, hex_size*pos_y*1.5) + cell_size + 60)
		
		}
	}
}


//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [6, 7, 8], [-3, 1]],