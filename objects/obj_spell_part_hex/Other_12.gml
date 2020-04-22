/// @description get colour swapping
if (type = TYPE.WIRE) {
	//reset variables
	colours = [];
	colour_number = 0;
	colour_cycle = false;
	
	if (children_number > 0) {
		//get wire inheritance
		if (children[| 0].type = TYPE.WIRE) {
			with (children[| 0]) {
				event_user(2)	
				//get colours
				for (var o = 0; o < colour_number; o++) {
					other.colours[array_length_1d(other.colours)] = colours[o]
				}
				other.colour_cycle = colour_cycle;
			}
		} else {
			colours[0] = children[| 0].image_blend
		}
			
		if (array_length_1d(colours) = 0) {
			colours[0] = COLOUR.WIRE
		}
			
		//get base values
		name = children[| 0].name
		image_blend = colours[0]
	
			
		// add in +'s when needed
		if (children_number > 1) {
			// remove +'s when unneeded
			if (children[| 0].children_number > 1) {
				name = string_delete(name, 1, 3)	
			}
			name = " + " + name
		}
		//get further values
		for (var i = 1; i < children_number; i++) {
			colour_cycle = true;
			//get wire inheritance
			if (children[| i].type = TYPE.WIRE) {
				with (children[| i]) {
					//update colours and name
					event_user(2)	
					//get colours
					for (var o = 0; o < colour_number; o++) {
						other.colours[array_length_1d(other.colours)] = colours[o]
					}
				}
			} else {
				colours[array_length_1d(colours)] = children[| i].image_blend
			}
			//get iterative values
			name += " + " + children[| i].name
		}
		//handle colour cycling variables
		colours[array_length_1d(colours)] = colours[0]
		colour_number = array_length_1d(colours) - 1
	} else { //empty connector
		//no name, no colour
		name = " NONE "
		image_blend = COLOUR.WIRE
	}
}
