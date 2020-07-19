// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
///@func connector(_other, _self, _name, _col, _size, _alt_size, *_scale) 
function connector(_other, _self, _name, _col, _size, _alt_size, _scale) constructor {
	source = _self
	dest = _other
	name = _name
	image_blend = _col
	size = _size
	alt_size = _alt_size
	age = 0
	scale = is_undefined(_scale) ? 1 : _scale
	
	static draw = function () {
		//doesnt check for instances existing
		with (source.spell) {
			draw_set_colour(c_white)
			draw_connector(
				x + other.dest.pos_x*bubble_size,
				y + other.dest.pos_y*hex_size*HEX_MUL, 
				x + other.source.pos_x*bubble_size,
				y + other.source.pos_y*hex_size*HEX_MUL,
				other.name, other.image_blend, other.size, other.alt_size, other.age, other.scale
			)
			draw_circle_outline(x + other.dest.pos_x*bubble_size, y + other.dest.pos_y*hex_size*HEX_MUL, 20)
			draw_circle_outline(x + other.source.pos_x*bubble_size, y + other.source.pos_y*hex_size*HEX_MUL, 20)
		}
		age = ++age mod 360
	}
	
}