/// @description Insert description here
// You can write your code in this editor

spell = noone
active = false

var _sz = 1.5*40*2/sqrt(3)

buttons =	[
				new button(room_width - 90,	50 + 0*_sz, spr_add_motion, c_aqua, "TEST"
					,function(){ buttons[0].dir += 20 }
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
			]
