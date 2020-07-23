///@functrion new_spell_tile(px, py, data, index)
///@param px - the x coordinate in the hex grid
///@param py - the y coordinate in the hex grid
///@param data - the struct containing the tile data
///@param *index - the index of the tile, if unset will be largest untaken
///@desc creates and returns a new spell tile of the given paramaters
function new_spell_tile(_px, _py, _data, _index) {
	return new _data.type(_px, _py, _data, _index)
}

///must be created by spell object
function spell_tile(_px, _py, _data, _index) constructor {
	pos_x = _px
	pos_y = _py
	
	index = is_undefined(_index) ? other.children_number : _index
	
	//pull info from _data
	type =				undefined
	sprite_index = 		_data.sprite_index 
	image_blend = 		_data.image_blend 
	name = 				_data.name 
	inputs = 			_data.inputs 
	input_colour = 		_data.input_colour 
	
	//default values
	x = room_width / 2
	y = room_height / 2
	spell = other.id
	other.children[| index] = self
	base_size = 30
	size = 30
	input_number = array_length(inputs)
	children = -1
	children_number = 0
	input_tile = ds_list_create()
	value = 0
	
	//maybe?
	small_max_val = power(2, 9) - 1;
	max_val = power(2, 23) - 1;
	zero_angle = 0;
	
	//init
	//get_data()
	
	//handle size stuff

	static get_data = function () {
		
		var _array = spell.spell[| index] //get spell
		
		tile = _array[0]
		name = _array[1]
		value = _array[2]
		
		if (ds_exists(_array[3], ds_type_list)) {
			children = ds_list_create()
			ds_list_copy(children, _array[3]) //children as ids
			ds_list_copy(input_tile, _array[5]) // input tile inputs as indexes
			children_number = ds_list_size(children)
		} else {
			children = -1;	
			children_number = 0;	
		}
		
		pos_x = _array[4][0]
		pos_y = _array[4][1]

		get_size()
	}
	
	static get_size = function () {
		size = base_size;
		if (type = TYPE.COUNTER) {
			//size = base_size + string_length(string(value))*20
			size = COUNTER_SIZE
			// THIS IS ALSO IN OBJ_MENU.STEP
			if (value >= small_max_val) {
				radius = 2;
			}
		} else if (type != TYPE.BASIC) {
			if (type = TYPE.WIRE) {
				size -= 15
			} else {
				size += 20	
			}
		}
	}
	
	static base_draw = function () {
		//backing circle
		draw_set_colour(COLOUR.EMPTY)
		draw_circle(x, y, size, false)
	
		//draw the sprite
		draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, image_blend, 1)
	
		//draw circle outline
		draw_set_colour(image_blend)
		draw_circle_outline(x, y, size)
	}
	
	static draw = function () {
		base_draw()

		//draw name and its ring
		draw_text_circle(x, y, name, size - 10, spell.age, 360, true)
		draw_circle_outline(x, y, size - 20)
	}

	static toString = function () {
		return "Spell Tile '" + name + "' at {" + string(x) + ", " + string(y) + "}"
	}
}


function basic_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.BASIC
	
	static draw = function () {
		base_draw()

		//draw name and its ring
		draw_text_circle(x, y, name, size - 10, spell.age, 360, true)
		draw_circle_outline(x, y, size - 20)
	}
}


function trick_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.TRICK
	
	static draw = function () {
		//name and rings
		draw_set_colour(image_blend)
		draw_text_circle(x, y, name, size - 30, spell.age, 360, true, true)
		draw_circle_outline(x, y, size - 40)
		draw_circle_outline(x, y, size - 20)
			
		//input text
		draw_set_colour(image_blend)
		draw_circle_outline(x, y, size)
		for (var i = 0; i < input_number; i++) {
			draw_set_colour(input_colour[i])
			draw_text_circle(x, y, inputs[i] + "   ", size - 10, -(spell.age + zero_angle + (360/input_number)*i - (input_number-2)*180/input_number), 360/input_number, false, true)
		}
	}
}


function converter_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.CONVERTER
	
	static draw = function () {
		//name and rings
		draw_set_colour(image_blend)
		draw_text_circle(x, y, name, size - 30, spell.age, 360, true, true)
		draw_circle_outline(x, y, size - 40)
		draw_circle_outline(x, y, size - 20)
			
		//input text
		draw_set_colour(image_blend)
		draw_circle_outline(x, y, size)
		for (var i = 0; i < input_number; i++) {
			draw_set_colour(input_colour[i])
			draw_text_circle(x, y, inputs[i] + "   ", size - 10, -(spell.age + zero_angle + (360/input_number)*i - (input_number-2)*180/input_number), 360/input_number, false, true)
		}
	}
}


function counter_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.COUNTER
	
	static draw = function () {
		
	}
}


function shell_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.SHELL
	
	static draw = function () {
		//name and rings
		draw_set_colour(image_blend)
		draw_text_circle(x, y, name, size - 30, spell.age, 360, true, true)
		draw_circle_outline(x, y, size - 40)
		draw_circle_outline(x, y, size - 20)
			
		//input text
		draw_set_colour(image_blend)
		draw_circle_outline(x, y, size)
		for (var i = 0; i < input_number; i++) {
			draw_set_colour(input_colour[i])
			draw_text_circle(x, y, inputs[i] + "   ", size - 10, -(spell.age + zero_angle + (360/input_number)*i - (input_number-2)*180/input_number), 360/input_number, false, true)
		}
	}
}


function wire_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.WIRE
	colour_cycle = false
	colour_number = 0
	colours = []
	
	static draw = function () {
		if (colour_cycle) {
			var i = spell.age*colour_number div 360
			var o = (spell.age*colour_number mod 360)/360
			//smooth out transitions
			if (o < 0.5) {
				o = o*o*o*o //o^4
				o = 8*o //8o^4
			} else {
				o -= 1;
				o = o*o*o*o //(o - 1)^4
				o = 1 - 8*o //1 - 8(o - 1)^4
			}
			image_blend = merge_colour(colours[i], colours[i+1], o)
		}
		
		base_draw()

		//draw name and its ring
		draw_text_circle(x, y, name, size - 10, spell.age, 360, true)
		draw_circle_outline(x, y, size - 20)
	}
}



//function bin_counter_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
//	type = TYPE.BIN_COUNTER
//}


//function __spell_add_motion(_px, _py, _index) : spell_tile(_px, _py, _index) constructor {
//	type = TYPE.TRICK
//	sprite_index = spr_add_motion
//	image_blend = COLOUR.TRICK
//	name = " ADD MOTION "
//	inputs = ["DIRECTION", "TARGET", "MANA"]
//	input_colour = [COLOUR.VECTOR, COLOUR.ENTITY, COLOUR.MANA]
//}







/*
	with (instance_create_depth(x, y, 0, obj_spell_part_hex)) { //create it
		x = room_width/2
		y = room_height/2
		index = i; //give index
		spell = other.id
		level = 0;
		other.children[| i] = id; //give id
		event_user(0) //get data
		//get bubble size
		if (size > _bubble) {
			if (type != TYPE.COUNTER) {
				_bubble = size	
			}
		}
		_s = other.spell[| i] //the tile
		if (_s[2] = -1) { //is a trick tile
			other.sprite_index = sprite_index
		}
	}
}
//calculate hex size
//_hex = _bubble*2/sqrt(3)
_bubble += 32 // add border
_hex = _bubble*2/sqrt(3)
bubble_size = _bubble
hex_size = _hex
//give bubble and hex size
for (i = 0; i < children_number; i++) {
	with (children[| i]) {
		event_user(1) //get children
		bubble_size = _bubble
		hex_size = _hex
		cell_size = size*2/sqrt(3)
		other.size = max(other.size, point_distance(0, 0, bubble_size*pos_x, hex_size*pos_y*HEX_MUL) + cell_size + 60)
	}
}