/// @description 
macros()

draw_set_circle_precision(64)

//create spells
//structure is [TYPE, SPRITE, COLOUR, DEFAULT NAME, INPUTS*, INPUT_COLOURS*]
spell_data = 
[
	[TYPE.TRICK, spr_add_motion, COLOUR.TRICK, " ADD MOTION ", ["DIRECTION", "TARGET", "MANA"], [COLOUR.VECTOR, COLOUR.ENTITY, COLOUR.MANA]],
	[TYPE.BASIC, spr_entity_caster, COLOUR.ENTITY, " CASTER "],
	[TYPE.CONVERTER, spr_construct_vector, COLOUR.VECTOR, " CONSTRUCT VECTOR ", ["X", "Y", "Z"], [COLOUR.CONSTANT, COLOUR.CONSTANT, COLOUR.CONSTANT]],
	[TYPE.COUNTER, spr_constant, COLOUR.CONSTANT, " CONSTANT "],
	[TYPE.COUNTER, spr_mana, COLOUR.MANA, " MANA SOURCE "],
	[TYPE.CONVERTER, spr_mana, COLOUR.VECTOR, "TEST 5 SLOT", ["1", "2", "3", "4", "5"], [COLOUR.TRICK, COLOUR.ENTITY, COLOUR.VECTOR, COLOUR.CONSTANT, COLOUR.MANA]],
	[TYPE.CONVERTER, spr_constant, COLOUR.VECTOR, "TEST 4 SLOT", ["1", "2", "3", "4"], [COLOUR.TRICK, COLOUR.ENTITY, COLOUR.VECTOR, COLOUR.CONSTANT]],
	[TYPE.WIRE, spr_shell, COLOUR.WIRE, " CONNECTOR "]
]


show_debug_overlay(true)


instance_create_depth(room_width/2, room_height/2, 0, obj_spell)
