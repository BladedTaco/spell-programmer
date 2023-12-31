///@func button(x, y, sprite, colour, message, *action, *size, *facing, *active_check)
///@param {real} x - the x centre of the button
///@param {real} y - the y centre of the button
///@param {sprite} sprite - the sprite to draw on the button
///@param {colour} colour - the colour to draw the button in
///@param {string} message - the mouseover text
///@param {func} *action - the function to execute on button press
///@param {real} *size - the size of the button
///@param {real} *facing - the direction of the button corner
///@param {func} *active_check - the function to check if the button is active
function button(_x, _y, _sprite, _col, _message, _action, _size, _facing, _active_check) constructor {
	if (false) return argument[0]
	//used to avoid the wrong number of arguments error
	x = _x;
	y = _y;
	sprite_index = _sprite
	name = _message
	image_blend = _col// function, called on click
	action = is_undefined(_action) ? function () { show_debug_message("Click: " + string(self)) } :  method(self, _action)
	size = is_undefined(_size) ? 40 : _size
	side = is_undefined(_facing) ? -1 : _facing
	active_check = is_undefined(_active_check) ? function () { return active } : method(self, _active_check)
	dir = 90
	blend = 1
	name_length = string_width(name)
	active = false
	visible = true
	active_colour = merge_colour(image_blend, c_black, 0.7)
	base_colour = image_blend
	spell = other.spell
	
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
		if visible {
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
				if (side > 0) {
					draw_set_halign(fa_left)
				} else {
					draw_set_halign(fa_right)
				}
				draw_set_valign(fa_middle)
				draw_set_alpha(0.8)
				draw_rectangle(x + size*side, y - 11, x + (size + name_length + 10)*side, y + 9, false)
				draw_set_colour(c_white)
				draw_text(x + (size + 5)*side, y - 1, name)
				draw_set_alpha(1)
			}
		}
	}
	
	static rename = function (_name) {
		name = _name
		name_length = string_width(name)
	}
	
	static toggle = function (_override) {
		///@param *_override - force on or off instead of toggle
		_override = is_undefined(_override) ? !active : _override
		if _override {
			//activate
			active = true
			image_blend = active_colour	
		} else {
			//deactivate
			active = false
			image_blend = base_colour
		}
	}
	
	//placeholder i guess
	static init = function () {
		toggle(active_check())
		visible = true
	}
	
	static toString = function () {
		return "Button '" + name + "' at {" + string(x) + ", " + string(y) + "}"
	}
}