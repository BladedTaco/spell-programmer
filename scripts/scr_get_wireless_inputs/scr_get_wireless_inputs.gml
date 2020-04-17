///@func scr_get_wireless_inputs(tile)
///@param tile - an obj_spell_hex instance
///@desc gives all the inputs of a tile shortcircuiting wires as a ds_list that must be destroyed later

//declare variables
var _list = ds_list_create()
var _tile = argument[0]
var i, o;

//get all children of inital tile
for (i = 0; i < _tile.children_number; i++) {
	ds_list_add(_list, _tile.children[i])	
}

//replace any wires with all their children until there are no wires left
for (i = 0; i < ds_list_size(_list); i++) {
	while (_list[| i].type = TYPE.WIRE) { //while there is a wire
		for (o = 0; o < _list[| i].children_number; o++) { 
			ds_list_insert(_list, i+1, _list[| i].children[o]) //add all its children after the wire
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