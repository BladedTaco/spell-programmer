/// A collection of scripts that handle manipulating tile data

/// Functions:
///		set_tile
///		set_tile_output
///		reposition_tile

//--------------------------------------------------------------------------------------------------

///@func set_tile(spell, cell_x, cell_y, tile)
///@param spell - the spell object
///@param cell_x - the x position of the cell
///@param cell_y - the y position of the cell
///@param tile - the type of tile to set to the cell
///@desc handles changing or removing tiles from a given cell, returns the tile id
function set_tile() {

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
				//delete tile, then replace
				set_tile(argument[0], argument[1], argument[2], SPELL.EMPTY)
				return set_tile(argument[0], argument[1], argument[2], argument[3])
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
				input_tile = new_ds_list_size(noone, input_number)
				other.spell[| i] = [argument[3], name, value, ds_list_create(), [_mx, _my], new_ds_list_size(-1, input_number)] 
			}
			return children[| i]
		}
	}
	//	[SPELL.CONSTRUCT_VECTOR, " CONSTRUCT VECTOR ", 0, [6, 7, 8], [-3, 1]],
}

//--------------------------------------------------------------------------------------------------

///@func set_tile_output(spell, source, dest)
///@param spell - the spell object
///@param source - the tile to set the output of
///@param dest - the tile to input into
///@desc sets the output of one tile into another, or removes it if it exists
function set_tile_output() {
	with (argument[0]) { //with the spell object
		//add the input into the spell array
		var _array, _data, _diff;
		_array = spell[| argument[2].index]
		_data = _array[3]
		_diff = false;
		//check if it already exists
		for (var i = argument[2].children_number - 1; i >= 0; i--) {
			if (_data[| i] == argument[1].index) { //connection already exists
				_diff = true;
				//remove the connection and children
				ds_list_delete(_data, i)
				with (argument[2]) {
					children_number--
					ds_list_delete(children, i)
				}
			}
		}
		//if it doesnt already exist, create it
		if (!_diff) {
			//check for lööps brötha
			if (!check_for_loops(argument[0], argument[1], argument[2])) {
				ds_list_add(_data, argument[1].index)
				//set children
				with (argument[2]) {
					ds_list_add(children, argument[1].id)
					children_number++
				}
			}
		}
	
		//recalculate all connectors and update wires
		event_user(1)	
		//update wires
		if (argument[2].type = TYPE.WIRE) {
			//update wire heads |Slightly inefficient, wire paths done twice
			event_user(0)
			for (i = 0; i < array_length_1d(wire_heads); i++) {
				with (wire_heads[i]) {
					event_user(2)	
				}
			}
			if (_diff) check_ports(id)
		}
	}
}

//--------------------------------------------------------------------------------------------------

///@func reposition_tile(tile, new_cell_x, new_cell_y)
///@param tile - the tile object to move
///@param new_cell_x - the x position of the cell to move the tile to
///@param new_cell_y - the y position of the cell to move the tile to
///@desc Moves the tile to the given position, trimming outputs as needed
function reposition_tile() {
	var i, o, _s, _tiles;

	with (argument[0]) {
		//get surrounding tiles
		_tiles = [
					cell_data(spell, pos_x - 2, pos_y),
					cell_data(spell, pos_x + 2, pos_y),
					cell_data(spell, pos_x - 1, pos_y + 1),
					cell_data(spell, pos_x - 1, pos_y - 1),
					cell_data(spell, pos_x + 1, pos_y + 1),
					cell_data(spell, pos_x + 1, pos_y - 1)
				]
			
		//move
		pos_x = argument[1]
		pos_y = argument[2]
		_s = spell.spell[| index]
		_s = _s[@ 4]
		_s[@ 0] = pos_x
		_s[@ 1] = pos_y
	
		//trim outputs
		for (i = 0; i < 6; i++) {
			if (instance_exists(_tiles[i])) {
				with (_tiles[i]) {
					if (cell_distance(pos_x, pos_y, argument[1], argument[2]) > 1) {
						//check for inputs to argument tile
						for (o = 0; o < children_number; o++) {
							if (children[| o] == other.id) {
								set_tile_output(spell, other.id, id)
								break;
							}
						}
						if (o < children_number) continue; //skip rest if above loop broke
						//check for outputs to argument tile
						for (o = 0; o < other.children_number; o++) {
							if (other.children[| o] == id) {
								set_tile_output(spell, id, other.id)
								break;
							}
						}
					}
				}
			}
		}
		//remove port connections that can no longer be made
		check_ports(spell)
	}
			//ds_list_add(spell, [argument[3], "", 0, -1, [_mx, _my], -1])
}
