function macros() {

	#region macros
#macro HEX_MUL 1.5
#macro DEBUG_MODE false
#macro debug:DEBUG_MODE true
#macro SHADERS true
#macro no_shaders:SHADERS false
#macro COUNTER_SIZE (base_size + 20 + max(0, (string_length(string(scr_int_to_bin(value))) - 8)*10))
#endregion macros

	#region globals
	global.debug = DEBUG_MODE
	global.shaders = SHADERS
	#endregion globals

	#region enums
	//spell circle types
	enum TYPE {
		BASIC,
		TRICK,
		CONVERTER,
		COUNTER,
		BIN_COUNTER,
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
		CONNECTOR,
		EMPTY
	}

	enum COLOUR {
		CONSTANT = c_red,
		VECTOR = c_aqua,
		TRICK = c_white,
		MANA = c_fuchsia,
		ENTITY = c_lime,
		SPELL = c_ltgray,
		SHELL = c_gray,
		WIRE = $cfcfcf,
		MARKER = $ffffff,
		BLACK = $030303,
		CONNECTOR = $020202,
		EMPTY = $020202,	
		SURFACE_EMPTY = $010101
	}


	enum MENU {
		TIL,
		OUT,
		VAL,
		NAM,
		MOV,
		SEL,
		TILE_TRICK,
		TILE_EMPTY,
		TILE_META,
		TILE_BASIC,
		TILE_CONSTANT,
		TILE_CONVERTER,
		TILE_MANA,
		OUTPUT,
		VAL_LEFT,
		VAL_UP,
		VAL_RIGHT,
		VAL_DOWN,
		VAL_BIG_UP,
		VAL_BIG_DOWN,
		INPUT,
		MOVE_TILE,
		GROUP,
		MOVE_GROUP,
		VAL_GROUP,
		TILE_GROUP,
		PACKAGE_GROUP,
		LEVEL_GROUP
	}
	#endregion enums
}
