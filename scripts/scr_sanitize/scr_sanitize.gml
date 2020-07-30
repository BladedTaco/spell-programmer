/// A collection of scripts that deal with or help with santizing the spell construction

/// Functions:
///		check_ports
///		check_for_loops
///		check_for_loops_structs

//--------------------------------------------------------------------------------------------------

///@func check_ports(spell)
///@param spell - the spell object to check
///@desc check all ports and removes entries that dont connect
function check_ports() {

	var _lst, _s;
	with (argument[0]) {
		for (var i = 0; i < children_number; i++) {
			_s = spell[| i]
			with (children[| i]) {
				for (var o = 0; o < input_number; o++) {
					_lst = get_path(self, input_tile[| o])
					if (ds_list_size(_lst) = 0) {
						input_tile[| o] = noone
						ds_list_replace(_s.inputs, o, -1)
					}
					ds_list_destroy(_lst)
				}
			}
		}
	}
}

//--------------------------------------------------------------------------------------------------

///@func check_for_loops(source, dest)
///@param source - the tile to set the output of
///@param dest - the tile to input into
///@desc returns whether creating the given connection causes any loops
function check_for_loops(source, dest) {

	//check if any children connect recursively
	for (var i = 0; i < source.children_number; i++) {
		//check if they connect
		if (source.children[| i] == dest) { //the source fathers the destination
			return true
		}
		//check their children
		if (check_for_loops(source.children[| i], dest)) {
			return true	//loop found
		}
	}

	return false //no loops found
}

//--------------------------------------------------------------------------------------------------

///@func check_for_loops_structs(source, dest)
///@param source - the tile to set the output of
///@param dest - the tile to input into
///@desc returns whether creating the given connection causes any loops, checking connector structs as well
function check_for_loops_structs(source, dest, connectors, connecter_number) {
	//check if any children connect recursively
	for (var i = 0; i < source.children_number; i++) {
		//check if they connect
		if (source.children[| i] == dest) { //the source fathers the destination
			return true
		}
		//check their children
		if (check_for_loops_structs(source.children[| i], dest, connectors, connecter_number)) {
			return true	//loop found
		}
	}
	
	//check if any structs connect recursively
	for (i = 0; i < connecter_number; i++) {
		if (connectors[@ i].dest == source) { //this tile
			//check if they connect
			if (connectors[@ i].source == dest) { //the source fathers the destination
				return true
			}
			//check their children
			if (check_for_loops_structs(connectors[@ i].source, dest, connectors, connecter_number)) {
				return true	//loop found
			}
		}
	}
	return false //no loops found
}