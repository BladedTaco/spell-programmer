
//spell circle types
enum TYPE {
	BASIC,
	TRICK,
	CONVERTER,
	COUNTER,
	SHELL,
	WIRE
}

enum SPELL {
	ADD_MOTION,
	CASTER,
	CONSTRUCT_VECTOR,
	CONSTANT,
	MANA,
	TEST,
	TEST2,
	CONNECTOR
}

enum COLOUR {
	CONSTANT = c_red,
	VECTOR = c_aqua,
	TRICK = c_white,
	MANA = c_fuchsia,
	ENTITY = c_green,
	SPELL = c_ltgray,
	SHELL = c_gray,
	CONNECTOR = c_black,
	EMPTY = $020202,	
	SURFACE_EMPTY = $010101
}