
var _id = cell_data(argument[0], argument[1])
if (instance_exists(_id)) {
	if (_id.type = TYPE.WIRE) {
		return 0
	}
}
return instance_exists(_id)