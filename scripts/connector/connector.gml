///@func connector(source, dest) 
///@param source - the source of the connector
///@param dest - the destination of the connector
///@desc gives the child a connector to its parent
function connector(_source, _dest) constructor {
	source = _source
	dest = _dest
	spell = _source.spell
	name = ""
	names = ds_list_create()
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
		ds_list_add(spell.spell[| dest.index].children, source.index)
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
		
		if (name != "") {
			check_ports(spell)
		}
		
		ds_list_destroy(names)
	}
	
	///@func add_name(name)
	///@param name - the name to add
	///@desc adds the given name and updates the connector
	static add_name = function (_name) {
		ds_list_add(names, _name)
		get_name()
	}
	
	
	///@func get_name()
	///@desc updates the name of the connector
	static get_name = function () {
		name = "  " + names[| 0]
		for (var i = 0; i < ds_list_size(names); i++) {
			name += " + " + names[| i]	
		}
	}	
	
	///@func propogate_name(goal, name, connect)
	///@param {tile} goal - the tile that has this tile as an input_tile
	///@param {string} name - the name to propogate
	///@param {bool} connect - if it is a connection being made
	///@desc propogates a names addition or removal
	static propogate_name = function (_goal, _name, _connect) {
		if (_connect) {
			ds_list_add(names, _name)
			get_name()
			var _path = get_wire_path(self, _goal)
			ds_list_add(_path, _goal)
			//handle no wire / first connection
			spell.get_connector(self, _path[| 0]).add_name(_name)
			for (var i = 0; i < ds_list_size(_path) - 1; i++) {
				//give tile name
				_path[| i].add_name(self, _name)
				//give connector name
				spell.get_connector(_path[| i], _path[| i+1]).add_name(_name)
			}
		}
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
			image_blend = source.image_blend
			size = source.size
			alt_size = dest.size
			scale = 1
		}
		
		//doesnt check for instances existing
		draw_set_colour(c_white)
		draw_connector(
			dest.x, dest.y, source.x, source.y, name, 
			image_blend, size, alt_size, age, scale
		)
		draw_circle_outline(dest.x, dest.y, 20)
		draw_circle_outline(source.x, source.y, 20)
		age = ++age mod 360
	}
	
	
}