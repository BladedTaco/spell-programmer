/// @description get connector names
var i, o, j;
//clear all names
//for (i = 0; i < children_number; i++) {
//	connector_name = [" ", " ", " ", " ", " ", " "]	
//}


//TODO: REWORK this so it actually works properly

//get new ones
for (i = 0; i < children_number; i++) {
	with (children[| i]) { //with each tile
		for (o = 0; o < children_number; o++) {
			with (children[| o]) { //with its children
				if (ds_list_find_index(other.input_tile, id) > -1) { //in list
					connector_name[o] = " " //add initial one
					//check for all values
					for (j = 0; j < other.input_number; j++) {
						if (other.input_tile[| j] = id) {
							connector_name[o] += other.inputs[j] + " + "
						}
					}
					connector_name[o] = string_delete(connector_name[o], string_length(connector_name[o])-2, 3) + " "
				} else {
					connector_name[o] = " "	
				}
			}
		}	
	}
}