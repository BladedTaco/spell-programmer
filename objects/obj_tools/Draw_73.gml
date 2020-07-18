/// @description Insert description here
// You can write your code in this editor
draw_set_colour(c_gray)
draw_set_alpha(0.8)
draw_polygon(x, y, 600, 90, 6, true)
draw_set_colour(c_dkgray)
draw_polygon(x, y, 600, 90, 6, false, 2)
draw_set_alpha(1.0)

//draw buttons
var i, _b;
for (i = 0; i < array_length(buttons); i++) {
	_b = buttons[i]
	with (_b) {
		update()
		draw()
	}
}

//draw context menu buttons
if (context >= 0) {
	var _c = context
	for (i = 0; i < array_length(context_buttons[_c]); i++) {
		_b = context_buttons[_c][i]
		with (_b) {
			update()
			draw()
		}
	}
}