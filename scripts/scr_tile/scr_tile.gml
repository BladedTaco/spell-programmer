/// A collection of scripts that handle manipulating tile data

/// Functions:
///		set_tile
///		reposition_tile
///		expand_tile
///		shrink_tile

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

		if (is_struct(_child)) { //tile currently in space
			//change the existing tile
			if (argument[3] = SPELLS.empty) {
				//destroy the child (it handles its own cleanup)
				_child.destroy()
				return noone; //return no tile
			} else {
				//delete tile, then replace
				set_tile(argument[0], argument[1], argument[2], SPELLS.empty)
				return set_tile(argument[0], argument[1], argument[2], argument[3])
			}
		} else { //no tile currently in space
			//create a new entry
			i = children_number;
			children_number += 1;
			//check for error
			if (argument[3] = SPELLS.empty) {
				show_debug_message("DELETING EMPTY TILE")	
				return noone
			}
			//change/make the entry
			ds_list_add(spell, [argument[3], "", 0, -1, [_mx, _my], -1])
			//make a new tile and return it
			return new_spell_tile(_mx, _my, argument[3], i)
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
	var i, o, _tiles;

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
			
		//move data
		move(argument[1], argument[2])
		
		//trim outputs
		for (i = 0; i < 6; i++) {
			if (is_struct(_tiles[i])) {
				with (_tiles[i]) {
					if (cell_distance(pos_x, pos_y, argument[1], argument[2]) > 1) {
						//check for inputs to argument tile
						for (o = 0; o < children_number; o++) {
							if (children[| o] == other) {
								set_tile_output(other, self)
								break;
							}
						}
						if (o < children_number) continue; //skip rest if above loop broke
						//check for outputs to argument tile
						for (o = 0; o < other.children_number; o++) {
							if (other.children[| o] == self) {
								set_tile_output(self, other)
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

//--------------------------------------------------------------------------------------------------

///@func expand_tile()
///@desc expands a tile by 1 radius, call with the tile
function expand_tile () {
	if cell_ring_empty(spell, pos_x, pos_y, radius, false) and (radius < max_radius) {
		radius++
		var _tiles = cell_ring_values(pos_x, pos_y, radius - 1)
		var _tile;
		for (var i = 0; i < array_length(_tiles); i++) {
			if (cell_empty(spell, _tiles[i][0], _tiles[i][1], false)) {
				//no wire tile in space, create it and set it as output
				_tile = set_tile(spell, _tiles[i][0], _tiles[i][1], SPELLS.wire)
				_tile.immutable = true
				force_tile_output(
					cell_data(spell, 
						_tiles[i][0] - (1 + (_tiles[i][1] == pos_y)) * -1*sign((_tiles[i][0] < pos_x) - 0.5),
						_tiles[i][1] - (_tiles[i][1] != pos_y) * -1*sign((_tiles[i][1] < pos_y) - 0.5)
					),
					_tile
				)
			} else {
				//get the wire tile in the space and set it as output
				_tile = cell_data(spell, _tiles[i][0], _tiles[i][1])
				_tile.immutable = true
				force_tile_output(
					cell_data(spell, 
						_tiles[i][0] - (1 + (_tiles[i][1] == pos_y)) * -1*sign((_tiles[i][0] < pos_x) - 0.5),
						_tiles[i][1] - (_tiles[i][1] != pos_y) * -1*sign((_tiles[i][1] < pos_y) - 0.5)
					),
					_tile
				)
			}
		}
		//TODO MAYBE, UPDATE WIRES
		return true
	}
	return false
}

//--------------------------------------------------------------------------------------------------

///@func shrink_tile()
///@desc shrinks a tile by 1 radius, call with the tile
function shrink_tile () {
	if (radius > 1) {
		radius--
		var _tiles = cell_ring_values(pos_x, pos_y, radius)
		var _tile;
		for (var i = 0; i < array_length(_tiles); i++) {
			_tile = cell_data(spell, _tiles[i][0], _tiles[i][1])
			_tile.immutable = false
			if (_tile.children_number = 1) and (_tile.colour_number = 0) {
				_tile.destroy()
			} else if (_tile.colour_number = 0) {
				//remove output
				set_tile_output(self, _tile)	
			}
		}
		value = max_val[radius - 1] + 1
	} else {
		radius = 1
		value = max_val[0]
	}
}