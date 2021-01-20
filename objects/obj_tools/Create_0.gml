/// @description Insert description here
// You can write your code in this editor

spell = noone
active = false
context = -1
buttons = []
context_buttons = []


set_context = function (_context) {
	var _c = context
	context = is_undefined(_context) ? context : _context
	if (context > -1) {
		for (var i = 0; i < array_length(context_buttons[context]); i++) {
			context_buttons[context][i].init()	
		}
	} else if (_context = -1) {
		buttons[_c].toggle(false)
		spell.movable = true
		spell.drag_action = DRAG.NONE
		spell.menu_available = true;
	}
}

deactivate_menus = function () {
	spell.menu_available = false;	
	with (obj_menu) {
		instance_destroy();	
	}
}