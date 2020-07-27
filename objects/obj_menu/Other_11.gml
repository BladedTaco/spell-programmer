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
			menu_data = [MENU.TILE_EMPTY, MENU.TILE_META, MENU.TILE_BASIC, MENU.TILE_CONSTANT, MENU.TILE_CONVERTER, MENU.TILE_MANA]
			menu_options = ["EMPTY", "META", "BASIC", "CONSTANT", "CONVERTER", "MANA"]
			menu_sprite = [spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null]
			menu_active = [is_struct(child), true, true, true, true, true];
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
			name = string_replace_all(string_format(child.value, 7 - 4*(child.radius <= 1), 0), " ", "0")
			image_angle = -30;
			value = 0
		}
	break;
	
	case MENU.NAM: //set name
		//child.name = choose("name 1", "1337 5347", "waga na wa Megumin")
		active = false;
		var _menu = id;
		var _tile = get_wireless_inputs(child)
		for (var m = 0; m < ds_list_size(_tile); m++) { //for each entry
			with (_tile[| m]) {
				with (instance_create_depth(other.x, other.y, other.depth - 1, obj_menu)) {
					var _destroy = true;
					active = true;
					pos_x = other.pos_x
					pos_y = other.pos_y
					spell = _menu.spell
					child = other.id
					parent = _menu	
					menu_options = _menu.child.inputs
					menu_length = array_length_1d(menu_options)
					for (var i = 0; i < menu_length; i++) {
						menu_active[i] = (other.image_blend == _menu.child.input_colour[i])
						_destroy = min(_destroy, !menu_active[i]) //destroy on no valid inputs
						menu_sprite[i] = spr_menu_null
						if (_menu.child.input_tile[| i] = other.id) { //already in list
							menu_sprite[i] = spr_menu_circle	
						}
						menu_angle[i] = 0
						menu_data[i] = MENU.INPUT
					}
					name = "INPUT"
					x = spell.x + pos_x*spell.bubble_size
					y = spell.y + pos_y*spell.hex_size*HEX_MUL
					if (_destroy) {
						instance_destroy();	
					}
				}
			}
		}
		ds_list_destroy(_tile)
	break;
	
	case MENU.MOV: //move tile
		//create child menu
		active = false;
		with (instance_create_depth(x, y, depth - 1, obj_menu)) {
			left_click_action = true
			single = true
			pos_x = other.pos_x
			pos_y = other.pos_y
			spell = other.spell
			child = other.child
			parent = other.id
			menu_active = [false, false, false, false, false, false];
			menu_data[5] = MENU.MOVE_TILE
			menu_length = 0;
			name = "MOVE"
			selected = 0 //strictly empty tiles
		}
	break;
	
	case MENU.SEL: //select group
		//create child menu
		active = false;
		with (instance_create_depth(x, y, depth - 1, obj_menu)) {
			pos_x = other.pos_x
			pos_y = other.pos_y
			spell = other.spell
			child = other.child
			parent = other.id		
			menu_data = [MENU.TILE_GROUP, MENU.PACKAGE_GROUP, MENU.VAL_GROUP, MENU.LEVEL_GROUP, MENU.MOVE_GROUP, MENU.GROUP]
			menu_options = ["Set Tile", "Set Colour", "Set Value", "Move to New Circle", "Move Tile"]
			menu_sprite = [spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null, spr_menu_null]
			menu_active = [true, true, true, true, true];
			menu_length = 5;
			name = "GROUP"
			left_click_action = 2
			left_click_only = false;
			group = new_ds_list(child);
		}
	break;
	
	//menu group subroutines
	case MENU.GROUP: //add or remove tile from group
		var _id = cell_data(spell, pos_x, pos_y)
		var _p = -1;
		if (is_struct(_id)) {
			if (point_distance(
					mouse_x, mouse_y,
					spell.x + _id.pos_x*_id.bubble_size,
					spell.y + _id.pos_y*_id.hex_size*HEX_MUL
				) < 30) {
				_p = ds_list_find_index(group, _id)
				if (_p > -1) {
					// remove from group
					ds_list_delete(group, _p)
				} else {
					//add to group
					ds_list_add(group, _id)
				}
			}
		}
	break;
	case MENU.MOVE_GROUP: //Move the tiles together as a group
	
	break;
	case MENU.VAL_GROUP: //Change the tiles values together as a group
	
	break;
	case MENU.TILE_GROUP: //Change all the tiles in the group
	
	break;
	case MENU.PACKAGE_GROUP: //Add a colour region to all the tiles in the group
		for (var i = 0; i < ds_list_size(group); i++) {
			group[| i].group_colour = make_colour_hsv(random(256), 256, 256)
			show_debug_message(group[| i].group_colour)
		}
	break;
	case MENU.LEVEL_GROUP: //Split the group off into a new spell circle
	
	break;
	
	case MENU.VAL_UP:
		child.value += power(10, value)
		child.value = min(child.value, child.max_val - (child.max_val - child.small_max_val)*(child.radius <= 1))
		name = string_replace_all(string_format(child.value, 7 - 4*(child.radius <= 1), 0), " ", "0")
		child.get_size()
	break;
	case MENU.VAL_BIG_UP:
		child.value += 5*power(10, value)
		child.value = min(child.value, child.max_val - (child.max_val - child.small_max_val)*(child.radius <= 1))
		name = string_replace_all(string_format(child.value, 7 - 4*(child.radius <= 1), 0), " ", "0")
		child.get_size()
	break;
	case MENU.VAL_DOWN:
		child.value -= power(10, value)
		child.value = max(child.value, 0)
		name = string_replace_all(string_format(child.value, 7 - 4*(child.radius <= 1), 0), " ", "0")
		child.get_size()
	break;
	case MENU.VAL_BIG_DOWN:
		child.value -= 5*power(10, value)
		child.value = max(child.value, 0)
		name = string_replace_all(string_format(child.value, 7 - 4*(child.radius <= 1), 0), " ", "0")
		child.get_size()
	break;
	case MENU.VAL_LEFT:
		value += 1
		value = min(value, 6 - 4*(child.radius <= 1))
	break;
	case MENU.VAL_RIGHT:
		value -= 1
		value = max(value, 0)
	break;
	
	case MENU.TILE_EMPTY: //remove tile
		set_tile(spell, pos_x, pos_y, SPELLS.empty)
		//destroy menus
		instance_destroy(parent)
		instance_destroy();
	break;
	case MENU.TILE_TRICK: //trick tile
		parent.child = set_tile(spell, pos_x, pos_y, SPELLS.add_motion)
		with (parent) { event_user(2) };
		instance_destroy();
	break;
	case MENU.TILE_META: //connetor tile (will be tiles that interact between circles, or are special or output time or such variables)
		parent.child = set_tile(spell, pos_x, pos_y, SPELLS.wire)
		with (parent) { event_user(2) };
		instance_destroy();
	break;
	case MENU.TILE_BASIC: //basic tile
		parent.child = set_tile(spell, pos_x, pos_y, SPELLS.caster)
		with (parent) { event_user(2) };
		instance_destroy();
	break;
	case MENU.TILE_CONSTANT: //constant tile
		parent.child = set_tile(spell, pos_x, pos_y, SPELLS.constant)
		with (parent) { event_user(2) };
		instance_destroy();
	break;
	case MENU.TILE_CONVERTER: //converter tile
		parent.child = set_tile(spell, pos_x, pos_y, SPELLS.construct_vector)
		with (parent) { event_user(2) };
		instance_destroy();
	break;
	case MENU.TILE_MANA: //mana tile
		parent.child = set_tile(spell, pos_x, pos_y, SPELLS.mana_source)
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
		if (!is_struct(_id)) { //create a connector if cell is empty
			_id = set_tile(spell, pos_x + _mx, pos_y + _my, SPELLS.wire)
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
				y = spell.y + pos_y*spell.hex_size*HEX_MUL
				//single = true;
			}
		
		}
		//add the connection
		set_tile_output(spell, child, _id)
	break;
	
	case MENU.INPUT: //toggle input
		var _index = selected;
		var _child = child.id
		var _menu = id
		var _c, _s;
		with (parent.child) {
			if (_child = input_tile[| _index]) { //already in this spot in the list
				ds_list_replace(input_tile, _index, noone)	
				ds_list_replace(spell.spell[| index].inputs, _index, noone)	
				_menu.menu_sprite[_index] = spr_menu_null
			} else { // not in this spot in the list
				//replace previous
				_c = input_tile[| _index]
				with (obj_menu) {
					if (child.id = _c) {
						menu_sprite[_index] = spr_menu_null
					}
				}
				ds_list_replace(input_tile, _index, _child)
				ds_list_replace(spell.spell[| index].inputs, _index, _child.index)
				_menu.menu_sprite[_index] = spr_menu_circle
			}
		}
		//recalculate connectors
		with (spell) {
			event_user(1)	
		}
	break;
	
	case MENU.MOVE_TILE:
		reposition_tile(child, pos_x, pos_y)
		with (parent) {
			active = true
			pos_x = other.pos_x
			pos_y = other.pos_y
			x = spell.x + pos_x*spell.bubble_size
			y = spell.y + pos_y*spell.hex_size*HEX_MUL
			name = string(pos_x) + "," + string(pos_y)
		}
	break;
	
	default: //not handled, show srror
		show_debug_message("Unexpected Menu Option Type - obj_menu: " + string(menu_data[selected]))
	break;
}
