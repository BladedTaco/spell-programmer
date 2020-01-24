/// @description develop the spell

children = []; //init child array
children_number = 0;
age = 0; //how long the circle has been visible
name = "?JUMP?BOOST?" //spell name
//vertically is each tile/circle
//each circle is [TILE, NAME, VALUE, INPUTS, TILE_POS]
spell =
[
	[SPELL.ADD_MOTION, "?ADD?MOTION?", -1, [1, 2, 3]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 5, 6]],
	[SPELL.CASTER, "?CASTER?", 0, -1],
	[SPELL.TEST2, "?TEST2?", 0, [4, 5, 7, 7, 6, 6]],//[SPELL.MANA, "MANA SOURCE", 77, -1],
	[SPELL.CONSTANT, "?X?", 0, -1],
	[SPELL.CONSTANT, "?Y?", 0, -1],
	[SPELL.CONSTANT, "?Z?", 1, -1],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 8, 6]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 5, 6]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [10, 11, 12]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 5, 6]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 5, 6]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 5, 6]]
	//[SPELL.ADD_MOTION, "ADD MOTION", -1, [1, 2, 3]]
]

spell =
[
	[SPELL.ADD_MOTION, "?ADD?MOTION?", -1, [1, 10, 3]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 5, 6]],
	[SPELL.CASTER, "?CASTER?", 0, -1],
	[SPELL.MANA, "?MANA?SOURCE?", 77, -1],
	[SPELL.CONSTANT, "?X?", 0, -1],
	[SPELL.CONSTANT, "?Y?", 0, -1],
	[SPELL.CONSTANT, "?Z?", 1, -1],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 13, 13]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 10, 6]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [10, 11, 12]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [1, 1, 1]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 10, 10]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 11, 11]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 12, 12]]
	//[SPELL.ADD_MOTION, "ADD MOTION", -1, [1, 2, 3]]
]


spell =
[
	[SPELL.ADD_MOTION, "?ADD?MOTION?", -1, [1, 9, 11], [0,0]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [3, 4, 5], [1,1]],
	[SPELL.MANA, "?MANA?SOURCE?", 77, -1, [3,-1]],
	[SPELL.CONSTANT, "?X?", 0, -1, [0,2]],
	[SPELL.CONSTANT, "?Y?", 0, -1, [2,2]],
	[SPELL.CONSTANT, "?Z?", 1, -1, [3,1]],
	[SPELL.CONSTANT, "?X?", 0, -1, [-1,1]],
	[SPELL.CONSTANT, "?Y?", 0, -1, [-4,0]],
	[SPELL.CASTER, "?CASTER?", 0, -1, [-4,2]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [6, 10, 7], [-2,0]],
	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [6, 7, 8], [-3, 1]],
	[SPELL.CONNECTOR, "?CONNECTOR?", 0, [2], [1,-1]]
	//[SPELL.ADD_MOTION, "ADD MOTION", -1, [1, 2, 3]]
]


if (global.spell_part != obj_spell_part_hex) {
	var _s;

	//create each trick circle
	for (var i = 0; i < array_length_1d(spell); i++) {
		_s = spell[i] //the tile
		if (_s[2] = -1) { //is a trick tile
			with (instance_create_depth(x - (room_width/4)*(i/3.5 - 1), y, 0, global.spell_part)) { //create it
				x = room_width/2
				y = room_height/2
				index = i; //give index
				spell = other.id
				parent = id;
				level = 0;
				event_user(0) //get data
				other.children[i] = id; //give id
				visible = true;
			}
		}
	}
} else {
	var _bubble = 0, _hex = 0;
	children_number = array_length_1d(spell)
	//create each trick circle
	for (var i = 0; i < children_number; i++) {
		with (instance_create_depth(x, y, 0, global.spell_part)) { //create it
			x = room_width/2
			y = room_height/2
			index = i; //give index
			spell = other.id
			level = 0;
			other.children[i] = id; //give id
			event_user(0) //get data
			//get bubble size
			if (size > _bubble) {
				_bubble = size	
			}
		}
	}
	//calculate hex size
	_hex = _bubble*2/sqrt(3)
	//give bubble and hex size
	for (i = 0; i < children_number; i++) {
		with (children[i]) {
			event_user(1) //get children
			bubble_size = _bubble
			hex_size = _hex
			cell_size = size*2/sqrt(3)
		}	
	}
}