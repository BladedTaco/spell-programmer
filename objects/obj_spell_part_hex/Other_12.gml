/// @description get wire data

/*

if (type = TYPE.WIRE) {
	if (ds_exists(input_tile, ds_type_list) and ds_exists(children, ds_type_list)) {
		var _l = ds_list_size(input_tile)
		var _s = [];
	
		//reset colour array
		colours = [COLOUR.WIRE];
	
		//get colours and names
		for (var i = 0; i < _l; i++) {
			colours[i] = input_tile[| i].input_colour[inputs[i]] //colour swapping
			_s[i] = " " + input_tile[| i].inputs[inputs[i]] + " "
		}
	
	
		//redefine variables
		name = array_concat(_s, "+", " ")
		connector_name = [name, name, name, name, name, name]	
		colour_number = _l;
		colour_cycle = (_l > 1)
		if (colour_cycle) { 
			colours[i] = colours[0] //append the first colour to the list
		} else {
			image_blend = colours[0]	
		}
	
		children_number = ds_list_size(children) // TODO workaround
	
		for (i = 0; i < children_number; i++) {
			if instance_exists(children[| i]) { 
				if (children[| i].type == TYPE.WIRE) {
					with (children[| i]) {
						event_user(2)
						other.connector_name[i] = name
					}
				}
			} else {
				show_debug_message("MISSING CHILD")
				
			}
		}
	
		if (ds_list_size(input_tile) == 0) {
			connector_name = ["", "", "", "", "", ""]
		}
	}
}
