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
	}
}
