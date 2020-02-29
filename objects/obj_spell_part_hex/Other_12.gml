/// @description get colour swapping
if (type = TYPE.WIRE) {
	if (children_number > 0) {
		name = children[0].name
		colours[0] = children[0].image_blend
		image_blend = colours[0]
	
		for (var i = 1; i < children_number; i++) {
			name += "?+?" + children[i].name
			colours[i] = children[i].image_blend
			colour_cycle = true;
		}
		colours[children_number] = colours[0]
		colour_number = array_length_1d(colours) - 1
	} else {
		name = "?NONE?"
		image_blend = COLOUR.SHELL
	}
}
