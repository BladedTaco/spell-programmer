///@func scr_get_path(head, tile)
///@param head - an obj_spell_hex wire instance
///@param tile - an obj_spell_hex instance (Can't be a wire)
///@desc gives the path from the head to the tile through wires as a ds_list that must be destroyed later

function scr_get_path() {
	// This is done via a Depth-First Search Algorithm
	// Copied from scr_get_wire_path()

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
		while (((_list[| i].type = TYPE.WIRE) or (_list[| i].id = _wire)) and (_list[| i].children_number > 0)) {
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

// This is done via a Depth-First Search Algorithm
// Copied from scr_get_wire_path()

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
	while (((_list[| i].type = TYPE.WIRE) or (_list[| i].id = _wire)) and (_list[| i].children_number > 0)) {
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

