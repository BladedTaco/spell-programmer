/// @description develop the spell

children = []; //init child array
age = 0; //how long the circle has been visible
name = "?JUMP?BOOST?" //spell name
//vertically is each tile/circle
//each circle is [TILE, NAME, VALUE, CHILDREN, TYPE]
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

