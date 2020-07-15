// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function point_in_hex(px, py, hx, hy, rad, dir){
	var _sqrt3 = sqrt(3)
	
	dir = degtorad((dir + point_direction(px, py, hx, hy)) mod 60)
	//show_debug_message(_sqrt3*rad / (_sqrt3*cos(dir) + sin(dir)))
	//show_debug_message(point_distance(px, py, hx, hy))
	
	return point_distance(px, py, hx, hy) <= (_sqrt3*rad / (_sqrt3*cos(dir) + sin(dir)))
}
