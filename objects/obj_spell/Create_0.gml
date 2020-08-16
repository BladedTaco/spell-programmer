/// @description develop the spell
#region variable declaration
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
	
	mouse_off = 0

	//vertically is each tile/circle

	if (instance_number(obj_spell) == 1) { //first spell object TOOD FIX
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
		new spell_part(SPELLS.wire,				"",						0,			[2],		[1,-1],		[]				),
		new spell_part(SPELLS.wire,				"",						0,			[2],		[2,0],		[]				),
		new spell_part(SPELLS.wire,				"",						0,			[2],		[4,0],		[]				),
		new spell_part(SPELLS.wire,				"",						0,			[2],		[5,-1],		[]				),
		new spell_part(SPELLS.wire,				"",						0,			[2],		[4,-2],		[]				),
		new spell_part(SPELLS.wire,				"",						0,			[2],		[2,-2],		[]				),
		new spell_part(SPELLS.wire,				"",						0,			[13],		[6,0],		[]				),
		new spell_part(SPELLS.wire,				"",						0,			[17],		[8,0],		[]				),
		new spell_part(SPELLS.wire,				"",						0,			[18],		[10,0],		[]				)
	)
	} else {
		spell = new_ds_list()	
	}
#endregion variable declaration

#region functions
	///@func set_bubble(bubble)
	///@param bubble - the bubble size
	///@desc updates all children to the correct sizes
	set_bubble = function (_bubble) {
		size = 0
		bubble_size = _bubble
		hex_size = _bubble*2/sqrt(3)
		for (var i = 0; i < children_number; i++) {
			if is_struct(children[| i]) {
				children[| i].set_size(_bubble)
			}
		}
	}

	///@func get_bubble()
	///@desc updates all children to the correct sizes after finding that size
	get_bubble = function () {
		size = 0
		for (var i = 0; i < children_number; i++) {
			size = max(size, children[| i].size*!children[| i].variable_size)
		}
		set_bubble(size + BUBBLE)
	}
	
	///@func get_connector(source, dest)
	get_connector = function (_source, _dest) {
		with (_source) {
			for (var i = 0; i < ds_list_size(connectors); i++) {
				if (connectors[| i].dest = _dest) {
					return connectors[| i]	
				}
			}
		}
		return noone
	}

	///@func get_connector_names()
	///@desc call on spell init to get conenctor names
	get_connector_names = function () {
		for (var i = 0; i < children_number; i++) {
			with (children[| i]) { //with each tile
				for (var o = 0; o < input_number; o++) { //for each input
					if (is_struct(input_tile[| o])) {
						input_tile[| o].propogate_name(self, inputs[o], true)
					}
				}
			}
		}
	}
#endregion functions

#region setup	
	children_number = ds_list_size(spell)

	if (children_number > 0) {
		init = true

		for (var i = 0; i < children_number; i++) {
			children[| i] = new_spell_tile(spell[| i].pos_x, spell[| i].pos_y, spell[| i].tile, i)
		}

		init = false


		for (i = 0; i < children_number; i++) {
			with (children[| i]) {
				get_children()	
			}
		}

		//get base data
		get_connector_names()

		//create tools menu
		with (instance_create(room_width + 360, 110, obj_tools)) {
			spell = other.id
			active = true
			event_user(0)
		}
	}
#endregion setup
