///@func scr_check_for_loops(spell, source, dest)
///@param spell - the spell object
///@param source - the tile to set the output of
///@param dest - the tile to input into
///@desc returns whether creating the given connection causes any loops
<<<<<<< HEAD
function scr_check_for_loops() {

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
		if (scr_check_for_loops(argument[0], argument[1].children[| i], argument[2])) {
			return true	//loop found
		}
	}

	return false //no loops found




}
=======

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
	if (scr_check_for_loops(argument[0], argument[1].children[| i], argument[2])) {
		return true	//loop found
	}
}

return false //no loops found

>>>>>>> master
