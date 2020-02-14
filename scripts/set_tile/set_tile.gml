///@func set_tile(spell, cell_x, cell_y, tile)
///@param spell - the spell object
///@param cell_x - the x position of the cell
///@param cell_y - the y position of the cell
///@param tile - the type of tile to set to the cell
///@desc handles changing or removing tiles from a given cell

var _mx = argument[1]
var _my = argument[2]

with (argument[0]) { //with the spell object
	var _spell = [];
	var _pos = [];
	var _child = noone;
	
	for (var i = 0; i < children_number; i++) {
		_spell = spell[i]
		_pos = _spell[4]
		if ((_pos[0] = _mx) and (_pos[1] = _my)) {
			_child = children[i]
			break;
		}
	}
	
	if (instance_exists(_child)) {
		//change the entry
		spell[i] = [argument[3], "NAME", 0, [], [_mx, _my]]
		
		instance_destroy(_child) //destroy the old tile
	}
}


//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [6, 7, 8], [-3, 1]],