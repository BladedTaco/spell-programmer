/// @description 

/*

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
ds_list_destroy(children)
//remove from existing input lists
var _index, _s;
with (obj_spell_part_hex) {
	if (id == other.id) continue;
	//replace inputs with default
	if (ds_exists(input_tile, ds_type_list)) {
		_index = ds_list_find_index(input_tile, other.id)
		while (_index > -1) {
			ds_list_replace(input_tile, _index, noone)	
			//remove from obj_spell as well
			_s = spell.spell[| index]
			ds_list_replace(_s[5], _index, -1) 
			//get next index
			_index = ds_list_find_index(input_tile, other.id)
		}
	}
	//remove children
	if (ds_exists(children, ds_type_list)) {
		_index = ds_list_find_index(children, other.id)
		while (_index > -1) { //for every child relationship found
			//remove it
			ds_list_delete(children, _index)	
			children_number--
			//remove from obj_spell as well
			_s = spell.spell[| index]
			ds_list_delete(_s[3], _index) //remove connection
			_index = ds_list_find_index(children, other.id)
		}
	}
	//decrease superior indices
	if (index > other.index) {
		index-- 
	}
}

var _ds;
var _i = index;
//shift indexes down in spell
with (spell) {
	//delete own entry
	var _s = spell[| _i]
	ds_list_destroy(_s[3])
	ds_list_destroy(_s[5])
	ds_list_delete(spell, _i)
	ds_list_delete(children, _i)
	children_number--
	//handle all other entries
	for (var i = 0; i < children_number; i++) {
		_s = spell[| i] //get the tile data
		//get the connections ds list
		_ds = _s[3]
		//reduce superior entries
		for (var o = 0; o < ds_list_size(_ds); o++) {
			if (_ds[| o] > _i) {
				_ds[| o] -= 1	
			}
		}
		//get the inputs ds list
		_ds = _s[5]
		//reduce superior entries
		for (var o = 0; o < ds_list_size(_ds); o++) {
			if (_ds[| o] > _i) {
				_ds[| o] -= 1	
			}
		}
	}
	//update wires next frame
	update_wire_delay  = 2
}

if (type = TYPE.WIRE) {
	with (spell) {
		check_ports(id)
		//recalculate all connectors and update wires
		event_user(1)	
	}
}