///@func set_tile_output(spell, source, dest)
///@param spell - the spell object
///@param source - the tile to set the output of
///@param dest - the tile to input into
///@desc sets the output of one tile into another, or removes it if it exists

with (argument[0]) { //with the spell object
	//add the input into the spell array
	var _array, _data;
	_array = spell[argument[2].index]
	_data = _array[3]
	if (is_array(_data)) { //has inputs
		//check if it already exists
		for (var i = argument[2].children_number - 1; i >= 0; i--) {
			if (_data[i] == argument[1].index) { //connection already exists
				//remove the connection and children
				if (argument[2].children_number = 1) {
					_array[@ 3] = -1; //remove child
					with (argument[2]) {
						children[i] = noone
						children_number = 0
					}
				} else {
					//shift all entries down
					for (var o = i; o < argument[2].children_number-1; o++) {
						_data[@ o] = _data[o+1]	
						argument[2].children[o] = argument[2].children[o+1]
					}
					_data[@ o] = noone
					argument[2].children[o] = noone;
					with (argument[2]) {
						children_number--
						children[children_number] = noone
					}
				}
			}
		}
		_data[@ argument[2].children_number] = argument[1].index
		//set children
		with (argument[2]) {
			children[children_number] = argument[1].id
			children_number++
		}
	} else { //create the first input
		_array[@ 3] = [argument[1].index]
		//set children
		with (argument[2]) {
			children[children_number] = argument[1].id
			children_number++
		}
	}
}

//get colour swaps
if (argument[2].type = TYPE.WIRE) {
	with (argument[2]) {
		event_user(2);	
	}
}