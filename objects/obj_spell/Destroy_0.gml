/// @description destroy ds_lists
for (var i = 0; i < ds_list_size(spell); i++) {
	ds_list_destroy(spell[| i].children)	
	ds_list_destroy(spell[| i].inputs)	
}
ds_list_destroy(spell)
ds_list_destroy(children)