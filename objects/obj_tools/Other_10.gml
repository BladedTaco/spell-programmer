/// @description Create Buttons
// This is where all the buttons are created
var _sz = 1.5*40*2/sqrt(3)

var _col = merge_colour(c_aqua, c_blue, 0.7);

buttons =	
	[
		new button(room_width - 90,	50 + 0*_sz, spr_tool_wire, _col, "Draw Connectors"
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
					var _wire_btn = other.context_buttons[0][4];
					if (_wire_btn and !_wire_btn.active) {
						_wire_btn.action();
						//method(self, _wire_btn.action)()
					}
				} else {
					//deactivate
					other.context_buttons[0][1].action();
					//method(self, other.context_buttons[0][1].action)() 
				}
			}
		),
			
		
		new button(room_width - 50,	50 + 1*_sz, spr_tool_spell, _col, "Hide Spell"
			,function(){
				rename(global.wind ? "Hide Spell" : "Show Spell");
				global.wind = !global.wind 
			}
		),
		//Prefabs - Save | Load | Manage | Import
		new button(room_width - 90,	50 + 2*_sz, spr_tool_force, _col, "View Force Field"
			,function(){ 
				rename(global.forces ? "View Force Field" : "Hide Force Field");
				global.forces = !global.forces 
			}
		),
		// Save/Load - Save | Load | Manage | Import
		new button(room_width - 50,	50 + 3*_sz, spr_tool_pause, _col, "Pause Spinning"
			,function(){
				rename(global.pause ? "Pause Spinning" : "Unpause Spinning");
				global.pause = !global.pause
			}
		),
		// Optimize - Trim Leaves | Shorten Wires | Bake constants | Freeze
		new button(room_width - 90,	50 + 4*_sz, spr_tool_center, _col, "Center View"
			,function(){ 
				if (instance_exists(obj_spell)) { 
					with (obj_spell) {
						//move any menus
						if (instance_exists(obj_menu)) {
							with (obj_menu) {
								x -= other.x - room_width / 2
								y -= other.y - room_height / 2
							}
						} 
						// Move Spell
						x = room_width / 2
						y = room_height / 2
					} 
				} 
			}
		),
		// Compile - Test | Export | 
		new button(room_width - 50,	50 + 5*_sz, spr_tool_reset, _col, "Reset"
			,function(){
				if (os_browser == browser_not_a_browser) {
					// destroy menus
					with (obj_menu) {
						instance_destroy(self)	
					}
					// destroy spell
					with (obj_spell) {
						instance_destroy(self)	
					}
				
					//// destroy tool menu
					//instance_destroy(obj_tools)	
				
					// recreate spell
					instance_create(room_width/2, room_height/2, obj_spell)
				} else {
					room_restart()
				}
			}
		)
		
		
		//new button(room_width - 50,	50 + 1*_sz, spr_add_motion, _col, "Layer"
		//	,function(){ y += 5 }
		//),
		////Prefabs - Save | Load | Manage | Import
		//new button(room_width - 90,	50 + 2*_sz, spr_add_motion, _col, "Prefabs"
		//	,function(){ x += 5 }
		//),
		//// Save/Load - Save | Load | Manage | Import
		//new button(room_width - 50,	50 + 3*_sz, spr_add_motion, _col, "Save/Load"
		//	,function(){ size += irandom(10) - 5 }
		//),
		//// Optimize - Trim Leaves | Shorten Wires | Bake constants | Freeze
		//new button(room_width - 90,	50 + 4*_sz, spr_add_motion, _col, "Optimize"
		//	,function(){ image_blend += 100 }
		//),
		//// Compile - Test | Export | 
		//new button(room_width - 50,	50 + 5*_sz, spr_add_motion, _col, "Compile"
		//	,function(){ rename(name + string(string_length(name))) }
		//)
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
			new button(_x - _sep,	_y + 4*_sz, spr_tool_sub_wire, c_red, "Allow Wire Creation"
				,function(){ 
					//do stuff later
					toggle()
					spell.drag_empty = active
					rename(name == "Allow Wire Creation" ? "Disallow Wire Creation" : "Allow Wire Creation" )
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