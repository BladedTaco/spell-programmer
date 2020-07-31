/// A collection of scripts that handle manipulating tile data

/// Functions:
///		set_tile
///		set_tile_output
///		force_tile_output
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
				//calculate new size 
				size = 10;
				for (i = 0; i < children_number; i++) {
					with (children[| i]) {
						get_size()
					}
				}
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

///@func set_tile_output(spell, source, dest)
///@param spell - the spell object
///@param source - the tile to set the output of
///@param dest - the tile to input into
///@desc sets the output of one tile into another, or removes it if it exists
function set_tile_output() {
	with (argument[0]) { //with the spell object
		//add the input into the spell array
		var _data, _diff;
		_data = spell[| argument[2].index].children
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
			if (!check_for_loops(argument[1], argument[2])) {
				ds_list_add(_data, argument[1].index)
				//set children
				with (argument[2]) {
					ds_list_add(children, argument[1])
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
					get_wire_data()
				}
			}
			if (_diff) check_ports(id)
		}
	}
}

//--------------------------------------------------------------------------------------------------

///@func force_tile_output(spell, source, dest, *unsafe, *weak)
///@param spell - the spell object
///@param source - the tile to set the output of
///@param dest - the tile to input into
///@param unsafe - if loop checking should be ignored
///@param weak - if recalculating wires and stuff should be ignored
///@desc sets the output of one tile into another, forcing the connection if it doesnt create loops
///yes, nö lööps brötha
///will trim any connections beforehand, so if the new connection cant be made, will remove the old one
function force_tile_output(_spell, _source, _dest, _unsafe, _weak) {
	_unsafe = is_undefined(_unsafe) ? false : _unsafe
	_weak = is_undefined(_weak) ? false : _weak
	with (_spell) { //with the spell object
		//add the input into the spell array
		var _data, _diff;
		_data = spell[| _dest.index].children
		_diff = false // if a connection has been removed
		//remove any existing connections between the two tiles
		//source to dest
		for (var i = _dest.children_number - 1; i >= 0; i--) {
			if (_data[| i] == _source.index) { //connection already exists
				//remove the connection and children
				ds_list_delete(_data, i)
				_diff = true
				with (_dest) {
					children_number--
					ds_list_delete(children, i)
				}
				break;
			}
		}
		//dest to source
		if (!_diff) { //there can only be a connection one way
			for (var i = _source.children_number - 1; i >= 0; i--) {
				if (spell[| _source.index].children[| i] == _dest.index) { //connection already exists
					//remove the connection and children
					ds_list_delete(spell[| _source.index].children, i)
					with (_source) {
						children_number--
						ds_list_delete(children, i)
					}
					break;
				}
			}
		}
		//create the connection
		//check for lööps brötha
		if (_unsafe or !check_for_loops(_source, _dest)) {
			ds_list_add(_data, _source.index)
			//set children
			with (_dest) {
				ds_list_add(children, _source)
				children_number++
			}
		}
	
		if (_weak) {
			//recalculate all connectors and update wires
			event_user(1)	
			//update wires
			if (_dest.type = TYPE.WIRE) {
				//update wire heads |Slightly inefficient, wire paths done twice
				event_user(0)
				for (i = 0; i < array_length_1d(wire_heads); i++) {
					with (wire_heads[i]) {
						get_wire_data()
					}
				}
				if (_diff) check_ports(id)
			}
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
		spell.spell[| index].move(argument[1], argument[2])
		move(argument[1], argument[2])
		
		//trim outputs
		for (i = 0; i < 6; i++) {
			if (is_struct(_tiles[i])) {
				with (_tiles[i]) {
					if (cell_distance(pos_x, pos_y, argument[1], argument[2]) > 1) {
						//check for inputs to argument tile
						for (o = 0; o < children_number; o++) {
							if (children[| o] == other) {
								set_tile_output(spell, other, self)
								break;
							}
						}
						if (o < children_number) continue; //skip rest if above loop broke
						//check for outputs to argument tile
						for (o = 0; o < other.children_number; o++) {
							if (other.children[| o] == self) {
								set_tile_output(spell, self, other)
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
				force_tile_output(spell,
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
				force_tile_output(spell,
					cell_data(spell, 
						_tiles[i][0] - (1 + (_tiles[i][1] == pos_y)) * -1*sign((_tiles[i][0] < pos_x) - 0.5),
						_tiles[i][1] - (_tiles[i][1] != pos_y) * -1*sign((_tiles[i][1] < pos_y) - 0.5)
					),
					_tile
				)
			}
		}
		spell.update_wires()
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
				set_tile_output(spell, self, _tile)	
			}
		}
		value = max_val[radius - 1] + 1
	} else {
		radius = 1
		value = max_val[0]
	}
}