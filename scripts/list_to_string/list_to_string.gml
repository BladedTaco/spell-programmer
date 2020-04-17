///@func list_to_string(ds_list)
///@param ds_list - a ds_list
///@desc returns a string composed of the values in a ds list

var _list = argument[0]
var _ret = "["
for (var i = 0; i < ds_list_size(_list); i++) {
	_ret += string(_list[| i]) + ", "
}	
return string_delete(_ret, string_length(_ret) - 1, 2) + "]"
