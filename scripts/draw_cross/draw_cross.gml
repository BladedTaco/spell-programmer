///@func draw_cross(x, y, rad, width)
///@param x - the x position to centre the cross at
///@param y - the y position to centre the cross at
///@param rad - the radius of the cross as if it were inside a circle
///@param width - the width of the lines of the cross
function draw_cross(x, y, rad, width){
	rad = rad*(sqrt(2)/2)
	draw_line_width(x - rad, y - rad, x + rad, y + rad, width)
	draw_line_width(x - rad, y + rad, x + rad, y - rad, width)
}