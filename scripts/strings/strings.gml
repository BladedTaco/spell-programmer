// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function string_spaced(_str){
	var _out_str = ""
	for (var i = 1; i <= string_length(_str); i++) {
		_out_str += string_char_at(_str, i) + " "
	}
	return _out_str
}