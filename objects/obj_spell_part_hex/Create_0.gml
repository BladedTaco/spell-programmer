/// @description 

index = -1;
tile = SPELL.MANA
type = TYPE.BASIC
name = ""
connector_name = [" ", " ", " ", " ", " ", " "]	
value = 0;
max_size = 0;
size = 0;
bubble_size = 0;
hex_size = 0;
cell_size = 0;
children = -1;
children_number = 0;
base_size = 60;
size = base_size;
size_ratio = 0.5
age = 0
connector_queue = [];
inputs = [];
input_colour = [];
input_number = 0;
input_tile = ds_list_create();
parent = noone; //the trick tile
spell = noone; //the obj_spell
creator = noone; //the previous tile
level = 0;
//width = room_width;
//height = room_height;
zero_angle = 0;
pos_x = 0;
pos_y = 0;

width = 4096
height = 4096

clip_surface = -1
clockwise_surface = -1;
anticlockwise_surface = -1;
circle_surface = -1;

radius = 1;

colours = [];
colour_cycle = false;
colour_number = 0;
group_colour = COLOUR.EMPTY;

binary_counter = true;
small_max_val = power(2, 9) - 1;
max_val = power(2, 23) - 1;



//new_call = function(_num) {
//	return _num	
//}

//mystruct = {
//	a : 20,
//	b : self.id,
//	toString: function() {
//		return "This is a test struct: " + string(a);
//	},
//	call : function(_amount) {
//		_amount = is_undefined(_amount) ? 1 : _amount;
//		for (i = 0; i < _amount; i++) {
//			show_debug_message(self)
//		}
//	},
//	static_call : function() {
//		static _a = 0;
//		a = _a++
//		show_debug_message(self)
//	},
//	//new_call : show_debug_message(self.new_call)
//	new_call : 0
//	//s : function(_a) constructor {
//	//	a = _a	
//	//	static increment = function(_amount) {
//	//		a += _amount	
//	//	}
//	//}
//}

//mystruct.static_call()

//for (i = 0; i < 100; i++) {
//	try {
//		i()
//		i(undefined)
//		i(undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)
//	} catch(error) {
//		show_debug_message(string(i) + " " + error.message)
//	}
//}

//for (i = 0; i < 100; i++) {
//	mystruct.new_call = i
//	try {
//		mystruct.new_call()
//		mystruct.new_call(undefined)
//		mystruct.new_call(undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)
//	} catch(error) {
//		show_debug_message(string(i) + " " + error.message)
//	}
//}
//mystruct.new_call(mystruct.a)

//s = new mystruct.s(20)
//s.increment(1)
//show_debug_message(s.a)