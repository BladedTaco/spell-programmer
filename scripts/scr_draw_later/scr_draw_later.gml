// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_draw_later(_func){
	draw_queue[draw_queue_size] = _func
	draw_queue_size += 1
}