/// @description get data


var _array = obj_spell.spell

_array = _array[index] //get spell

tile = _array[0]
name = _array[1]
value = _array[2]
children = _array[3]
var _pos = _array[4]
pos_x = _pos[0]
pos_y = _pos[1]

//get tile data
_array = obj_init.spell_data[tile]

type = _array[0] 
sprite_index = _array[1]
image_blend = _array[2]
if (array_length_1d(_array) > 4) {
	inputs = _array[3]
	input_colour = _array[4]
	input_number = array_length_1d(inputs)
}

if (type = TYPE.COUNTER) {
	size = base_size + string_length(string(value))*20
}

//get number of children
children_number = array_length_1d(children)
if (children = -1) { //no children
	children_number = 0;
}

