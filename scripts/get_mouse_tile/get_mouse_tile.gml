// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_mouse_tile(_spell){
	var _pos = mouse_to_tile(_spell, 30)
	if (_pos == noone) return noone
	return cell_data(_spell, _pos[0], _pos[1])
}