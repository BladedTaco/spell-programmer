/// A collection of scripts that act as passthroughs by giving default values

/// Functions:
///		instance_create
///		new_ds_list
///		new_ds_list_size

//--------------------------------------------------------------------------------------------------

///@func instance_create(x, y, obj)
///@param x - the x position to create the object at
///@param y - the y position to create the object at
///@param obj - the object type to create
///@desc creates the given object at the given position and returns its id
function instance_create(x, y, obj) {
	return instance_create_depth(x, y, 0, obj)
}

//--------------------------------------------------------------------------------------------------

///@func new_ds_list(values**)
///@param values** any number of entries for the list
///@desc creates, fills, and returns the ds_list with the given data
function new_ds_list() {

	var _list = ds_list_create()

	for (var i = 0; i < argument_count; i++) {
		ds_list_add(_list, argument[i])
	}

	return _list
}

//--------------------------------------------------------------------------------------------------

///@func new_ds_list_size(value, n)
///@param value - the value to populate the list with
///@param n - the amount of times to add it
///@desc creates a ds_list with the given value n times
function new_ds_list_size() {

	var _list = ds_list_create()

	for (var i = 0; i < argument[1]; i++) {
		ds_list_add(_list, argument[0])
	}

	return _list
}
