/// @description get data
var _array = obj_spell.spell

_array = _array[| index] //get spell

tile = _array[0]
name = _array[1]
value = _array[2]
if (ds_exists(_array[3], ds_type_list)) {
	children = ds_list_create()
	ds_list_copy(children, _array[3])
} else {
	children = -1;	
}
var _pos = _array[4]
pos_x = _pos[0]
pos_y = _pos[1]

if (ds_exists(_array[3], ds_type_list)) {
	ds_list_copy(input_tile, _array[5]) // input tile inputs as indexes
}

//get tile data
if (tile > SPELL.CONNECTOR) {
	show_debug_message("REDUCING SPELL")
	show_debug_message(list_to_string(obj_spell.spell))
	tile = SPELL.CONNECTOR
}
_array = obj_init.spell_data[tile]

type = _array[0] 
sprite_index = _array[1]
image_blend = _array[2]
if (name = "") { //give name if empty
	name = _array[3]
}
if (array_length_1d(_array) > 5) {
	inputs = _array[4]
	input_colour = _array[5]
	input_number = array_length_1d(inputs)
}

//get number of children
if (ds_exists(children, ds_type_list)) {
	children_number = ds_list_size(children)
} else {
	children_number = 0;	
}

size = base_size;
if (type = TYPE.COUNTER) {
	size = base_size + string_length(string(value))*20
	if (value >= 100) {
		radius = 2;
	}
} else if (type != TYPE.BASIC) {
	if (type = TYPE.WIRE) {
		size -= 15
	} else {
		size += 20	
	}
}