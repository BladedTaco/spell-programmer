/// @description get wire heads
var i, o, j, _wire, _wire_head;
_wire = [];
_wire_head = [];
wire_heads = [];

//wire heads dont have any wires which have them as children

//get wires
for (i = 0; i < children_number; i++) {
	if (children[i].type == TYPE.WIRE) {
		_wire[array_length_1d(_wire)] = children[i];
		_wire_head[array_length_1d(_wire)-1] = true;
	}
}

//get wire heads
for (i = array_length_1d(_wire) - 1; i >= 0; i--) { //for each wire
	if (instance_exists(_wire[i])) { //if it exists
		//remove all its children from the temp array
		with (_wire[i]) {
			for (o = array_length_1d(_wire) - 1; o >= 0; o--) { //for each wire
				for (j = 0; j < children_number; j++) { //for each child
					if (_wire[o] = children[j]) { //child to be removed
						_wire_head[o] = false; //remove from head list
					}
				}
			}
		}
	}
}

//transfer to real array
for (i = array_length_1d(_wire) - 1; i >= 0; i--) { //for each wire
	if (_wire_head[i] = true) { //if wire head
		//transfer to array
		wire_heads[array_length_1d(wire_heads)] = _wire[i]
	}
}