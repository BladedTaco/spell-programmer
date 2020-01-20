/// @description get data and make children


var _array = obj_spell.spell

_array = _array[index] //get spell

tile = _array[0]
name = _array[1]
value = _array[2]
children = _array[3]



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
	bubble_size = size;
} else { //has children
	//create each trick circle
	for (var i = 0; i < children_number; i++) {
		with (instance_create_depth(x, y, 0, obj_spell_part)) { //create it
			level = other.level + 1
			index = other.children[i]; //give index
			spell = other.spell
			parent = other.parent	
			creator = other.id
			event_user(0) //get data
			other.children[i] = id; //give id
			
			//propogate size
			if (size > other.size) {
				other.size = size	
			}
			if (children_number > 0) {
				//other.bubble_size = max(bubble_size + other.size*4, other.bubble_size)
			} else {
				level--
			}
		}
	}
	bubble_size = size*12
}


zero_angle = (180/children_number)*((children_number mod 2) == 0);