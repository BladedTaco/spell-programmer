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
	init(0)
	
	
	static init = function () {
		get_data()
		get_children()
	}
	
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
	
	static get_children = function () {
		//get the id of each child
		for (var i = 0; i < children_number; i++) {
			children[| i] = spell.children[| children[| i]].id
		}

		//get the id of each input
		for (i = 0; i < ds_list_size(input_tile); i++) {
			if (input_tile[| i] > 0) {
				input_tile[| i] = spell.children[| input_tile[| i]].id;
			}
		}
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


function bin_counter_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.BIN_COUNTER
	bin_value = int_to_bin(value)
	
	static draw = function () {
		draw_set_colour(image_blend)
		var _str, _sign = -1;
		_str = "0"
		//draw the name and its ring
		var o = string_length(string(value));
		o = 1
		draw_text_circle(x, y, name, size - o*20 - 10, spell.age, 360, true)
		draw_circle_outline(x, y, size - o*20 - 20)
			
		bin_value = int_to_bin(value)
		//show_debug_message(value)
		//show_debug_message(bin_value)
			
		//draw the fill bar
		draw_set_colour( - image_blend)
		var _sz = 360/string_length(bin_value)
		for (o = string_length(bin_value)-1; o >= 0; o--) {
			if string_char_at(bin_value, o+1) == 1 {
				//draw the fill bar
				draw_set_colour(image_blend)
				draw_circle_curve(x, y, size - 10, -o*_sz + spell.age*_sign, _sz, 21)
				//middle light
				draw_set_colour( - image_blend)
				draw_circle_curve(x, y, size - 10, -o*_sz + spell.age*_sign, _sz/2, 5)
				//text backing
				draw_circle_curve(x, y, size - 10, -(o + 0.5)*_sz + spell.age*_sign, _sz/5, 16)
			}
			//starter
			draw_circle_curve(x, y, size - 10, -o*_sz + spell.age*_sign, _sz/5, 19)
		}
			
		//draw the ring
		draw_set_colour(image_blend)
		draw_circle_outline(x, y, size - o*20 - 40)
		_sign = -_sign
			
		//draw the text fill
		//draw_set_colour(-image_blend)
		draw_text_circle(x, y, bin_value, size - 9, -spell.age*_sign - _sz*0.6, 360, true, false, true, true)
			
		//draw the start marker
		var _x, _y;
		_x = x + lengthdir_x(size - 7, 180 -spell.age*_sign)
		_y = y + lengthdir_y(size - 7, 180 -spell.age*_sign)
		draw_set_color(COLOUR.BLACK)
		draw_polygon(_x, _y, 16, -spell.age*_sign, 3, true)
		draw_set_colour(COLOUR.MARKER)
		draw_polygon(_x, _y, 8, -spell.age*_sign, 3, false, 4)
	}
}


function counter_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.COUNTER
	
	static draw = function () {
		draw_set_colour(image_blend)
		var _str, _sign = -1;
		//draw the name and its ring
		var o = string_length(string(value));
		draw_text_circle(x, y, name, size - o*20 - 10, spell.age, 360, true)
		draw_circle_outline(x, y, size - o*20 - 20)
		//for each ring
		for (--o; o >= 0; o--) {
			//get the number, direction of rotation, and string
			var _num = real(string_char_at(string(value), o+1))
			switch (string_length(string(value)) - o) {
				case 1:	_str = " ONE "; break;
				case 2:	_str = " TEN "; break;	
				case 3:	_str = " HUND "; break;
				case 4:	_str = " THOUSAND "; break;	
				case 5:	_str = " TEN THOU "; break;	
				case 6:	_str = " HUND THOU "; break;	
				case 7:	_str = " MILLION "; break;
				case 8:	_str = " TEN MILLION "; break;
				default: _str = " PLEASE JUST STOP "; break;
			}
			
			//draw the text fill
			draw_text_circle(
				x, y, string_repeat(_str, 10), size - 10 - o*20,
				spell.age*_sign, 360, true, false, true
			)
			//draw the fill bar
			draw_circle_curve(
				x, y, size - 10 - o*20,
				spell.age*_sign,
				_num*36, 21
			)
			//draw the ring
			draw_circle_outline(x, y, size - o*20 - 20)
			_sign = -_sign
		}
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
	
	static get_wire_data = function () {
		if (ds_exists(input_tile, ds_type_list) and ds_exists(children, ds_type_list)) {
			var _l = ds_list_size(input_tile)
			var _s = [];
	
			//reset colour array
			colours = [COLOUR.WIRE];
	
			//get colours and names
			for (var i = 0; i < _l; i++) {
				colours[i] = input_tile[| i].input_colour[inputs[i]] //colour swapping
				_s[i] = " " + input_tile[| i].inputs[inputs[i]] + " "
			}
	
	
			//redefine variables
			name = array_concat(_s, "+", " ")
			connector_name = [name, name, name, name, name, name]	
			colour_number = _l;
			colour_cycle = (_l > 1)
			if (colour_cycle) { 
				colours[i] = colours[0] //append the first colour to the list
			} else {
				image_blend = colours[0]	
			}
	
			children_number = ds_list_size(children) // TODO workaround
	
			for (i = 0; i < children_number; i++) {
				if instance_exists(children[| i]) { 
					if (children[| i].type == TYPE.WIRE) {
						//with (children[| i]) {
						//	get_wire_data()
						//	other.connector_name[i] = name
						//}
						children[| i].get_wire_data()
						connector_name[i] = children[| i].name
					}
				} else {
					show_debug_message("MISSING CHILD")
				
				}
			}
	
			if (ds_list_size(input_tile) == 0) {
				connector_name = ["", "", "", "", "", ""]
			}
		}
	}
	
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