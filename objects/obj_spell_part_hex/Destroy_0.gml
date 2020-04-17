/// @description 
if (surface_exists(clip_surface)) {
	surface_free(clip_surface)
}
if (surface_exists(anticlockwise_surface)) {
	surface_free(anticlockwise_surface)
}
if (surface_exists(clockwise_surface)) {
	surface_free(clockwise_surface)
}

//clear input list
ds_list_destroy(input_tile)
//remove from existing input lists
var _index;
with (obj_spell_part_hex) {
	if (ds_exists(input_tile, ds_type_list)) {
		_index = ds_list_find_index(input_tile, other.id)
		while (_index > -1) {
			ds_list_replace(input_tile, _index, noone)	
			_index = ds_list_find_index(input_tile, other.id)
		}
	}
}