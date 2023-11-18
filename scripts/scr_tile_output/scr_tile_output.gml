/// A collection of scripts that handle manipulating tile connections

/// Functions:
///		set_tile_output
///		force_tile_output
///		add_connector
///		remove_connector

//--------------------------------------------------------------------------------------------------

///@func set_tile_output(source, dest)
///@param source - the tile to set the output of
///@param dest - the tile to input into
///@desc sets the output of one tile into another, or removes it if it exists
function set_tile_output( _source, _dest) {
	//remove the connector if it exists
	if (!remove_connector(_source, _dest)) {
		//else create it if it doesnt
		//check for lööps brötha
		if (!check_for_loops(_source, _dest)) {
			var _connector = new connector(_source, _dest);
			_connector.connect()
		}
	}
}

//--------------------------------------------------------------------------------------------------

///@func force_tile_output(source, dest, *unsafe)
///@param source - the tile to set the output of
///@param dest - the tile to input into
///@param unsafe - if loop checking should be ignored
///@desc sets the output of one tile into another, forcing the connection if it doesnt create loops
///yes, nö lööps brötha
///will trim any connections beforehand, so if the new connection cant be made, will remove the old one
function force_tile_output(_source, _dest, _unsafe) {
	_unsafe = is_undefined(_unsafe) ? false : _unsafe
	
	//remove connections between the two tiles
	remove_connector(_source, _dest)
	remove_connector(_dest, _source)
	
	//check for lööps brötha
	if (_unsafe or !check_for_loops(_source, _dest)) {
		var _connector = new connector(_source, _dest);
		_connector.connect()
	}
}

//--------------------------------------------------------------------------------------------------

///@func add_connector(source, dest, unsafe*)
///@param source - the tile to set the output of
///@param dest - the tile to input into
///@param unsafe - if loop checking should be ignored
///@desc adds a connector between the source and destination, returns successfullness
function add_connector(_source, _dest, _unsafe) {
	//optional arguments
	_unsafe = is_undefined(_unsafe) ? false : _unsafe
	
	//check for lööps brötha, then add connection
	if (_unsafe or !check_for_loops(_source, _dest)) {
		var _connector = new connector(_source, _dest);
		_connector.connect()
		return true
	}
	return false
}

//--------------------------------------------------------------------------------------------------

///@func remove_connector(source, dest)
///@param source - the tile to set the output of
///@param dest - the tile to input into
///@desc removes the connector between the source and destination, returns if it was found
///if the connector is already known, use .destroy()
function remove_connector(_source, _dest) {
	//find the connector
	for (var i = 0; i < ds_list_size(_source.connectors); i++) {
		if (_source.connectors[| i].dest == _dest) {
			_source.connectors[| i].destroy()	
			return true
		}
	}
	return false
}