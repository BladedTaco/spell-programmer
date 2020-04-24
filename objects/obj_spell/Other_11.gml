/// @description get connector names
var i, o, j, k, _lst, _str;

// remove all wire inputs
for (i = 0; i < children_number; i++) {
	with (children[| i]) { //with each tile
		if (type = TYPE.WIRE) {
			inputs = []	
			ds_list_clear(input_tile)
		}
	}
}
//TODO optimize this into a scipt that only changes affected tiles
//for every tile, give its children the correct connector names
for (i = 0; i < children_number; i++) {
	with (children[| i]) { //with each tile
		for (o = 0; o < children_number; o++) {
			with (children[| o]) { //with its children
				if (type = TYPE.WIRE) { ///wire
					//set name for each run of wires
					_str = []
					for (j = 0; j < other.input_number; j++) {
						_str[j] = ""
						_lst = scr_get_wire_path(id, other.input_tile[| j])
						for (k = 0; k < ds_list_size(_lst); k++) {
							ds_list_add(_lst[| k].input_tile, other.id)
							_lst[| k].inputs[array_length_1d(_lst[| k].inputs)] = j
						}
						ds_list_destroy(_lst)
						//add input name if input found
						if (k > 0) {
							_str[j] = other.inputs[j]
						}
					}
					other.connector_name[o] = "  " + array_concat(_str, " + ", "")
				} else {
					if (ds_list_find_index(other.input_tile, id) > -1) { //in list
						other.connector_name[o] = " " //add initial one
						//check for all values
						for (j = 0; j < other.input_number; j++) {
							if (other.input_tile[| j] == id) {
								other.connector_name[o] += other.inputs[j] + " + "
								//show_debug_message(other.connector_name[o])
							}
						}
						other.connector_name[o] = string_delete(other.connector_name[o], string_length(other.connector_name[o])-2, 3) + " "
					} else {
						other.connector_name[o] = " "	
					}
				}
			}
		}	
	}
}

// update wires
for (i = 0; i < array_length_1d(wire_heads); i++) {
	with (wire_heads[i]) { //with each tile
		event_user(2)
	}
}

//give wires their final outputs in the inputs array as inputs = outputs
//get the connector names from that