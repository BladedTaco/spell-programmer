///@func array_concat(array, sep, empty)
///@param array - the array to concatenate
///@param sep - the seperator to add between entries
///@param empty - the value or string to be taken as empty
///@desc concatenates the given array by the given rules and return the string
function array_concat() {

	var _array = argument[0]
	var _sep = argument[1]
	var _empty = argument[2]
	var _str = ""

	// concatenate the array
	for (var i = 0; i < array_length_1d(_array); i++) {
		if (_array[i] != _empty) {
			_str += string(_array[i]) + _sep
		}
	}

	//remove final separator and return
	return string_delete(_str, string_length(_str)-string_length(_sep)+1, string_length(_sep))


}
