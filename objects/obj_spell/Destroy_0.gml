/// @description destroy ds_lists
var _array;
for (var i = 0; i < ds_list_size(spell); i++) {
	_array = spell[| i]
	ds_list_destroy(_array[3])	
}
ds_list_destroy(spell)
ds_list_destroy(children)