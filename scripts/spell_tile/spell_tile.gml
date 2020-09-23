///@func new_spell_tile(px, py, data, *index)
///@param px - the x coordinate in the hex grid
///@param py - the y coordinate in the hex grid
///@param data - the struct containing the tile data
///@param *index - the index of the tile, if unset will be largest untaken
///@desc creates and returns a new spell tile of the given paramaters
function new_spell_tile(_px, _py, _data, _index) {	
	if (0) { return argument[0] }
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
	names = -1
	name_paths = ds_list_create()
	
	//need to remove
	
	//maybe?
	//small_max_val = power(2, 9) - 1;
	//max_val = power(2, 23) - 1;
	max_val = [0, power(2, 9) - 1, power(2, 23) - 1, power(2, 32) - 1]
	max_radius = 3
	zero_angle = 0;
	
	///@func propogate_name(goal, name, connect)
	///@param {tile} goal - the tile that has this tile as an input_tile
	///@param {string/struct} name - the name to propogate
	///@param {true/false} connect - if it is a connection being made
	///@desc propogates a names addition or removal
	static propogate_name = function (_goal, _name, _connect) {
		if (_connect) {
			var _path = get_path(_goal, self)
			var _data = {name: _name, goal: _goal, tile: other}
			for (var i = 1; i < ds_list_size(_path); i++) {
				//give tile name
				_path[| i].add_name(_data)
				//give connector name
				spell.get_connector(_path[| i], _path[| i-1]).add_name(_data)
			}
			spell.get_connector(self, _path[| ds_list_size(_path) - 1]).add_name(_data)
			ds_list_add(name_paths, [_data, _path])
		} else {
			//remove name	
			for (var i = 0; i < ds_list_size(name_paths); i++) {
				//ds lists exist
				if (ds_exists(name_paths, ds_type_list) and ds_exists(name_paths[| i][1], ds_type_list)) {
					//either struct given, or parameters match struct data
					if ((name_paths[| i][0] == _name) or 
					(!is_struct(_name) and (name_paths[| i][0].name == _name) and (name_paths[| i][0].goal == _goal))) {
						//ensure _name is the struct
						_name = name_paths[| i][0]
						//connector path to clean
						_path = name_paths[| i][1]
						for (var o = 1; o < ds_list_size(_path); o++) {
							//remove tile name
							_path[| o].remove_name(_name)
							//remove connector name
							spell.get_connector(_path[| o], _path[| o-1]).remove_name(_name)
						}
						spell.get_connector(self, _path[| ds_list_size(_path) - 1]).remove_name(_name)
						ds_list_destroy(_path)
						ds_list_delete(name_paths, i)
						break;
					}
				}
			}
		}
	}
	
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
	static connect = function () {}//update_spell
	
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
			ds_list_add(children[| i].connectors, new connector(children[| i], self))
		}

		//get the id of each input
		for (i = 0; i < ds_list_size(input_tile); i++) {
			if (input_tile[| i] > 0) {
				input_tile[| i] = spell.children[| input_tile[| i]];
				//connectors[| i].
			}
		}
	}
	
	///@func recreate()
	///@desc recreates the connection after a destroy call, connector data is lost
	static recreate = function () {
		
		input_tile = ds_list_create()
		connectors = ds_list_create()
		name_paths = ds_list_create()
		if (type == TYPE.WIRE) {
			names = ds_list_create()
			colours = ds_list_create()
		}
		
		children_number = 0
		//children = ds_list_create()
		
		//set_tile(id, _m[0], _m[1], SPELLS.wire)
		with (spell) {
			children_number++	
			ds_list_add(spell, [SPELLS.wire, "", 0, -1, [other.pos_x, other.pos_y], -1])
			ds_list_add(children, other)
			other.index = children_number - 1
		}
		
		get_data()
		get_size()
		//children
		return self
	}
	
	///@func destroy()
	///@desc removes all references to spell tile and cleans up data structures
	static destroy = function () {
		//check for port break
		if (type == TYPE.WIRE) {
			for (var i = 0; i < ds_list_size(names); i++) {
				with (names[| i]) {
					tile.propogate_name(goal, self, false)
					ds_list_replace_value(goal.input_tile, tile, noone)	
					ds_list_replace_value(goal.spell.spell[| goal.index].inputs, tile.index, noone)	
				}
			}
		}
		
		//destroy parent connectors
		while (ds_list_size(connectors) > 0) {
			connectors[| 0].destroy()	
		}
		
		//destroy children connectors
		while (ds_list_size(children) > 0) {
			spell.get_connector(children[| 0], self).destroy()
		}
			
		//remove from spell
		with (spell) {
			//delete own entry
			var i = other.index
			ds_list_destroy(spell[| i].children)
			ds_list_destroy(spell[| i].inputs)
			ds_list_delete(spell, i)
			ds_list_delete(children, i)
			children_number--
			for (i = i; i < children_number; i++) {
				children[| i].index -= 1	
			}
			get_bubble()
		}	
			
		//clear ds lists
		ds_list_destroy(input_tile)
		ds_list_destroy(children)
		ds_list_destroy(connectors)
		for (var i = 0; i < ds_list_size(name_paths); i++) {
			ds_list_destroy(name_paths[| 1])	
		}
		ds_list_destroy(name_paths)
		if (type == TYPE.WIRE) {
			if (ds_exists(names, ds_type_list)) { ds_list_destroy(names) }
			if (ds_exists(colours, ds_type_list)) { ds_list_destroy(colours) }
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
			"inputs: " + list_to_string_func(input_tile, function(x) { return is_struct(x) ? string(x.index) : "X"}), 
			"children: " + list_to_string_func(children, function(x) { return is_struct(x) ? string(x.index) : "X"}), 
			"index: " + string(index)
		]
		for (var i = 1; i < 4; i++) {
			//draw debug
			draw_set_colour(c_gray)
			draw_rectangle(x - size, y - size - i*15, x - size + string_width(_info[i-1]), y - size - (i-1)*15, false)
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
	colours = ds_list_create()
	names = ds_list_create()
	
	///@func add_name(name)
	///@param {struct} name - the struct containing the name data
	///@desc adds the given name and updates the tiles name
	static add_name = function (_name) {
		ds_list_add(names, _name)
		ds_list_add(colours, _name.tile.image_blend)
		colour_cycle = true
		colour_number++
		get_name()
	}
	
	///@func remove_name(name)
	///@param {struct} name - the struct containing the name data
	///@desc removes the given name and updates the tiles name
	static remove_name = function (_name) {
		ds_list_delete_value(names, _name)
		ds_list_delete_value(colours, _name.tile.image_blend)
		colour_number--
		colour_cycle = (colour_number > 0)
		get_name()
	}
	
	///@func get_name()
	///@desc updates the name of the tile
	static get_name = function () {
		if (ds_list_size(names) > 0) {
			name = "  " + names[| 0].name
		} else {
			name = ""	
		}
		for (var i = 1; i < ds_list_size(names); i++) {
			name += " + " + names[| i].name
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
			image_blend = merge_colour(colours[| i], colours[| (i+1)%colour_number], o)
		} else {
			image_blend = COLOUR.WIRE	
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
