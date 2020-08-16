/// A collection of scripts that convert from one data type to another

/// Functions:
///		array_to_list

//--------------------------------------------------------------------------------------------------

///@desc array_to_list(array)
///@param array - an array to turn into a ds_list
///@desc populates a ds_list with the array contents and returns the ds_list
function array_to_list(_array) {
	var _ret = new_ds_list()
	
	for (var i = 0; i < array_length(_array); i++) {
		ds_list_add(_ret, _array[i])
	}	
	
	return _ret
}

//--------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------