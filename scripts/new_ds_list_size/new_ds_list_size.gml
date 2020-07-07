///@func new_ds_list(value, n)
///@param value - the value to populate the list with
///@param n - the amount of times to add it
///@desc creates a ds_list with the given value n times
<<<<<<< HEAD
function new_ds_list_size() {

	var _list = ds_list_create()

	for (var i = 0; i < argument[1]; i++) {
		ds_list_add(_list, argument[0])
	}

	return _list


}
=======

var _list = ds_list_create()

for (var i = 0; i < argument[1]; i++) {
	ds_list_add(_list, argument[0])
}

return _list
>>>>>>> master
