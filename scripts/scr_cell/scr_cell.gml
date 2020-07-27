/// A collection of scripts that deal with hex cells

/// Functions:
///		cell_data
///		cell_empty
///		cell_distance

//--------------------------------------------------------------------------------------------------

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
function cell_distance() {


	return	max(ceil(abs(argument[0] - argument[2])/2), abs(argument[1] - argument[3]),
				ceil(-abs(argument[0] - argument[2])/2 + abs(argument[1] - argument[3]))
			)


}
