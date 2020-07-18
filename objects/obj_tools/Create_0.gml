/// @description Insert description here
// You can write your code in this editor

spell = noone
active = false

var _sz = 1.5*40*2/sqrt(3)

set_context = function (_context) {
	var _c = context
	context = is_undefined(_context) ? context : _context
	if (context > -1) {
		for (var i = 0; i < array_length(context_buttons[context]); i++) {
			context_buttons[context][i].init()	
		}
	} else if (_context = -1) {
		buttons[_c].toggle(false)
	}
}

buttons =	[
				new button(room_width - 90,	50 + 0*_sz, spr_add_motion, c_aqua, "DRAW CONNECTORS"
					,function(){ 
						buttons[0].toggle()
						if (buttons[0].active) {
							//activate
							spell.drag_path_length_max = 0 
							spell.movable = false
							spell.drag_action = DRAG.CONNECTOR
							set_context(0)
						} else {
							//deactivate
							spell.movable = true
							spell.drag_action = DRAG.NONE
							set_context(-1)
						}
					}
				),
				new button(room_width - 50,	50 + 1*_sz, spr_add_motion, c_aqua, "TEST 1"
					,function(){ buttons[1].y += 5 }
				),
				new button(room_width - 90,	50 + 2*_sz, spr_add_motion, c_aqua, "TEST 12"
					,function(){ buttons[2].x += 5 }
				),
				new button(room_width - 50,	50 + 3*_sz, spr_add_motion, c_aqua, "TEST 123"
					,function(){ buttons[3].size += irandom(10) - 5 }
				),
				new button(room_width - 90,	50 + 4*_sz, spr_add_motion, c_aqua, "TEST 1234"
					,function(){ buttons[4].image_blend += 100 }
				),
				new button(room_width - 50,	50 + 5*_sz, spr_add_motion, c_aqua, "TEST 12345"
					,function(){ buttons[5].rename(buttons[5].name + string(string_length(buttons[5].name))) }
				)
			]

context = -1
context_buttons =	[
						[ //Draw Connectors
							new button(50,	50 + _sz, spr_menu_circle, $30af40, "Accept"
								,function(){ 
									set_context(-1)
								}, 30, 1
							),
							new button(50,	90 + 2*_sz, spr_menu_null, c_red, "Discard"
								,function(){ 
									spell.drag_path_length = 0 
									spell.drag_path_length_max = 0 
									set_context(-1)
								}, 30, 1
							),
							new button(25,	90 + 3*_sz, spr_menu_arrow, c_fuchsia, "Undo"
								,function(){ 
									if (spell.drag_path_length > 0) {
										spell.drag_path_length -= 1 
										context_buttons[0][2].toggle(context_buttons[0][2].active_check())
										context_buttons[0][3].toggle(false)
									}
								}, 30, 1, function () { return spell.drag_path_length <= 0 }
							),
							new button(75,	90 + 3*_sz, spr_menu_arrow, c_olive, "Redo"
								,function(){ 
									if (spell.drag_path_length < spell.drag_path_length_max) {
										spell.drag_path_length += 1 
										context_buttons[0][2].toggle(false)
										context_buttons[0][3].toggle(context_buttons[0][3].active_check())
									}
								}, 30, 1, function () { return spell.drag_path_length >= spell.drag_path_length_max }
							),
							new button(50,	90 + 4*_sz, spr_menu_null, c_red, "Wires"
								,function(){ 
									//do stuff later
									context_buttons[0][4].toggle()
									spell.drag_empty = context_buttons[0][4].active
								}, 30, 1
							),
						],
					]