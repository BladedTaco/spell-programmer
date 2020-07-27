/// @description develop the spell

children = ds_list_create(); //init child array
children_number = 0;
age = 0; //how long the circle has been visible
sub_age = [0, 0, 0]; //half the age for slower moving things
name = " JUMP BOOST " //spell name
bubble_size = 0;
hex_size = 0;
true_age = 0;
x_diff = 0;
y_diff = 0;
movable = true;

//drag variables
drag_action = DRAG.NONE
draw_queue = []
draw_queue_size = 0
drag_start_x = 0
drag_start_y = 0
drag_last_x = 0
drag_last_y = 0
drag_diff_x = 0
drag_diff_y = 0
drag_tile = noone
drag_path = []
drag_path_length = 0
drag_path_length_max = 0
drag_empty = false
hover_time = 0
hover_max = 30

particle_surface = -1;
alt_particle_surface = -1;
noise_surface = -1;
spell_surface = -1;
size = 0;
surface_size = 4096//2048;
half_surface_size = surface_size/2;
update_wires = 0
wire_heads = []; //the heads of the different wire connectors

//vertically is each tile/circle

spell = new_ds_list(
	new spell_part(SPELLS.add_motion,		" ADD MOTION ",			-1,			[1, 9, 11],	[0,0],		[9, -1, 2]		),
	new spell_part(SPELLS.construct_vector,	" CONSTRUCT VECTOR ",	0,			[3, 4, 5],	[1,1],		[-1, -1, -1]	),
	new spell_part(SPELLS.mana_source,		" MANA SOURCE ",		12345678,	[],			[3,-1],		[]				),
	new spell_part(SPELLS.constant,			" CONSTANT ",			0,			[],			[0,2],		[]				),
	new spell_part(SPELLS.constant,			" CONSTANT ",			0,			[],			[2,2],		[]				),
	new spell_part(SPELLS.constant,			" CONSTANT ",			1,			[],			[3,1],		[]				),
	new spell_part(SPELLS.constant,			" CONSTANT ",			0,			[],			[-1,1],		[]				),
	new spell_part(SPELLS.constant,			" CONSTANT ",			0,			[],			[-4,0],		[]				),
	new spell_part(SPELLS.caster,			" CASTER ",				0,			[],			[-4,2],		[]				),
	new spell_part(SPELLS.construct_vector,	" CONSTRUCT VECTOR ",	0,			[6, 10, 7],	[-2,0],		[7, 6, 7]		),
	new spell_part(SPELLS.construct_vector,	" CONSTRUCT VECTOR ",	0,			[6, 7, 8],	[-3, 1],	[-1, -1, -1]	),
	new spell_part(SPELLS.wire,				" CONNECTOR ",			0,			[2],		[1,-1],		[]				),
	new spell_part(SPELLS.wire,				" CONNECTOR ",			0,			[2],		[2,0],		[]				),
	new spell_part(SPELLS.wire,				" CONNECTOR ",			0,			[2],		[4,0],		[]				),
	new spell_part(SPELLS.wire,				" CONNECTOR ",			0,			[2],		[5,-1],		[]				),
	new spell_part(SPELLS.wire,				" CONNECTOR ",			0,			[2],		[4,-2],		[]				),
	new spell_part(SPELLS.wire,				" CONNECTOR ",			0,			[2],		[2,-2],		[]				),
	new spell_part(SPELLS.wire,				" CONNECTOR ",			0,			[13],		[6,0],		[]				),
	new spell_part(SPELLS.wire,				" CONNECTOR ",			0,			[17],		[8,0],		[]				),
	new spell_part(SPELLS.wire,				" CONNECTOR ",			0,			[18],		[10,0],		[]				)
)

set_bubble = function (_bubble) {
	bubble_size = _bubble
	hex_size = _bubble*2/sqrt(3)
	for (var i = 0; i < children_number; i++) {
		if is_struct(children[| i]) {
			children[| i].set_size(_bubble)
		}
	}
}
	
children_number = ds_list_size(spell)

for (var i = 0; i < children_number; i++) {
	children[| i] = new_spell_tile(spell[| i].pos_x, spell[| i].pos_y, spell[| i].tile, i)
}

for (i = 0; i < children_number; i++) {
	with (children[| i]) {
		get_children()	
	}
}

//get wire heads
event_user(0)

//get connector names
event_user(1)

//create tools menu
with (instance_create(room_width + 360, 110, obj_tools)) {
	spell = other.id
	active = true
	event_user(0)
}