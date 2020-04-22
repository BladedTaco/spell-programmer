/// @description get children indices

//get the id of each child
for (var i = 0; i < children_number; i++) {
	with (spell.children[| children[| i]]) {
		other.children[| i] = id; //give id
	}
}

//get the id of each input
for (i = 0; i < ds_list_size(input_tile); i++) {
	if (input_tile[| i] > 0) {
		with (spell.children[| input_tile[| i]]) {
			other.input_tile[| i] = id; //give id
			if (connector_name = " ") {
				connector_name = " " + other.inputs[i] + "  + "
			} else {
				connector_name += other.inputs[i] + "  + "
			}
		}
	}
}


event_user(2)