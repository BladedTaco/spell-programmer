///@func func_draw_later(func)
///@param func - the function containing the logic to draw later
///@desc adds the function to the draw queue, shouldnt be called directly, use draw_later & end_draw_later
function func_draw_later(_func){
	draw_queue[draw_queue_size] = _func
	draw_queue_size += 1
}