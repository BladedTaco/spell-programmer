/// @description Create Buttons
// This is where all the buttons are created
var _sz = 1.5*40*2/sqrt(3)

buttons =	
	[
		new button(room_width - 90,	50 + 0*_sz, spr_add_motion, c_aqua, "DRAW CONNECTORS"
			,function(){ 
				toggle()
				if (active) {
					//activate
					spell.drag_path_length_max = 0 
					spell.movable = false
					spell.drag_action = DRAG.CONNECTOR
					other.set_context(0)
				} else {
					//deactivate
					other.set_context(-1)
				}
			}
		),
		new button(room_width - 50,	50 + 1*_sz, spr_add_motion, c_aqua, "TEST 1"
			,function(){ y += 5 }
		),
		new button(room_width - 90,	50 + 2*_sz, spr_add_motion, c_aqua, "TEST 12"
			,function(){ x += 5 }
		),
		new button(room_width - 50,	50 + 3*_sz, spr_add_motion, c_aqua, "TEST 123"
			,function(){ size += irandom(10) - 5 }
		),
		new button(room_width - 90,	50 + 4*_sz, spr_add_motion, c_aqua, "TEST 1234"
			,function(){ image_blend += 100 }
		),
		new button(room_width - 50,	50 + 5*_sz, spr_add_motion, c_aqua, "TEST 12345"
			,function(){ rename(name + string(string_length(name))) }
		)
	]


var _x = 50
var _y = 50
var _sep = 15
_sz = 1.5*30*2/sqrt(3)

context_buttons =	
	[
		[ //Draw Connectors
			new button(_x - _sep,	_y + 0*_sz, spr_menu_circle, $30af40, "Accept"
				,function(){ 
					with (spell) {
						for (var i = 0; i < drag_path_length; i++) {
							force_tile_output(drag_path[i].source, drag_path[i].dest, true)
						}
						drag_path_length = 0
						drag_path_length_max = 0
						//COPYPASTA, TODO REFACTOR
							//recalculate all connectors and update wires
							get_connector_names()
							//update wires
							//update wire heads |Slightly inefficient, wire paths done twice
							get_wire_heads()
							for (i = 0; i < array_length(wire_heads); i++) {
								with (wire_heads[i]) {
									get_wire_data()	
								}
							}
							check_ports(id)
					}
					other.set_context(-1)
				}, 30, 1
			),
			new button(_x + _sep,	_y + 1*_sz, spr_menu_null, c_red, "Discard"
				,function(){ 
					spell.drag_path_length = 0 
					spell.drag_path_length_max = 0 
					other.set_context(-1)
				}, 30, 1
			),
			new button(_x - _sep,	_y + 2*_sz, spr_menu_arrow, c_fuchsia, "Undo"
				,function(){ 
					if (spell.drag_path_length > 0) {
						spell.drag_path_length -= 1 
						toggle(active_check())
						other.context_buttons[0][3].toggle(false)
					}
				}, 30, 1, function () { return spell.drag_path_length <= 0 }
			),
			new button(_x + _sep,	_y + 3*_sz, spr_menu_arrow, c_olive, "Redo"
				,function(){ 
					if (spell.drag_path_length < spell.drag_path_length_max) {
						spell.drag_path_length += 1 
						other.context_buttons[0][2].toggle(false)
						toggle(active_check())
					}
				}, 30, 1, function () { return spell.drag_path_length >= spell.drag_path_length_max }
			),
			new button(_x - _sep,	_y + 4*_sz, spr_menu_null, c_red, "Wires"
				,function(){ 
					//do stuff later
					toggle()
					spell.drag_empty = active
				}, 30, 1
			),
		],
	]