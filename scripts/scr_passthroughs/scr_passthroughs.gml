// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function instance_create(x, y, obj) {
	return instance_create_depth(x, y, 0, obj)
}
