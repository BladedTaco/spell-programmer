///@func mouse_to_tile(spell)
///@param spell - the spell object to check against
///@desc gives the tile the mouse is currently in for the given spell object

function mouse_to_tile() {

	var _x, _y, _tx, _ty;

	with (argument[0]) { //with the spell object
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

		if (keyboard_check(vk_shift)) {
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


var _x, _y, _tx, _ty;

with (argument[0]) { //with the spell object
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

	if (keyboard_check(vk_shift)) {
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

