/// @description 
macros()

draw_set_circle_precision(64)

show_debug_overlay(true)

instance_create_depth(room_width/2, room_height/2, 0, obj_spell)

/*

function basic_spell_tile(_px, _py, _index, _data) : spell_tile(_px, _py, _index, _data) constructor {
	type = TYPE.BASIC
}

	BASIC,
		TRICK,
		CONVERTER,
		COUNTER,
		BIN_COUNTER,
		SHELL,
		WIRE