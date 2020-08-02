///@func new connector(source, dest) 
///@param source - the source of the connector
///@param dest - the destination of the connector
function connector(_source, _dest) constructor {
	source = _source
	dest = _dest
	spell = _source.spell
	name = "  "
	image_blend = _source.image_blend
	size = _source.size
	alt_size = _dest.size
	age = 0
	scale = 1
	overriden = false
	
	///@func override(name, col, size, alt_size, scale)
	///@desc overrides the variables to no longer rely on the source and dest
	static override = function (_name, _col, _size, _alt_size, _scale) {
		overriden = true
		name = _name
		image_blend = _col
		size = _size
		alt_size = _alt_size
		scale = _scale
	}
	
	///@func connect()
	///@desc attaches the connector to its source and destination, does no checks
	static connect = function () {
		ds_list_add(spell.spell[| index].children, source.index)
		with (dest) {
			children_number++
			ds_list_add(children, other.source)
		}
		ds_list_add(source.connectors, self)
		
		if (dest.type == TYPE.WIRE) {
			update_connections()	
		}
	}
	
	///@func destroy()
	///@desc removes references to connector, and cleans up data structures
	static destroy = function () {
		ds_list_delete_value(spell.spell[| index].children, source.index)
		with (dest) {
			children_number--
			ds_list_delete_value(children, other.source)
		}
		ds_list_delete_value(source.connectors, self)
		
		if (dest.type == TYPE.WIRE) {
			update_connections()	
		}
		
		check_ports(spell)
	}
	
	///@func update_connections()
	///@desc updates the names and colours of wires and such
	static update_connections = function () {
		with (spell) {
			get_connector_names()
			//update wires
			if (other.dest.type = TYPE.WIRE) {
				//update wire heads |Slightly inefficient, wire paths done twice
				get_wire_heads()
				for (var i = 0; i < array_length(wire_heads); i++) {
					with (wire_heads[i]) {
						get_wire_data()
					}
				}
			}
		}
	}
	
	///@func draw()
	///@desc draws the connector
	static draw = function () {
		//handle variables
		if (!overriden) {
			image_blend = _source.image_blend
			size = _source.size
			alt_size = _dest.size
			scale = 1
		}
		
		//doesnt check for instances existing
		with (source.spell) {
			draw_set_colour(c_white)
			draw_connector(
				x + other.dest.pos_x*bubble_size,
				y + other.dest.pos_y*hex_size*HEX_MUL, 
				x + other.source.pos_x*bubble_size,
				y + other.source.pos_y*hex_size*HEX_MUL,
				other.name, other.image_blend, other.size, other.alt_size, other.age, other.scale
			)
			draw_circle_outline(x + other.dest.pos_x*bubble_size, y + other.dest.pos_y*hex_size*HEX_MUL, 20)
			draw_circle_outline(x + other.source.pos_x*bubble_size, y + other.source.pos_y*hex_size*HEX_MUL, 20)
		}
		age = ++age mod 360
	}
	
	
}