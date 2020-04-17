/// @description develop the spell

children = ds_list_create(); //init child array
children_number = 0;
age = 0; //how long the circle has been visible
sub_age = [0, 0, 0]; //half the age for slower moving things
name = "?JUMP?BOOST?" //spell name
bubble_size = 0;
hex_size = 0;
true_age = 0;
x_diff = 0;
y_diff = 0;

particle_surface = -1;
alt_particle_surface = -1;
noise_surface = -1;
spell_surface = -1;
size = 0;
surface_size = 4096//2048;
half_surface_size = surface_size/2;


//vertically is each tile/circle
//each circle is [TILE, NAME, VALUE, INPUTS, TILE_POS]
//spell =
//[
//	[SPELL.ADD_MOTION, "?ADD?MOTION?", -1, [1, 2, 3]],
//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 5, 6]],
//	[SPELL.CASTER, "?CASTER?", 0, -1],
//	[SPELL.TEST2, "?TEST2?", 0, [4, 5, 7, 7, 6, 6]],//[SPELL.MANA, "MANA SOURCE", 77, -1],
//	[SPELL.CONSTANT, "?X?", 0, -1],
//	[SPELL.CONSTANT, "?Y?", 0, -1],
//	[SPELL.CONSTANT, "?Z?", 1, -1],
//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 8, 6]],
//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 5, 6]],
//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [10, 11, 12]],
//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 5, 6]],
//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 5, 6]],
//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 5, 6]]
//	//[SPELL.ADD_MOTION, "ADD MOTION", -1, [1, 2, 3]]
//]

//spell =
//[
//	[SPELL.ADD_MOTION, "?ADD?MOTION?", -1, [1, 10, 3]],
//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 5, 6]],
//	[SPELL.CASTER, "?CASTER?", 0, -1],
//	[SPELL.MANA, "?MANA?SOURCE?", 77, -1],
//	[SPELL.CONSTANT, "?X?", 0, -1],
//	[SPELL.CONSTANT, "?Y?", 0, -1],
//	[SPELL.CONSTANT, "?Z?", 1, -1],
//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 13, 13]],
//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 10, 6]],
//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [10, 11, 12]],
//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [1, 1, 1]],
//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 10, 10]],
//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 11, 11]],
//	[SPELL.CONSTRUCT_VECTOR, "?CONSTRUCT?VECTOR?", 0, [4, 12, 12]]
//	//[SPELL.ADD_MOTION, "ADD MOTION", -1, [1, 2, 3]]
//]


//vertically is each tile/circle
//each circle is [TILE, NAME, VALUE, CONNECTIONS, TILE_POS, INPUTS]
spell = ds_list_create()
ds_list_add(spell, 
	[SPELL.ADD_MOTION,			"?ADD?MOTION?",			-1,			new_ds_list(1, 9, 11),	[0,0],	new_ds_list(9, -1, 2)],
	[SPELL.CONSTRUCT_VECTOR,	"?CONSTRUCT?VECTOR?",	0,			new_ds_list(3, 4, 5),	[1,1],	new_ds_list(-1, -1, -1)],
	[SPELL.MANA,				"?MANA?SOURCE?",		12345678,	ds_list_create(),		[3,-1],	ds_list_create()],
	[SPELL.CONSTANT,			"?X?",					0,			ds_list_create(),		[0,2],	ds_list_create()],
	[SPELL.CONSTANT,			"?Y?",					0,			ds_list_create(),		[2,2],	ds_list_create()],
	[SPELL.CONSTANT,			"?Z?",					1,			ds_list_create(),		[3,1],	ds_list_create()],
	[SPELL.CONSTANT,			"?X?",					0,			ds_list_create(),		[-1,1],	ds_list_create()],
	[SPELL.CONSTANT,			"?Y?",					0,			ds_list_create(),		[-4,0],	ds_list_create()],
	[SPELL.CASTER,				"?CASTER?",				0,			ds_list_create(),		[-4,2],	ds_list_create()],
	[SPELL.CONSTRUCT_VECTOR,	"?CONSTRUCT?VECTOR?",	0,			new_ds_list(6, 10, 7),	[-2,0],	new_ds_list(7, 6, 7)],
	[SPELL.CONSTRUCT_VECTOR,	"?CONSTRUCT?VECTOR?",	0,			new_ds_list(6, 7, 8),	[-3, 1],new_ds_list(-1, -1, -1)],
	[SPELL.CONNECTOR,			"?CONNECTOR?",			0,			new_ds_list(2),			[1,-1],	ds_list_create()],
	[SPELL.CONNECTOR,			"?CONNECTOR?",			0,			new_ds_list(2),			[2,0],	ds_list_create()],
	[SPELL.CONNECTOR,			"?CONNECTOR?",			0,			new_ds_list(2),			[4,0],	ds_list_create()],
	[SPELL.CONNECTOR,			"?CONNECTOR?",			0,			new_ds_list(2),			[5,-1],	ds_list_create()],
	[SPELL.CONNECTOR,			"?CONNECTOR?",			0,			new_ds_list(2),			[4,-2],	ds_list_create()],
	[SPELL.CONNECTOR,			"?CONNECTOR?",			0,			new_ds_list(2),			[2,-2],	ds_list_create()],
	[SPELL.CONNECTOR,			"?CONNECTOR?",			0,			new_ds_list(13),		[6,0],	ds_list_create()],
	[SPELL.CONNECTOR,			"?CONNECTOR?",			0,			new_ds_list(17),		[8,0],	ds_list_create()],
	[SPELL.CONNECTOR,			"?CONNECTOR?",			0,			new_ds_list(18),		[10,0],	ds_list_create()]
)

	


wire_heads = []; //the heads of the different wire connectors

var _bubble = 0, _hex = 0, _s;
children_number = ds_list_size(spell)
//create each trick circle
for (var i = 0; i < children_number; i++) {
	with (instance_create_depth(x, y, 0, obj_spell_part_hex)) { //create it
		x = room_width/2
		y = room_height/2
		index = i; //give index
		spell = other.id
		level = 0;
		other.children[| i] = id; //give id
		event_user(0) //get data
		//get bubble size
		if (size > _bubble) {
			if (type != TYPE.COUNTER) {
				_bubble = size	
			}
		}
		_s = other.spell[| i] //the tile
		if (_s[2] = -1) { //is a trick tile
			other.sprite_index = sprite_index
		}
	}
}
//calculate hex size
_hex = _bubble*2/sqrt(3)
bubble_size = _bubble + 32
hex_size = _hex + 32
//give bubble and hex size
for (i = 0; i < children_number; i++) {
	with (children[| i]) {
		event_user(1) //get children
		bubble_size = _bubble + 32
		hex_size = _hex + 32
		cell_size = size*2/sqrt(3)
		other.size = max(other.size, point_distance(0, 0, bubble_size*pos_x, hex_size*pos_y*1.5) + cell_size + 60)
	}
}

event_user(0)