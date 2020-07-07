///@func cell_data(spell, cell_x, cell_y)
///@param spell - the spell object
///@param cell_x - the x position of the cell (neighbours are two apart)
///@param cell_y - the y position of the cell
///@desc returns the id of the tile in the cell, use with spell object
function cell_data() {

	//with (argument[0]) {
	//	var _id = instance_nearest(
	//		x + argument[1]*bubble_size,
	//		y + argument[2]*hex_size*HEX_MUL,
	//		obj_spell_part_hex
	//	)
	//	if (instance_exists(_id)) {
	//		if (point_distance(x, y, _id.x, _id.y) > 20) {
	//			_id = noone;
	//		}
	//		//if ((_id.pos_x != argument[1]) or (_id.pos_y != argument[2])) {
	//		//	_id = noone;
	//		//}
	//	}
	//}

	//return _id

	with (argument[0]) {
		var _spell = [];
		var _pos = [];
		var _child = noone;
	
		for (var i = 0; i < children_number; i++) {
			_spell = spell[| i]
			_pos = _spell[4]
			if ((_pos[0] = argument[1]) and (_pos[1] = argument[2])) {
				_child = children[| i]
				break;
			}
		}
	}

	return _child;


}
