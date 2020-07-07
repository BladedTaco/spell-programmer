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
			if (!scr_check_for_loops(argument[0], argument[1], argument[2])) {
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
		if (!scr_check_for_loops(argument[0], argument[1], argument[2])) {
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


