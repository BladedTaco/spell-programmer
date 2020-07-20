/// @description Create Buttons
// You can write your code in this editor
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
					spell.movable = true
					spell.drag_action = DRAG.NONE
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


context_buttons =	
	[
		[ //Draw Connectors
			new button(50,	50 + _sz, spr_menu_circle, $30af40, "Accept"
				,function(){ 
					with (spell) {
						//for (var i = drag_path_length - 1; i >= 0 ; i--) {
						//	set_tile_output(id, drag_path[i].source, drag_path[i].dest)
						//}
						for (var i = 0; i < drag_path_length; i++) {
							force_tile_output(id, drag_path[i].source, drag_path[i].dest)
						}
						drag_path_length = 0
						drag_path_length_max = 0
					}
					other.set_context(-1)
				}, 30, 1
			),
			new button(50,	90 + 2*_sz, spr_menu_null, c_red, "Discard"
				,function(){ 
					spell.drag_path_length = 0 
					spell.drag_path_length_max = 0 
					other.set_context(-1)
				}, 30, 1
			),
			new button(25,	90 + 3*_sz, spr_menu_arrow, c_fuchsia, "Undo"
				,function(){ 
					if (spell.drag_path_length > 0) {
						spell.drag_path_length -= 1 
						toggle(active_check())
						other.context_buttons[0][3].toggle(false)
					}
				}, 30, 1, function () { return spell.drag_path_length <= 0 }
			),
			new button(75,	90 + 3*_sz, spr_menu_arrow, c_olive, "Redo"
				,function(){ 
					if (spell.drag_path_length < spell.drag_path_length_max) {
						spell.drag_path_length += 1 
						other.context_buttons[0][2].toggle(false)
						toggle(active_check())
					}
				}, 30, 1, function () { return spell.drag_path_length >= spell.drag_path_length_max }
			),
			new button(50,	90 + 4*_sz, spr_menu_null, c_red, "Wires"
				,function(){ 
					//do stuff later
					toggle()
					spell.drag_empty = active
				}, 30, 1
			),
		],
	]