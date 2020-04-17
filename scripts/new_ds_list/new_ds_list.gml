///@func new_ds_list(values**)
///@values** any number of entries for the list
///@desc creates, fills, and returns the ds_list with the given data

///@desc creates a ds_list with the given values and return the index


var _list = ds_list_create()

for (var i = 0; i < argument_count; i++) {
	ds_list_add(_list, argument[i])
}

return _list