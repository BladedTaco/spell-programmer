/// A collection of scripts that deal with translating positions into coordinates
///	and coordinates into tiles

/// Functions:
///		get_mouse_tile
///		mouse_to_tile
///		pos_to_tile
///		point_in_hex

//--------------------------------------------------------------------------------------------------

///@func get_mouse_tile(spell)
///@param spell - the spell object
///@desc return the tile at the mouse position with a standard 30px gap between tile borders
function get_mouse_tile(_spell){
	var _pos = mouse_to_tile(_spell, 30)
	if (_pos == noone) return noone
	return cell_data(_spell, _pos[0], _pos[1])
}

//--------------------------------------------------------------------------------------------------

///@func mouse_to_tile(spell, *gap)
///@param spell - the spell object to check against
///@param *gap - how big of a gap there is between tiles of the hex grid
///@desc gives the tile the mouse is currently in for the given spell object
function mouse_to_tile(_spell, _gap) {
	
	_gap = is_undefined(_gap) ? 0 : _gap
	
	var _x, _y, _tx, _ty;

	with (_spell) { //with the spell object
		//get x and y cell position shifted up
		_y = (mouse_y - y - lengthdir_y(hex_size/2, 30))/(HEX_MUL*hex_size)
		_x = (mouse_x - x)/(2*bubble_size) + 0.5*(round(abs(_y)) mod 2 == 1)
	
		//get home tile position
		_tx = 2*round(_x) - (round(abs(_y)) mod 2 == 1)
		_ty = round(_y)
	
		//get x and y to check against
		_x = (mouse_x - x)/bubble_size
		_y = (mouse_y - y)/hex_size
	
		//get closest 3 cells and test their distance
		var _p1, _p2, _p3, _scl;
		_scl = cos(degtorad(30))
		_x *= _scl
		_p1 = point_distance(_x, _y, (_tx	 )*_scl,		  _ty*HEX_MUL) //home
		_p2 = point_distance(_x, _y, (_tx - 1)*_scl,	(_ty - 1)*HEX_MUL) //up left
		_p3 = point_distance(_x, _y, (_tx + 1)*_scl,	(_ty - 1)*HEX_MUL) //up right

		if (global.debug and keyboard_check(vk_shift)) {
			draw_set_colour(c_black)
			draw_line_width(mouse_x, mouse_y,	
						x + _tx*bubble_size,	   y + _ty*HEX_MUL*hex_size, 5
			)
			draw_text(	x + _tx*bubble_size,	   y + _ty*HEX_MUL*hex_size, _p1)
			draw_set_colour(c_lime)
			draw_line_width(mouse_x, mouse_y,	
						x + (_tx - 1)*bubble_size, y + (_ty - 1)*HEX_MUL*hex_size, 5
			)
			draw_text(	x + (_tx - 1)*bubble_size, y + (_ty - 1)*HEX_MUL*hex_size, _p2)
			draw_set_colour(c_yellow)
			draw_line_width(mouse_x, mouse_y,	
						x + (_tx + 1)*bubble_size, y + (_ty - 1)*HEX_MUL*hex_size, 5
			)
			draw_text(	x + (_tx + 1)*bubble_size, y + (_ty - 1)*HEX_MUL*hex_size, _p3)
		}

		//return the cell with the smallest distance
		if ((_p1 < _p2) and (_p1 < _p3)) { //home
			if (_gap > 0) {
				if !point_in_hex(mouse_x, mouse_y, x + _tx*bubble_size,	   y + _ty*HEX_MUL*hex_size,		hex_size - _gap, 90) {
					return noone
				}
			}
			return [_tx, _ty]
		} else if ((_p2 < _p1) and (_p2 < _p3)) { //up left
			if (_gap > 0) {
				if !point_in_hex(mouse_x, mouse_y, x + (_tx - 1)*bubble_size, y + (_ty - 1)*HEX_MUL*hex_size,	hex_size - _gap, 90) {
					return noone
				}
			}
			return [_tx - 1, _ty - 1]
		} else { //up right
			if (_gap > 0) {
				if !point_in_hex(mouse_x, mouse_y, x + (_tx + 1)*bubble_size, y + (_ty - 1)*HEX_MUL*hex_size,	hex_size - _gap, 90) {
					return noone
				}
			}
			return [_tx + 1, _ty - 1]
		}
	}
}

//--------------------------------------------------------------------------------------------------

///@func pos_to_tile(spell, x, y)
///@param spell - the spell object to check against
///@param x - the x position
///@param y - the y position
///@desc gives the tile the mouse is currently in for the given spell object
function pos_to_tile() {

	var _x, _y, _tx, _ty;

	with (argument[0]) { //with the spell object
		//get x and y cell position shifted up
		_y = (argument[2] - y - lengthdir_y(hex_size/2, 30))/(HEX_MUL*hex_size)
		_x = (argument[1] - x)/(2*bubble_size) + 0.5*(round(abs(_y)) mod 2 == 1)
	
		//get home tile position
		_tx = 2*round(_x) - (round(abs(_y)) mod 2 == 1)
		_ty = round(_y)
	
		//get x and y to check against
		_x = (argument[1] - x)/bubble_size
		_y = (argument[2] - y)/hex_size
	
		//get closest 3 cells and test their distance
		var _p1, _p2, _p3, _scl;
		_scl = cos(degtorad(30))
		_x *= _scl
		_p1 = point_distance(_x, _y, (_tx	 )*_scl,		  _ty*HEX_MUL) //home
		_p2 = point_distance(_x, _y, (_tx - 1)*_scl,	(_ty - 1)*HEX_MUL) //up left
		_p3 = point_distance(_x, _y, (_tx + 1)*_scl,	(_ty - 1)*HEX_MUL) //up right

		if (global.debug and keyboard_check(vk_shift)) {
			draw_set_colour(c_black)
			draw_line_width(x + _x*bubble_size, y + _y*HEX_MUL*hex_size, x + _tx*bubble_size,		y + _ty*HEX_MUL*hex_size, 5)
			draw_text(x + _tx*bubble_size,		y + _ty*HEX_MUL*hex_size, _p1)
			draw_set_colour(c_lime)
			draw_line_width(x + _x*bubble_size, y + _y*HEX_MUL*hex_size, x + (_tx - 1)*bubble_size, y + (_ty - 1)*HEX_MUL*hex_size, 5)
			draw_text(x + (_tx - 1)*bubble_size, y + (_ty - 1)*HEX_MUL*hex_size, _p2)
			draw_set_colour(c_yellow)
			draw_line_width(x + _x*bubble_size, y + _y*HEX_MUL*hex_size, x + (_tx + 1)*bubble_size, y + (_ty - 1)*HEX_MUL*hex_size, 5)
			draw_text(x + (_tx + 1)*bubble_size, y + (_ty - 1)*HEX_MUL*hex_size, _p3)
		}

		//return the cell with the smallest distance
		if ((_p1 < _p2) and (_p1 < _p3)) { //home
			return [_tx, _ty]
		} else if ((_p2 < _p1) and (_p2 < _p3)) { //up left
			return [_tx - 1, _ty - 1]
		} else { //up right
			return [_tx + 1, _ty - 1]
		}
	}
}

//--------------------------------------------------------------------------------------------------

///@func point_in_hex(px, py, hx, hy, rad, dir)
///@param px - the x position of the point to test
///@param py - the y position of the point to test
///@param hx - the x position of the hexagon
///@param hy - the y position of the hexagon
///@param rad - the radius of the hexagon
///@param dir - the direction of the hexagon (the direction of the first point)
///@desc returns whether the given point is within the given hexagon
function point_in_hex(px, py, hx, hy, rad, dir){
	var _sqrt3 = sqrt(3)
	
	dir = degtorad((dir + point_direction(px, py, hx, hy)) mod 60)
	
	return point_distance(px, py, hx, hy) <= (_sqrt3*rad / (_sqrt3*cos(dir) + sin(dir)))
}