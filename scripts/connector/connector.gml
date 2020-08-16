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
		return self
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
		return self
	}
	
	///@func destroy()
	///@desc removes references to connector, and cleans up data structures
	static destroy = function () {
		//cut off any connections that used this connector
		for (var i = 0; i < ds_list_size(names); i++) {
			with (names[| i]) { 
				var _index = ds_list_find_index(goal.input_tile, tile)
				ds_list_replace(goal.input_tile, _index, noone)	
				ds_list_replace(goal.spell.spell[| goal.index].inputs, _index, -1)	
				tile.propogate_name(goal, self, false)
			}
		}
		
		//remove data from parent and spell
		with (dest) {
			children_number--
			ds_list_delete_value(children, other.source)
			ds_list_delete_value(spell.spell[| index].children, other.source.index)
		}
		
		//remove self from source
		ds_list_delete_value(source.connectors, self)
		
		//clean up ds lists
		ds_list_destroy(names)
	}
	
	///@func add_name(name)
	///@param name - the name to add
	///@desc adds the given name and updates the connector
	static add_name = function (_name) {
		ds_list_add(names, _name)
		get_name()
	}
	
	///@func remove_name(name)
	///@param name - the name to add
	///@desc removes the given name and updates the connector
	static remove_name = function (_name) {
		ds_list_delete_value(names, _name)
		get_name()
	}
	
	///@func get_name()
	///@desc updates the name of the connector
	static get_name = function () {
		if (ds_list_size(names) > 0) {
			name = "  " + names[| 0].name
		} else {
			name = ""	
		}
		for (var i = 1; i < ds_list_size(names); i++) {
			name += " + " + names[| i].name
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
	
	
	static toString = function () {
		return "CONNECTOR from " + string(source) + " to " + string(dest) + ". name = " + name	
	}
	
}