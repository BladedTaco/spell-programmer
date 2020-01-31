
var _id = instance_nearest(
	spell.x + argument[0]*spell.bubble_size,
	spell.y + argument[1]*spell.hex_size*1.5,
	obj_spell_part_hex
)
if (instance_exists(_id)) {
	if (point_distance(x, y, _id.x, _id.y) > 20) {
		_id = noone;
	}
}

return _id