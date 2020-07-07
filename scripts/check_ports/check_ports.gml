///@func check_ports(spell)
///@param spell - the spell object to check
///@desc check all ports and removes entries that dont connect

function check_ports() {

	var _lst, _s;
	with (argument[0]) {
		for (var i = 0; i < children_number; i++) {
			_s = spell[| i]
			with (children[| i]) {
				for (var o = 0; o < input_number; o++) {
					_lst = scr_get_path(id, input_tile[| o])
					if (ds_list_size(_lst) = 0) {
						input_tile[| o] = noone
						ds_list_replace(_s[5], o, -1)
					}
					ds_list_destroy(_lst)
				}
			}
		}
	}


}


var _lst, _s;
with (argument[0]) {
	for (var i = 0; i < children_number; i++) {
		_s = spell[| i]
		with (children[| i]) {
			for (var o = 0; o < input_number; o++) {
				_lst = scr_get_path(id, input_tile[| o])
				if (ds_list_size(_lst) = 0) {
					input_tile[| o] = noone
					ds_list_replace(_s[5], o, -1)
				}
				ds_list_destroy(_lst)
			}
		}
	}
}

