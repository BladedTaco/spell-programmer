// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function __spell_data(_constr, _sprite, _colour, _name, _inputs, _input_colours) constructor {
		type = _constr
		sprite_index = _sprite
		image_blend = _colour
		name = _name
		inputs = is_undefined(_inputs) ? [] : _inputs
		input_colour = is_undefined(_input_colours) ? [] : _input_colours
		input_number = array_length(inputs)
	}

function tile_data(){
	//create spells
	global.spells = {
		add_motion :		new __spell_data(trick_spell_tile,		spr_add_motion,			COLOUR.TRICK,		" ADD MOTION ",			["DIRECTION", "TARGET", "MANA"],	[COLOUR.VECTOR, COLOUR.ENTITY, COLOUR.MANA])
		,caster :			new __spell_data(basic_spell_tile,		spr_entity_caster,		COLOUR.ENTITY,		" CASTER ")
		,construct_vector : new __spell_data(converter_spell_tile,	spr_construct_vector,	COLOUR.VECTOR,		" CONSTRUCT VECTOR ",	["X", "Y", "Z"],					[COLOUR.CONSTANT, COLOUR.CONSTANT, COLOUR.CONSTANT])
		,constant : 		new __spell_data(bin_counter_spell_tile,spr_constant,			COLOUR.CONSTANT,	" CONSTANT ")
		,mana_source : 		new __spell_data(bin_counter_spell_tile,spr_mana,				COLOUR.MANA,		" MANA SOURCE ")
		,test1 : 			new __spell_data(converter_spell_tile,	spr_mana,				COLOUR.VECTOR,		"TEST 5 SLOT",			["1", "2", "3", "4", "5"],			[COLOUR.TRICK, COLOUR.ENTITY, COLOUR.VECTOR, COLOUR.CONSTANT, COLOUR.MANA])
		,test2 : 			new __spell_data(converter_spell_tile,	spr_constant,			COLOUR.VECTOR,		"TEST 4 SLOT",			["1", "2", "3", "4"],				[COLOUR.TRICK, COLOUR.ENTITY, COLOUR.VECTOR, COLOUR.CONSTANT])
		,wire : 			new __spell_data(wire_spell_tile,		spr_shell,				COLOUR.WIRE,		" CONNECTOR ")
		,empty : -1
	}
}