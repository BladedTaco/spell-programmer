/// A collection of scripts that deal with hex cells

/// Functions:
///		cell_data
///		cell_empty
///		cell_distance
///		cell_ring
///		cell_ring_empty
///		cell_ring_values

//--------------------------------------------------------------------------------------------------

///@func cell_data(spell, cell_x, cell_y)
///@param spell - the spell object
///@param cell_x - the x position of the cell (neighbours are two apart)
///@param cell_y - the y position of the cell
///@desc returns the id of the tile in the cell, use with spell object
function cell_data() {
	with (argument[0]) {
		var _child = noone;
	
		for (var i = 0; i < children_number; i++) {
			if ((spell[| i].pos_x = argument[1]) and (spell[| i].pos_y = argument[2])) {
				_child = children[| i]
				break;
			}
		}
	}
	return _child;
}

//--------------------------------------------------------------------------------------------------

///@func cell_empty(spell, cell_x, cell_y, wire)
///@param spell - the spell object
///@param cell_x - the x position of the cell (neighbours are two apart)
///@param cell_y - the y position of the cell
///@param wire - what wires should return
///@desc returns whether there is a tile in the cell, use with spell object
function cell_empty() {
	var _id = cell_data(argument[0], argument[1], argument[2])
	if (is_struct(_id)) {
		if (_id.type = TYPE.WIRE) {
			return argument[3] //return the given
		}
	}
	return is_struct(_id)
}

//--------------------------------------------------------------------------------------------------

///@func cell_distance(c1_x, c1_y, c2_x, c2_y)
///@param c1_x - the first cells x position
///@param c1_y - the first cells y position
///@param c2_x - the second cells x position
///@param c2_y - the second cells y position
///@desc returns the distance betweent the two cells
function cell_distance(c1_x, c1_y, c2_x, c2_y) {
	return	max(ceil(abs(c1_x - c2_x)/2), abs(c1_y - c2_y),
				ceil(-abs(c1_x - c2_x)/2 + abs(c1_y - c2_y))
			)
}

//--------------------------------------------------------------------------------------------------

///@func cell_ring(spell, x, y, radius)
///@param spell - the spell object
///@param x - the x coordinate of the centre of the ring of tiles
///@param y - the y coordinate of the centre of the ring of tiles
///@param radius - the radius of the ring of tiles, 0 is the tile, 1 is a ring
///@desc returns an array that holds the tiles in the given ring
function cell_ring(_spell, _x, _y, _rad) {
	//multipliers
	var _mx, _my;
	_mx = [1, -1, -1, 1]
	_my = [1, 1, -1, -1]
	
	//vars
	var _ret = []
	_ret[_rad*6 - 1] = noone //init array size
	var i, o, j = 0;
	var _off = _rad % 2
	
	//do 4 segments: +-x, +-y
	for (o = 0; o < 4; o++) {
		for (i = (_my[o] < 0); i < _rad; i++) {
			// / arm, starting from horizontally equal, and moving down-left
			_ret[j++] = cell_data(_spell, _x + _mx[o]*(2*_rad - i), _y + _my[o]*i)
		}
		for (i = max(0, (_mx[o] < 0) - _off); i < 1 + (_rad div 2); i++) {
			// _ arm, starting from vertically equal, and moving right
			_ret[j++] = cell_data(_spell, _x + _mx[o]*(2*i + _off), _y + _my[o]*_rad)
		}
	}
	return _ret
}	

//--------------------------------------------------------------------------------------------------

///@func cell_ring_empty(spell, x, y, radius)
///@param spell - the spell object
///@param x - the x coordinate of the centre of the ring of tiles
///@param y - the y coordinate of the centre of the ring of tiles
///@param radius - the radius of the ring of tiles, 0 is the tile, 1 is a ring
///@desc returns if any tiles are in the given ring, wires not counted
function cell_ring_empty(_spell, _x, _y, _rad) {
	//multipliers
	var _mx, _my;
	_mx = [1, -1, -1, 1]
	_my = [1, 1, -1, -1]
	
	//vars
	var i, o;
	var _off = _rad % 2
	
	//do 4 segments: +-x, +-y
	for (o = 0; o < 4; o++) {
		for (i = (_my[o] < 0); i < _rad; i++) {
			// / arm, starting from horizontally equal, and moving down-left
			if cell_empty(_spell, _x + _mx[o]*(2*_rad - i), _y + _my[o]*i, false) { return false }
		}
		for (i = max(0, (_mx[o] < 0) - _off); i < 1 + (_rad div 2); i++) {
			// _ arm, starting from vertically equal, and moving right
			if cell_empty(_spell, _x + _mx[o]*(2*i + _off), _y + _my[o]*_rad, false) { return false }
		}
	}
	return true
}	

//--------------------------------------------------------------------------------------------------

///@func cell_ring_values(x, y, radius)
///@param x - the x coordinate of the centre of the ring of tiles
///@param y - the y coordinate of the centre of the ring of tiles
///@param radius - the radius of the ring of tiles, 0 is the tile, 1 is a ring
///@desc returns the values of the cells in the given ring, order is as follows:
/*
		9	11	12
	8				10
5						1
	6				2
		7	3	4
in words: 
starting from furthest right, move clockwise
before reaching bottom,			go to middle bottom (right if needed),	move anticlockwise
after bottommost rightmost,		go furthest left middle,				move anticlockwise
before reaching bottom,			go to middle bottom left,				move clockwise
after bottommost leftmost,		go furthest left up,					move clockwise
before reaching top,			go top middle left,						move anticlockwise
after topmost leftmost,			go furthest right up,					move anticlockwise
before reaching top,			go top middle (right),					move clockwise

it is very confusing I know, but doing it in a circular order is far too much work
*/
function cell_ring_values(_x, _y, _rad) {
	//multipliers
	var _mx, _my;
	_mx = [1, -1, -1, 1]
	_my = [1, 1, -1, -1]
	
	//vars
	var _ret = []
	_ret[_rad*6 - 1] = noone //init array size
	var i, o, j = 0;
	var _off = _rad % 2
	
	//do 4 segments: +-x, +-y
	for (o = 0; o < 4; o++) {
		for (i = (_my[o] < 0); i < _rad; i++) {
			// / arm, starting from horizontally equal, and moving down-left
			_ret[j++] = [_x + _mx[o]*(2*_rad - i), _y + _my[o]*i]
		}
		for (i = max(0, (_mx[o] < 0) - _off); i < 1 + (_rad div 2); i++) {
			// _ arm, starting from vertically equal, and moving right
			_ret[j++] = [_x + _mx[o]*(2*i + _off), _y + _my[o]*_rad]
		}
	}
	return _ret
}	