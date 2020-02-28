/// @description handle menu option selection


//create a child menu and set parent and child

//based on menu option
switch (menu_data[selected]) {
	case MENU.TIL: //set tile
		//create child menu
		active = false;
		with (instance_create_depth(x, y, depth - 1, obj_menu)) {
			pos_x = other.pos_x
			pos_y = other.pos_y
			spell = other.spell
			child = other.child
			parent = other.id		
			menu_data = [MENU.TILE_EMPTY, MENU.TILE_TRICK, MENU.TILE_BASIC, MENU.TILE_CONSTANT, MENU.TILE_CONVERTER, MENU.TILE_MANA]
			menu_options = ["EMPTY", "TRICK", "BASIC", "CONSTANT", "CONVERTER", "MANA"]
			menu_sprite = [spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null]
			menu_active = [instance_exists(child), true, true, true, true, true];
			menu_length = 6;
		}
	break;
	
	case MENU.OUT: //set output
	//create a connector if necessary (no tile to output to)
	break;
	
	case MENU.VAL: //set value
	
	break;
	
	case MENU.NAM: //set name
		child.name = choose("name 1", "1337 5347", "waga na wa san")
	break;
	
	case MENU.MOV: //move tile
	
	break;
	
	case MENU.SEL: //select group
	
	break;
	
	case MENU.TILE_EMPTY: //remove tile
		set_tile(spell, pos_x, pos_y, SPELL.EMPTY)
		instance_destroy(parent)
		instance_destroy();
	break;
	
	case MENU.TILE_TRICK: //connetor tile
		parent.child = set_tile(spell, pos_x, pos_y, SPELL.ADD_MOTION)
		with (parent) { event_user(2) };
		instance_destroy();
	break;
	
	case MENU.TILE_BASIC: //basic tile
		parent.child = set_tile(spell, pos_x, pos_y, SPELL.CASTER)
		with (parent) { event_user(2) };
		instance_destroy();
	break;
	
	case MENU.TILE_CONSTANT: //constant tile
		parent.child = set_tile(spell, pos_x, pos_y, SPELL.CONSTANT)
		with (parent) { event_user(2) };
		instance_destroy();
	break;
	
	case MENU.TILE_CONVERTER: //converter tile
		parent.child = set_tile(spell, pos_x, pos_y, SPELL.CONSTRUCT_VECTOR)
		with (parent) { event_user(2) };
		instance_destroy();
	break;
	
	case MENU.TILE_MANA: //mana tile
		parent.child = set_tile(spell, pos_x, pos_y, SPELL.MANA)
		with (parent) { event_user(2) };
		instance_destroy();
	break;
	
	
	default: //not handled, show srror
		show_debug_message("Unexpected Menu Option Type - obj_menu: " + string(menu_data[selected]))
	break;
}
