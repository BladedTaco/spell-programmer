// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function tile_data(){
	//create spells
	//structure is [TYPE, SPRITE, COLOUR, DEFAULT NAME, INPUTS*, INPUT_COLOURS*]
	//global.spell_data = 
	//[
	//	[TYPE.TRICK, spr_add_motion, COLOUR.TRICK, " ADD MOTION ", ["DIRECTION", "TARGET", "MANA"], [COLOUR.VECTOR, COLOUR.ENTITY, COLOUR.MANA]],
	//	[TYPE.BASIC, spr_entity_caster, COLOUR.ENTITY, " CASTER "],
	//	[TYPE.CONVERTER, spr_construct_vector, COLOUR.VECTOR, " CONSTRUCT VECTOR ", ["X", "Y", "Z"], [COLOUR.CONSTANT, COLOUR.CONSTANT, COLOUR.CONSTANT]],
	//	[TYPE.COUNTER, spr_constant, COLOUR.CONSTANT, " CONSTANT "],
	//	[TYPE.COUNTER, spr_mana, COLOUR.MANA, " MANA SOURCE "],
	//	[TYPE.CONVERTER, spr_mana, COLOUR.VECTOR, "TEST 5 SLOT", ["1", "2", "3", "4", "5"], [COLOUR.TRICK, COLOUR.ENTITY, COLOUR.VECTOR, COLOUR.CONSTANT, COLOUR.MANA]],
	//	[TYPE.CONVERTER, spr_constant, COLOUR.VECTOR, "TEST 4 SLOT", ["1", "2", "3", "4"], [COLOUR.TRICK, COLOUR.ENTITY, COLOUR.VECTOR, COLOUR.CONSTANT]],
	//	[TYPE.WIRE, spr_shell, COLOUR.WIRE, " CONNECTOR "]
	//]
	
	enum SPELL_CONSTRUCTORS {
		ADD_MOTION = __spell_add_motion,
		CASTER,
		CONSTRUCT_VECTOR,
		CONSTANT,
		MANA,
		TEST,
		TEST2,
		CONNECTOR,
		EMPTY
	}
	//type = TYPE.TRICK
	//sprite_index = spr_add_motion
	//image_blend = COLOUR.TRICK
	//name = " ADD MOTION "
	//inputs = ["DIRECTION", "TARGET", "MANA"]
	//input_colour = [COLOUR.VECTOR, COLOUR.ENTITY, COLOUR.MANA]
	function __spell_data(_constr, _sprite, _colour, _name, _inputs, _input_colours) constructor {
		type = _constr
		sprite_index = _sprite
		image_blend = _colour
		name = _name
		inputs = is_undefined(_inputs) ? [] : _inputs
		input_colour = is_undefined(_input_colours) ? [] : _input_colours
	}
	
	
	spells = {
		add_motion :		new __spell_data(trick_spell_tile,		/*  TYPE.TRICK,		*/spr_add_motion, COLOUR.TRICK, " ADD MOTION ", ["DIRECTION", "TARGET", "MANA"], [COLOUR.VECTOR, COLOUR.ENTITY, COLOUR.MANA])
		caster :			new __spell_data(basic_spell_tile,		/*  TYPE.BASIC,		*/spr_entity_caster, COLOUR.ENTITY, " CASTER ")
		construct_vector : 	new __spell_data(converter_spell_tile,	/*  TYPE.CONVERTER,	*/spr_construct_vector, COLOUR.VECTOR, " CONSTRUCT VECTOR ", ["X", "Y", "Z"], [COLOUR.CONSTANT, COLOUR.CONSTANT, COLOUR.CONSTANT])
		constant : 			new __spell_data(counter_spell_tile,	/*  TYPE.COUNTER,	*/spr_constant, COLOUR.CONSTANT, " CONSTANT ")
		mana_source : 		new __spell_data(counter_spell_tile,	/*  TYPE.COUNTER,	*/spr_mana, COLOUR.MANA, " MANA SOURCE ")
		test1 : 			new __spell_data(converter_spell_tile,	/*  TYPE.CONVERTER,	*/spr_mana, COLOUR.VECTOR, "TEST 5 SLOT", ["1", "2", "3", "4", "5"], [COLOUR.TRICK, COLOUR.ENTITY, COLOUR.VECTOR, COLOUR.CONSTANT, COLOUR.MANA])
		test2 : 			new __spell_data(converter_spell_tile,	/*  TYPE.CONVERTER,	*/spr_constant, COLOUR.VECTOR, "TEST 4 SLOT", ["1", "2", "3", "4"], [COLOUR.TRICK, COLOUR.ENTITY, COLOUR.VECTOR, COLOUR.CONSTANT])
		wire : 				new __spell_data(wire_spell_tile,		/*  TYPE.WIRE,		*/spr_shell, COLOUR.WIRE, " CONNECTOR ")
	}	
	
	global.spell_data = [
		  new __spell_data_input(TYPE.TRICK, spr_add_motion, COLOUR.TRICK, " ADD MOTION ", ["DIRECTION", "TARGET", "MANA"], [COLOUR.VECTOR, COLOUR.ENTITY, COLOUR.MANA])
		, new __spell_data(TYPE.BASIC, spr_entity_caster, COLOUR.ENTITY, " CASTER ")
		, new __spell_data_input(TYPE.CONVERTER, spr_construct_vector, COLOUR.VECTOR, " CONSTRUCT VECTOR ", ["X", "Y", "Z"], [COLOUR.CONSTANT, COLOUR.CONSTANT, COLOUR.CONSTANT])
		, new __spell_data(TYPE.COUNTER, spr_constant, COLOUR.CONSTANT, " CONSTANT ")
		, new __spell_data(TYPE.COUNTER, spr_mana, COLOUR.MANA, " MANA SOURCE ")
		, new __spell_data_input(TYPE.CONVERTER, spr_mana, COLOUR.VECTOR, "TEST 5 SLOT", ["1", "2", "3", "4", "5"], [COLOUR.TRICK, COLOUR.ENTITY, COLOUR.VECTOR, COLOUR.CONSTANT, COLOUR.MANA])
		, new __spell_data_input(TYPE.CONVERTER, spr_constant, COLOUR.VECTOR, "TEST 4 SLOT", ["1", "2", "3", "4"], [COLOUR.TRICK, COLOUR.ENTITY, COLOUR.VECTOR, COLOUR.CONSTANT])
		, new __spell_data(TYPE.WIRE, spr_shell, COLOUR.WIRE, " CONNECTOR ")
	]
}