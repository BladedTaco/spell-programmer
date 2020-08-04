/// A collection of scripts that deal with path information

/// Functions:
///		get_path
///		get_wire_path
///		get_wireless_inputs

//--------------------------------------------------------------------------------------------------

///@func get_path(head, tile)
///@param head - a spell tile instance
///@param tile - a spell tile instance (Can't be a wire)
///@desc gives the path from the head to the tile through wires as a ds_list that must be destroyed later
function get_path() {
	// This is done via a Depth-First Search Algorithm
	// Copied from get_wire_path()

	//declare variables
	var _list = ds_list_create()
	var _index = ds_list_create()
	var _wire = argument[0]
	var _tile = argument[1]
	var i = 0;

	//add the first tile
	ds_list_add(_list, _wire)
	ds_list_add(_index, 0)

	while (true) { //repeat forever, it will exit itself
		//dive down from brach
		while (((_list[| i].type = TYPE.WIRE) or (_list[| i] = _wire)) and (_list[| i].children_number > 0)) {
			//add the children
			ds_list_add(_list, _list[| i].children[| _index[| i]])
			ds_list_add(_index, 0)
			i++
		}
		//check if its the right output
		if (_list[| i] = _tile) {
			//destory index list, return path list
			ds_list_delete(_list, i) //remove the non-wire tile
			ds_list_destroy(_index)
			return _list	
		} else { //go back up the tree until a new branch is found
			while (((_list[| i].type != TYPE.WIRE) and (_list[| i] != _wire)) or (_list[| i].children_number <= _index[| i] + 1)) {
				//delete the children and move up the list
				ds_list_delete(_list, i)
				ds_list_delete(_index, i)
				i--
				if (i <= -1) { //path not found
					return _list //return empty list
				}
			}
			_index[| i] += 1 //increase branch index
		}
	}
}

//--------------------------------------------------------------------------------------------------

///@func get_wire_path(wire, tile)
///@param wire - an obj_spell_hex wire instance
///@param tile - an obj_spell_hex instance (Can't be a wire)
///@desc gives the path from the wire to the tile as a ds_list that must be destroyed later
function get_wire_path() {
	// This is done via a Depth-First Search Algorithm

	//declare variables
	var _list = ds_list_create()
	var _index = ds_list_create()
	var _wire = argument[0]
	var _tile = argument[1]
	var i = 0;

	//add the first wire
	ds_list_add(_list, _wire)
	ds_list_add(_index, 0)

	while (true) { //repeat forever, it will exit itself
		//dive down from brach
		while ((_list[| i].type = TYPE.WIRE) and (_list[| i].children_number > 0)) {
			//add the children
			ds_list_add(_list, _list[| i].children[| _index[| i]])
			ds_list_add(_index, 0)
			i++
		}
		//check if its the right output
		if (_list[| i] = _tile) {
			//destory index list, return path list
			ds_list_delete(_list, i) //remove the non-wire tile
			ds_list_destroy(_index)
			return _list	
		} else { //go back up the tree until a new branch is found
			while ((_list[| i].type != TYPE.WIRE) or (_list[| i].children_number <= _index[| i] + 1)) {
				//delete the children and move up the list
				ds_list_delete(_list, i)
				ds_list_delete(_index, i)
				i--
				if (i <= -1) { //path not found
					return _list //return empty list
				}
			}
			_index[| i] += 1 //increase branch index
		}
	}
}

//--------------------------------------------------------------------------------------------------

///@func get_wireless_inputs(tile)
///@param tile - an obj_spell_hex instance
///@desc gives all the inputs of a tile shortcircuiting wires as a ds_list that must be destroyed later
function get_wireless_inputs() {

	//declare variables
	var _list = ds_list_create()
	var _tile = argument[0]
	var i, o;

	//get all children of inital tile
	for (i = 0; i < _tile.children_number; i++) {
		ds_list_add(_list, _tile.children[| i])	
	}

	//replace any wires with all their children until there are no wires left
	for (i = 0; i < ds_list_size(_list); i++) {
		while (_list[| i].type = TYPE.WIRE) { //while there is a wire
			for (o = 0; o < _list[| i].children_number; o++) { 
				ds_list_insert(_list, i+1, _list[| i].children[| o]) //add all its children after the wire
			}
			ds_list_delete(_list, i) //remove the wire object from the list.
		}
	}

	//delete duplicates
	ds_list_sort(_list, true)
	for (i = 0; i < ds_list_size(_list) - 1; i++) {
		while (_list[| i] == _list[| i+1]) { //while the next value is the same
			ds_list_delete(_list, i+1)	//remove the next value
		}
	}

	//return the list
	return _list
}