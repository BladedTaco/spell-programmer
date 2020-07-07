///@func scr_reposition_tile(tile, new_cell_x, new_cell_y)
///@param tile - the tile object to move
///@param new_cell_x - the x position of the cell to move the tile to
///@param new_cell_y - the y position of the cell to move the tile to
///@desc Moves the tile to the given position, trimming outputs as needed
function scr_reposition_tile() {
	var i, o, _s, _tiles;

	with (argument[0]) {
		//get surrounding tiles
		_tiles = [
					cell_data(spell, pos_x - 2, pos_y),
					cell_data(spell, pos_x + 2, pos_y),
					cell_data(spell, pos_x - 1, pos_y + 1),
					cell_data(spell, pos_x - 1, pos_y - 1),
					cell_data(spell, pos_x + 1, pos_y + 1),
					cell_data(spell, pos_x + 1, pos_y - 1)
				]
			
		//move
		pos_x = argument[1]
		pos_y = argument[2]
		_s = spell.spell[| index]
		_s = _s[@ 4]
		_s[@ 0] = pos_x
		_s[@ 1] = pos_y
	
		//trim outputs
		for (i = 0; i < 6; i++) {
			if (instance_exists(_tiles[i])) {
				with (_tiles[i]) {
					if (cell_distance(pos_x, pos_y, argument[1], argument[2]) > 1) {
						//check for inputs to argument tile
						for (o = 0; o < children_number; o++) {
							if (children[| o] == other.id) {
								set_tile_output(spell, other.id, id)
								break;
							}
						}
						if (o < children_number) continue; //skip rest if above loop broke
						//check for outputs to argument tile
						for (o = 0; o < other.children_number; o++) {
							if (other.children[| o] == id) {
								set_tile_output(spell, id, other.id)
								break;
							}
						}
					}
				}
			}
		}
		//remove port connections that can no longer be made
		check_ports(spell)
	}
			//ds_list_add(spell, [argument[3], "", 0, -1, [_mx, _my], -1])


}
