/// @description get children indices
//get the id of each child
for (var i = 0; i < children_number; i++) {
	with (spell.children[children[i]]) {
		other.children[i] = id; //give id
	}
}

if (type = TYPE.WIRE) {
	name = children[0].name
	image_blend = children[0].image_blend
}