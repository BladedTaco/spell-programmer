/// A collection of scripts that deal with string manipulation and casting to string

/// Functions:
///		string_spaced
///		int_to_bin
///		list_to_string
///		list_to_string_func
///		array_concat

//--------------------------------------------------------------------------------------------------

function string_spaced(_str){
	var _out_str = ""
	for (var i = 1; i <= string_length(_str); i++) {
		_out_str += string_char_at(_str, i) + " "
	}
	
	return _out_str
}

//--------------------------------------------------------------------------------------------------

///@func int_to_bin(x)
///@param x - the number to convert to binary string
///@desc returns x as a binary string
function int_to_bin(_x) {
	var _str = ""
	//negatives are 0 now. I declare it
	if _x <= 0 {
		return "0"
	}
	while (_x > 0) {
		if _x % 2 == 0 {
			_str = "0" + _str	
		} else {
			_str = "1" + _str
		}
		_x = _x div 2
	}
	return _str
}

//--------------------------------------------------------------------------------------------------

///@func list_to_string(ds_list, multiline*, deep*)
///@param ds_list - a ds_list
///@param multiline* - if the list should be one entry per line, defaults to false
///@param deep* - for spell table drawing
///@desc returns a string composed of the values in a ds list
function list_to_string() {

	var _ret = "["
	var _sep = ", "
	var _end = "]"
	var _tab = ""
	var _deep = false;
	var _l = [];
	var _s = false;
	if (argument_count > 1) {
		if (argument[1]) {
			_sep = ",\n"
			_ret = "[\n"
			_end = "\n]"
			_tab = "    "
			_s = true
		}
		if (argument_count > 2) {
			_deep = argument[2]	
		}
	}


	if (_deep) {
		var _list = argument[0]
		for (var i = 0; i < ds_list_size(_list); i++) {
			if (_s) {
				_ret += string(i) + _tab
			} else {
				_ret += _tab
			}
			for (var o = 0; o < array_length_1d(_list[| i]); o++) {
				_l = _list[| i]
				if ((o == 3) or (o == 5)) {
					_ret += "[" + list_to_string(_l[o]) + "], "
				} else {
					_ret += string(_l[o]) + ", "
				}
			}
			_ret += _sep
		}	
		return string_delete(_ret, string_length(_ret) - 1, 2) + _end
	} else {
		var _list = argument[0]
		for (var i = 0; i < ds_list_size(_list); i++) {
			if (_s) {
				_ret += string(i) + _tab + string_replace_all(string_replace_all(string(_list[| i]), "{ { ", "["), " },  }", "]") + _sep
			} else {
				_ret += _tab + string_replace_all(string_replace_all(string(_list[| i]), "{ { ", "["), " },  }", "]") + _sep
			}
		}	
		return string_delete(_ret, string_length(_ret) - 1, 2) + _end
	}
}

//--------------------------------------------------------------------------------------------------

///@func list_to_string_func(ds_list, func)
///@param ds_list - a ds_list
///@param func - a function to use to get the string
///@desc returns a string composed of the values in a ds list
function list_to_string_func(_list, _func) {

	var _ret = "["
	var _sep = ", "
	var _end = "]"
	var _tab = ""
	var _l = [];

	for (var i = 0; i < ds_list_size(_list); i++) {
		_ret += _tab + string_replace_all(string_replace_all(_func(_list[| i]), "{ { ", "["), " },  }", "]") + _sep
	}	
	return string_delete(_ret, string_length(_ret) - 1, 2) + _end

}

//--------------------------------------------------------------------------------------------------

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