///@func cell_empty(spell, cell_x, cell_y, wire)
///@param spell - the spell object
///@param cell_x - the x position of the cell (neighbours are two apart)
///@param cell_y - the y position of the cell
///@param wire - what wires should return
///@desc returns whether there is a tile in the cell, use with spell object
<<<<<<< HEAD
function cell_empty() {

	var _id = cell_data(argument[0], argument[1], argument[2])
	if (instance_exists(_id)) {
		if (_id.type = TYPE.WIRE) {
			return argument[3] //return the given
		}
	}
	return instance_exists(_id)


}
=======

var _id = cell_data(argument[0], argument[1], argument[2])
if (instance_exists(_id)) {
	if (_id.type = TYPE.WIRE) {
		return argument[3] //return the given
	}
}
return instance_exists(_id)
>>>>>>> master
