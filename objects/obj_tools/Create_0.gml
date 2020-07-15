/// @description Insert description here
// You can write your code in this editor

spell = noone
active = false

var _sz = 1.5*40*2/sqrt(3)

buttons =	[
				new button(room_width - 90,	50 + 0*_sz, spr_add_motion, c_aqua, "DRAW CONNECTORS"
					,function(){ 
						if (!buttons[0].active) {
							spell.movable = false
							spell.drag_action = DRAG.CONNECTOR
							buttons[0].active = true
							buttons[0].image_blend = buttons[0].active_colour
						} else {
							spell.movable = true
							spell.drag_action = DRAG.NONE
							buttons[0].active = false
							buttons[0].image_blend = buttons[0].base_colour
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
				),
				new button(50,	50 + _sz, spr_menu_circle, $30af40, "Accept"
					,function(){ 
						buttons[6].visible = false
						buttons[7].visible = false 
					}, 30, 1
				),
				new button(50,	90 + 2*_sz, spr_menu_null, c_red, "Discard"
					,function(){ 
						spell.drag_path_length = 0 
						buttons[6].visible = false
						buttons[7].visible = false
					}, 30, 1
				),
			]
buttons[6].visible = false
buttons[7].visible = false