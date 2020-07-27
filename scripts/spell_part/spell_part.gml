
//each circle is [TILE, NAME, VALUE, CONNECTIONS, TILE_POS, INPUTS]
function spell_part (_tile, _name, _value, _children, _pos, _inputs) constructor {
	tile = _tile
	name = _name
	value = _value
	children = array_to_list(_children)
	pos = _pos
	pos_x = _pos[0]
	pos_y = _pos[1]
	//mismatched size clears inputs
	if (array_length(_inputs) != _tile.input_number) {
		inputs = new_ds_list_size(-1, _tile.input_number)
	} else {
		inputs = array_to_list(_inputs)
	}
	
	static move = function(_x, _y) {
		pos = [_x, _y]
		pos_x = _x
		pos_y = _y
	}
}