///@func list_to_string(ds_list, multiline*, deep*)
///@param ds_list - a ds_list
///@param multiline* - if the list should be one entry per line, defaults to false
///@param deep* - for spell table drawing
///@desc returns a string composed of the values in a ds list
<<<<<<< HEAD
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
=======

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
>>>>>>> master
