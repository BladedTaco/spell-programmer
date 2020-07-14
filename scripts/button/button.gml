// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function button(_x, _y, _sprite, _col, _message, _action) constructor {
	if (false) return argument[0]
	//used to avoid the wrong number of arguments error
	x = _x;
	y = _y;
	sprite_index = _sprite
	name = _message
	image_blend = _col// function, called on click
	action = is_undefined(_action) ? function () { show_debug_message("Click: " + string(self)) } : _action
	size = 40
	dir = 90
	blend = 1
	name_length = string_width(name)
	
	static update = function() {
		//@desc call to update the buttons look	
		blend = 1
		if (point_distance(x, y, mouse_x, mouse_y) < size) {
			blend = 1.7
			if (mouse_check_button(mb_left)) {
				blend = 0.7
				if (mouse_check_button_pressed(mb_left)) {
					action()
				}
			}
		}
	}
	
	static draw = function() {
		//backing
		draw_set_colour(
			blend <= 1 ?
			merge_colour(c_black, image_blend, blend) :
			merge_colour(image_blend, c_white, blend)
			)
		draw_polygon(x, y, size, dir, 6, true)
		//sprite
		draw_set_colour(c_white)
		draw_sprite(sprite_index, 0, x, y)
		//border
		draw_set_colour(merge_colour(c_black, image_blend, 0.5))
		draw_polygon(x, y, size, dir, 6, false)
		//name
		if (blend != 1) {
			draw_set_colour(c_black)
			draw_set_halign(fa_right)
			draw_set_valign(fa_middle)
			draw_set_alpha(0.8)
			draw_rectangle(x - size, y - 11, x - size - name_length - 10, y + 9, false)
			draw_set_colour(c_white)
			draw_text(x - size - 5, y - 1, name)
			draw_set_alpha(1)
		}
	}
	
	static rename = function (_name) {
		name = _name
		name_length = string_width(name)
	}
	
	static toString = function () {
		return "Button '" + name + "' at {" + string(x) + ", " + string(y) + "}"
	}
}