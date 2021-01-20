/// @description Create Buttons
// This is where all the buttons are created
var _sz = 1.5*40*2/sqrt(3)

buttons =	
	[
		new button(room_width - 90,	50 + 0*_sz, spr_tool_wire, c_aqua, "DRAW CONNECTORS"
			,function(){ 
				toggle()
				if (active) {
					//activate
					spell.drag_path_length_max = 0 
					spell.drag_path_length = 0
					spell.movable = false
					spell.drag_action = DRAG.CONNECTOR
					other.deactivate_menus()
					other.set_context(0)
				} else {
					//deactivate
					method(self, other.context_buttons[0][1].action)() 
				}
			}
		),
		new button(room_width - 50,	50 + 1*_sz, spr_add_motion, c_aqua, "Layer"
			,function(){ y += 5 }
		),
		//Prefabs - Save | Load | Manage | Import
		new button(room_width - 90,	50 + 2*_sz, spr_add_motion, c_aqua, "Prefabs"
			,function(){ x += 5 }
		),
		// Save/Load - Save | Load | Manage | Import
		new button(room_width - 50,	50 + 3*_sz, spr_add_motion, c_aqua, "Save/Load"
			,function(){ size += irandom(10) - 5 }
		),
		// Optimize - Trim Leaves | Shorten Wires | Bake constants | Freeze
		new button(room_width - 90,	50 + 4*_sz, spr_add_motion, c_aqua, "Optimize"
			,function(){ image_blend += 100 }
		),
		// Compile - Test | Export | 
		new button(room_width - 50,	50 + 5*_sz, spr_add_motion, c_aqua, "Compile"
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
					for (var i = 0; i < spell.drag_path_length; i++) {
						spell.drag_path[i].name = ""
					}
					with (spell) {
						//reset drag path
						drag_path_length = 0
						drag_path_length_max = 0
					}
					other.set_context(-1)
				}, 30, 1
			),
			new button(_x + _sep,	_y + 1*_sz, spr_menu_null, c_red, "Discard"
				,function(){ 
					for (var i = 0; i < spell.drag_path_length; i++) {
						//destroy
						spell.drag_path[i].destroy()
					}
					spell.drag_path_length = 0 
					spell.drag_path_length_max = 0 
					other.set_context(-1)
				}, 30, 1
			),
			new button(_x - _sep,	_y + 2*_sz, spr_menu_undo, c_fuchsia, "Undo"
				,function(){ 
					if (spell.drag_path_length > 0) {
						//remove connector
						spell.drag_path_length -= 1 
						spell.drag_path[spell.drag_path_length].destroy()
						//remove tile if applicable
						if (instanceof(spell.drag_path[spell.drag_path_length - 1]) == "wire_spell_tile") {
							spell.drag_path_length -= 1 
							spell.drag_path[spell.drag_path_length].destroy()
						}
						toggle(active_check())
						other.context_buttons[0][3].toggle(false)
					}
				}, 30, 1, function () { return spell.drag_path_length <= 0 }
			),
			new button(_x + _sep,	_y + 3*_sz, spr_menu_redo, c_olive, "Redo"
				,function(){ 
					if (spell.drag_path_length < spell.drag_path_length_max) {
						//remove connector
						spell.drag_path[spell.drag_path_length].recreate()
						spell.drag_path_length += 1 
						//remove tile if applicable
						if (instanceof(spell.drag_path[spell.drag_path_length - 1]) == "wire_spell_tile") {
							spell.drag_path[spell.drag_path_length].recreate()
							spell.drag_path_length += 1 
						}
						
						other.context_buttons[0][2].toggle(false)
						toggle(active_check())
					}
				}, 30, 1, function () { return spell.drag_path_length >= spell.drag_path_length_max }
			),
			new button(_x - _sep,	_y + 4*_sz, spr_tool_sub_wire, c_red, "Create Wires"
				,function(){ 
					//do stuff later
					toggle()
					spell.drag_empty = active
				}, 30, 1
			),
		],
		[ // Layer
			new button(_x - _sep,	_y + 0*_sz, spr_menu_circle, $30af40, "Move up"
				,function(){ 
				}, 30, 1
			),
			new button(_x + _sep,	_y + 1*_sz, spr_menu_null, c_red, "Move down"
				,function(){ 
				}, 30, 1
			),
			new button(_x - _sep,	_y + 2*_sz, spr_menu_arrow, c_fuchsia, "Delete Layer"
				,function(){ 
				}, 30, 1
			),
			new button(_x + _sep,	_y + 3*_sz, spr_menu_arrow, c_olive, "New Layer"
				,function(){ 
				}, 30, 1
			),
			new button(_x - _sep,	_y + 4*_sz, spr_menu_null, c_red, "Reorder Layers"
				,function(){
				}, 30, 1
			),
		],
		
	]