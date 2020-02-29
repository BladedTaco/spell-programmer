/// @description get children indices
//get the id of each child

for (var i = 0; i < children_number; i++) {
	with (spell.children[children[i]]) {
		other.children[i] = id; //give id
	}
}

event_user(2)