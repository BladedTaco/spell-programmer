/// A collection of scripts that deal with or help with santizing the spell construction

/// Functions:
///		check_ports
///		check_for_loops

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
					_lst = get_path(id, input_tile[| o])
					if (ds_list_size(_lst) = 0) {
						input_tile[| o] = noone
						ds_list_replace(_s[5], o, -1)
					}
					ds_list_destroy(_lst)
				}
			}
		}
	}
}

//--------------------------------------------------------------------------------------------------

///@func check_for_loops(spell, source, dest)
///@param spell - the spell object
///@param source - the tile to set the output of
///@param dest - the tile to input into
///@desc returns whether creating the given connection causes any loops
function check_for_loops() {

	//source has no links, no loops
	if (argument[1].children_number <= 0) {
		return false //no loops
	}



	//check if any children connect recursively
	for (var i = 0; i < argument[1].children_number; i++) {
		//check if they connect
		if (argument[1].children[| i] == argument[2].id) { //the source fathers the destination
			return true
		}
		//check their children
		if (check_for_loops(argument[0], argument[1].children[| i], argument[2])) {
			return true	//loop found
		}
	}

	return false //no loops found
}