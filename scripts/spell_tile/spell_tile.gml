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
	
	//init
	get_data()
	
	//handle size stuff

	static get_data = function () {
		//	
	}

	static toString = function () {
		return "Spell Tile '" + name + "' at {" + string(x) + ", " + string(y) + "}"
	}
}

function basic_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.BASIC
	
	static draw = function () {
		
	}
}


function trick_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.TRICK
	
	static draw = function () {
		
	}
}


function converter_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.CONVERTER
	
	static draw = function () {
		
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
		
	}
}


function wire_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.WIRE
	
	static draw = function () {
		
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