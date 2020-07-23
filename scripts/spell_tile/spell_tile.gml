function new_spell_tile(_px, _py, _index, _type) {
		switch (_type) {
			case SPELL.ADD_MOTION:
			case SPELL.CASTER:
			case SPELL.CONSTRUCT_VECTOR:
			case SPELL.CONSTANT:
			case SPELL.MANA:
			case SPELL.TEST:
			case SPELL.TEST2:
			case SPELL.CONNECTOR:
			case SPELL.EMPTY:
		}
}

///must be created by spell object
function spell_tile(_px, _py, _index) constructor {
	pos_x = _px
	pos_y = _py
	index = _index
	
	
	//default values
	x = room_width / 2
	y = room_height / 2
	spell = other.id
	//level = 0
	other.children[| index] = self
	
	//init
	get_data()
	
	//handle size stuff

	static get_data = function () {
		//	
	}

	static toString = function () {
		return "Spell Tile '" + name + "' at {" + string(x) + ", " + string(y) + "}"
	}
}

function wire() : spell_tile(/* ADD IN VARIABLES HERE */) constructor {
	
}


/*
	with (instance_create_depth(x, y, 0, obj_spell_part_hex)) { //create it
		x = room_width/2
		y = room_height/2
		index = i; //give index
		spell = other.id
		level = 0;
		other.children[| i] = id; //give id
		event_user(0) //get data
		//get bubble size
		if (size > _bubble) {
			if (type != TYPE.COUNTER) {
				_bubble = size	
			}
		}
		_s = other.spell[| i] //the tile
		if (_s[2] = -1) { //is a trick tile
			other.sprite_index = sprite_index
		}
	}
}
//calculate hex size
//_hex = _bubble*2/sqrt(3)
_bubble += 32 // add border
_hex = _bubble*2/sqrt(3)
bubble_size = _bubble
hex_size = _hex
//give bubble and hex size
for (i = 0; i < children_number; i++) {
	with (children[| i]) {
		event_user(1) //get children
		bubble_size = _bubble
		hex_size = _hex
		cell_size = size*2/sqrt(3)
		other.size = max(other.size, point_distance(0, 0, bubble_size*pos_x, hex_size*pos_y*HEX_MUL) + cell_size + 60)
	}
}