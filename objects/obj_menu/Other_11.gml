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
			name = "TILE"
		}
	break;
	
	case MENU.OUT: //set output
		//create child menu
		active = false;
		with (instance_create_depth(x, y, depth - 1, obj_menu)) {
			pos_x = other.pos_x
			pos_y = other.pos_y
			spell = other.spell
			child = other.child
			parent = other.id		
			menu_data = [MENU.OUTPUT, MENU.OUTPUT, MENU.OUTPUT, MENU.OUTPUT, MENU.OUTPUT, MENU.OUTPUT]
			menu_options = ["[+1, -1]", "[+2, +0]", "[+1, +1]", "[-1, +1]", "[-2, +0]", "[-1, -1]"]
			menu_sprite = [spr_menu_arrow, spr_menu_arrow, spr_menu_arrow, spr_menu_arrow, spr_menu_arrow, spr_menu_arrow]
			menu_active = [true, true, true, true, true, true];
			menu_angle = [330, 270, 210, 150, 90, 30];
			menu_length = 6;
			name = "OUTPUT"
			image_angle = -30;
		}
	break;
	
	case MENU.VAL: //set value
		//create child menu
		active = false;
		with (instance_create_depth(x, y, depth - 1, obj_menu)) {
			pos_x = other.pos_x
			pos_y = other.pos_y
			spell = other.spell
			child = other.child
			parent = other.id		
			menu_data = [MENU.VAL_BIG_UP, MENU.VAL_RIGHT, MENU.VAL_BIG_DOWN, MENU.VAL_DOWN, MENU.VAL_LEFT, MENU.VAL_UP]
			menu_options = ["+5", "Shift Right", "-5", "-1", "Shift Left", "+1"]
			menu_sprite = [spr_menu_arrow, spr_menu_arrow, spr_menu_arrow, spr_menu_arrow, spr_menu_arrow, spr_menu_arrow]
			menu_active = [true, true, true, true, true, true];
			menu_angle = [0, 270, 180, 180, 90, 0];
			menu_length = 6;
			name = string(child.value)
			image_angle = -30;
			value = 0
		}
	break;
	
	case MENU.NAM: //set name
		child.name = choose("name 1", "1337 5347", "waga na wa san")
	break;
	
	case MENU.MOV: //move tile
	
	break;
	
	case MENU.SEL: //select group
	
	break;
	
	case MENU.VAL_UP:
		child.value += power(10, value)
		name = string(child.value)
	break;
	case MENU.VAL_BIG_UP:
		child.value += 5*power(10, value)
		name = string(child.value)
	break;
	case MENU.VAL_DOWN:
		child.value -= power(10, value)
		name = string(child.value)
	break;
	case MENU.VAL_BIG_DOWN:
		child.value -= 5*power(10, value)
		name = string(child.value)
	break;
	case MENU.VAL_LEFT:
		value += 1
	break;
	case MENU.VAL_RIGHT:
		value -= 1
		value = max(value, 0)
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
	
	case MENU.OUTPUT:
		//create a connector if necessary (no tile to output to)
		//selected //from 0 - 5
		//["[+1, -1]", "[+2, +0]", "[+1, +1]", "[-1, +1]", "[-2, +0]", "[-1, -1]"]
		//get the offset
		var _mx, _my, _id;
		switch (other.selected) {
			case 0: _mx = 1; _my = -1; break;
			case 1: _mx = 2; _my = 0; break;
			case 2: _mx = 1; _my = 1; break;
			case 3: _mx = -1; _my = 1; break;
			case 4: _mx = -2; _my = 0; break;
			case 5: _mx = -1; _my = -1; break;
		}
		//get the tile
		_id = cell_data(spell, pos_x + _mx, pos_y + _my)
		if (!instance_exists(_id)) { //create a connector if cell is empty
			_id = set_tile(spell, pos_x + _mx, pos_y + _my, SPELL.CONNECTOR)
			_id.name = child.name
			_id.image_blend = child.image_blend
			
			//create child menu
			with (instance_create_depth(x, y, depth - 1, obj_menu)) {
				pos_x = _id.pos_x
				pos_y = _id.pos_y
				spell = other.spell
				child = _id
				parent = other.id		
				menu_data = [MENU.OUTPUT, MENU.OUTPUT, MENU.OUTPUT, MENU.OUTPUT, MENU.OUTPUT, MENU.OUTPUT]
				menu_options = ["", "", "", "", "", ""]
				menu_sprite = [spr_menu_arrow, spr_menu_arrow, spr_menu_arrow, spr_menu_arrow, spr_menu_arrow, spr_menu_arrow]
				menu_active = [true, true, true, true, true, true];
				menu_angle = [330, 270, 210, 150, 90, 30];
				menu_length = 6;
				name = "OUTPUT"
				image_angle = -30;
				x = spell.x + pos_x*spell.bubble_size
				y = spell.y + pos_y*spell.hex_size*1.5
				single = true;
			}
		
		}
		//add the connection
		set_tile_output(spell, child, _id)
	break;
	
	default: //not handled, show srror
		show_debug_message("Unexpected Menu Option Type - obj_menu: " + string(menu_data[selected]))
	break;
}
