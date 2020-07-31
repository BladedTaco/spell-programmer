///@func new_spell_tile(px, py, data, index)
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
	data =				_data	
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
	base_size = 60
	size = base_size
	input_number = array_length(inputs)
	children = -1
	children_number = 0
	input_tile = ds_list_create()
	value = 0
	bubble_size = size + BUBBLE
	hex_size = bubble_size*2/sqrt(3)
	cell_size = size*2/sqrt(3)
	radius = 1;
	
	//need to incorporate
	group_colour = COLOUR.EMPTY;	
	immutable = false;
	variable_size = false;
	connectors = ds_list_create()
	
	//maybe?
	//small_max_val = power(2, 9) - 1;
	//max_val = power(2, 23) - 1;
	max_val = [0, power(2, 9) - 1, power(2, 23) - 1, power(2, 32) - 1]
	max_radius = 3
	zero_angle = 0;
	
	///@func move(x, y)
	///@param x - the x coordinate to move to
	///@param y - the y coordinate to move to
	///@desc moves the tile to the given coordinate
	static move = function (_x, _y) {
		pos_x = _x
		pos_y = _y
		//update spell
		spell.spell[| index].pos = [_x, _y]
		spell.spell[| index].pos_x = _x
		spell.spell[| index].pos_y = _y
	}
	
	///@func update_pos()
	///@desc updates the position of the tile
	static update_pos = function () {
		x = other.half_surface_size + bubble_size*pos_x
		y = other.half_surface_size + hex_size*pos_y*HEX_MUL
	}
	
	///@func update_spell()
	///@desc adds the spell tile to the spell object
	static update_spell = function () {
		spell.spell[| index] = new spell_part(data, name, value, [], [pos_x, pos_y], []) 
	}
	
	///@func check_radius()
	///@desc checks for radius changes in variable size tiles
	static check_radius = function () {
		if (value > max_val[radius]) {
			//expand if possible
			if !expand_tile() {
				//if not possible, clamp value
				value = max_val[radius]
			}
		} else if (value < max_val[radius - 1]) {
			//shrink
			shrink_tile()
		}
	}
	
	///@func get_size()
	///@desc gets the size of the tile, and handles changes caused by a size change
	static get_size = function () {
		size = base_size;
		if (variable_size) {
			if (type = TYPE.COUNTER) {
				size = base_size + string_length(string(value))*20
			} else {
				size = base_size + 20 + max(0, (string_length(string(int_to_bin(value))) - 10)*10)
			}
			
			if (!spell.init) {
				check_radius()
			}
			
			set_size(spell.bubble_size)	
		} else {
			if (type = TYPE.WIRE) {
				size -= 15
			} else if (type != TYPE.BASIC) {
				size += 20	
			}
			//handle bubble_size
			if (size + BUBBLE > spell.bubble_size) {
				spell.set_bubble(size + BUBBLE)
			} else {
				set_size(spell.bubble_size)	
			}
		}
	}
	
	///@func set_size(bubble)
	///@param bubble - the bubble size to use
	///@desc gets the proper size values relating to the grid
	static set_size = function (_bubble) {
		bubble_size = _bubble
		hex_size = bubble_size*2/sqrt(3)
		cell_size = size*2/sqrt(3)
		spell.size = max(spell.size, point_distance(0, 0, bubble_size*pos_x, hex_size*pos_y*HEX_MUL) + cell_size + 60)
	}
	
	///@func get_data()
	///@desc pulls data from the spell object to override default values
	static get_data = function () {
		
		var _spell = spell.spell[| index] //get spell
		
		//if no spell there, make a default one
		if (!is_struct(_spell)) {
			update_spell()	
			_spell = spell.spell[| index]
		}
		
		tile = _spell.tile
		name = _spell.name
		value = _spell.value
		
		if (ds_exists(_spell.children, ds_type_list)) {
			children = ds_list_create()
			ds_list_copy(children, _spell.children) //children as ids
			ds_list_copy(input_tile, _spell.inputs) // input tile inputs as indexes
			children_number = ds_list_size(children)
		} else {
			children = -1;	
			children_number = 0;	
		}
		
		pos_x = _spell.pos_x
		pos_y = _spell.pos_y
	}
	
	///@func get_children()
	///@desc retrieves the id of each child from their index
	static get_children = function () {
		//get the id of each child
		for (var i = 0; i < children_number; i++) {
			children[| i] = spell.children[| children[| i]]
		}

		//get the id of each input
		for (i = 0; i < ds_list_size(input_tile); i++) {
			if (input_tile[| i] > 0) {
				input_tile[| i] = spell.children[| input_tile[| i]];
			}
		}
	}
	
	///@func destroy()
	///@desc removes all references to spell tile and cleans up data structures
	static destroy = function () {
			//clear input list
			ds_list_destroy(input_tile)
			ds_list_destroy(children)
			
			//remove from existing input lists
			var _index, _s, _b = 0;
			for (var i = 0; i < spell.children_number; i++) {
				with (spell.children[| i]) {
					if (self == other) continue;
					_b = max(_b, size*!variable_size)
					//replace inputs with default
					if (ds_exists(input_tile, ds_type_list)) {
						_index = ds_list_find_index(input_tile, other)
						while (_index > -1) {
							ds_list_replace(input_tile, _index, noone)	
							//remove from obj_spell as well
							_s = spell.spell[| index]
							ds_list_replace(_s.inputs, _index, -1) 
							//get next index
							_index = ds_list_find_index(input_tile, other)
						}
					}
					//remove children
					if (ds_exists(children, ds_type_list)) {
						_index = ds_list_find_index(children, other)
						while (_index > -1) { //for every child relationship found
							//remove it
							ds_list_delete(children, _index)	
							children_number--
							//remove from obj_spell as well
							_s = spell.spell[| index]
							ds_list_delete(_s.children, _index) //remove connection
							_index = ds_list_find_index(children, other)
						}
					}
					//decrease superior indices
					if (index > other.index) {
						index-- 
					}
				}
			}
			
			//recalculate bubble size
			spell.set_bubble(_b + BUBBLE)

			var _ds;
			var _i = index;
			//shift indexes down in spell
			with (spell) {
				//delete own entry
				var _s = spell[| _i]
				ds_list_destroy(_s.children)
				ds_list_destroy(_s.inputs)
				ds_list_delete(spell, _i)
				ds_list_delete(children, _i)
				children_number--
				//handle all other entries
				for (var i = 0; i < children_number; i++) {
					_s = spell[| i] //get the tile data
					//get the connections ds list
					_ds = _s.children
					//reduce superior entries
					for (var o = 0; o < ds_list_size(_ds); o++) {
						if (_ds[| o] > _i) {
							_ds[| o] -= 1	
						}
					}
					//get the inputs ds list
					_ds = _s.inputs
					//reduce superior entries
					for (var o = 0; o < ds_list_size(_ds); o++) {
						if (_ds[| o] > _i) {
							_ds[| o] -= 1	
						}
					}
				}
				//update wires next frame
				update_wire_delay = 2
			}

			if (type = TYPE.WIRE) {
				with (spell) {
					check_ports(id)
					//recalculate all connectors and update wires
					event_user(1)	
				}
			}
	}
	
	#region Drawing functions
	///@func draw_base()
	///@desc the base draw that all tiles have to do
	static draw_base = function () {
		//backing circle
		draw_set_colour(COLOUR.EMPTY)
		draw_circle(x, y, size, false)
	
		//draw the sprite
		draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, image_blend, 1)
	
		//draw circle outline
		draw_set_colour(image_blend)
		draw_circle_outline(x, y, size)
	}
	
	///@func draw()
	///@desc performs the draw based on the type of tile, is overriden by children
	static draw = function () {
		draw_base()

		//draw name and its ring
		draw_text_circle(x, y, name, size - 10, spell.age, 360, true)
		draw_circle_outline(x, y, size - 20)
	}
		
	///@func draw_backing()
	///@desc draws the backing of the spell tile
	static draw_backing = function () {
		if (group_colour != COLOUR.EMPTY) {
			//back polygon backing group colour
			draw_set_colour(group_colour)
			draw_polygon(x, y, hex_size + 100, 90, 6, true)
		}
		
		//back polygon backing
		draw_set_colour(group_colour)
		draw_polygon(x, y, cell_size, 90, 6, true)
			
		//front polygon
		draw_set_colour(image_blend)
		draw_polygon(x, y, cell_size, 90, 6, false)	
	}
		
	///@func draw_connectors()
	///@desc draws all the connectors originating from this tile
	static draw_connectors = function () {
		for (var i = 0; i < ds_list_size(connectors); i++) {
			connectors[| i].draw()	
		}
	}
	
	///@func draw_debug()
	///@desc draws the debug info for the tile above it
	static draw_debug = function () {
		var _info = [
			list_to_string_func(input_tile, function(x) { return string(x.index)}), 
			list_to_string_func(children, function(x) { return string(x.index)}), 
			string(index)
		]
		for (var i = 1; i < 4; i++) {
			//draw debug
			draw_set_colour(c_gray)
			draw_rectangle(x - size, y - size - i*15, x - size + string_width(_info[i-1]), y - size, false)
			draw_set_colour(c_white)
			draw_text(x - size, y - size - i*15 + 7, _info[i-1])
		}
	}
	
	#endregion Drawing functions

	///@func toString()
	///@desc the string representation of the struct
	static toString = function () {
		return "Spell Tile '" + name + "' at {" + string(pos_x) + ", " + string(pos_y) + "}"
	}
}


function basic_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.BASIC
	
	static draw = function () {
		draw_base()

		//draw name and its ring
		draw_text_circle(x, y, name, size - 10, spell.age, 360, true)
		draw_circle_outline(x, y, size - 20)
	}
	
	//init
	get_data()
	get_size()
}


function trick_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.TRICK
	other.sprite_index = sprite_index
	
	static draw = function () {
		draw_base()
		
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
	
	//init
	get_data()
	get_size()
}


function converter_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.CONVERTER
	
	static draw = function () {
		draw_base()
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
	
	//init
	get_data()
	get_size()
}


function bin_counter_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.BIN_COUNTER
	bin_value = int_to_bin(value)
	variable_size = true
	
	static draw = function () {
		draw_base()
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
	
	//init
	get_data()
	get_size()
}


function counter_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.COUNTER
	variable_size = true
	
	static draw = function () {
		draw_base()
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
	
	//init
	get_data()
	get_size()
}


function shell_spell_tile(_px, _py, _data, _index) : spell_tile(_px, _py, _data, _index) constructor {
	type = TYPE.SHELL
	
	static draw = function () {
		draw_base()
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
	
	//init
	get_data()
	get_size()
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
				if is_struct(children[| i]) { 
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
		
		draw_base()

		//draw name and its ring
		draw_text_circle(x, y, name, size - 10, spell.age, 360, true)
		draw_circle_outline(x, y, size - 20)
	}
	
	//init
	get_data()
	get_size()
}
