///@func draw_polygon(x, y, len, dir, sides, fill)
///@param x - the x-centre of the polygon
///@param y - the y-centre of the polygon
///@param len - the radius of the circle to be inscribed in
///@param dir - the direction of the first point
///@param sides - the amount of sides
///@param fill - if the polygon should be filled or an outline
///@desc draws a polygon with the given parameters


//argument variables
var _x, _y, _len, _dir, _sides; 
_x = argument[0]
_y = argument[1]
_len = argument[2]
_dir = argument[3]
_sides = argument[4]

//other variables
var _px, _py, i, _d;
_px = [];
_py = [];

if (argument[5]) {//if filled
	draw_primitive_begin(pr_trianglestrip) //set up primitive
	for (i = 0; i < _sides; i++) {
		_d = _dir + i*(360/_sides)
		_px[i] = _x + lengthdir_x(_len, _d)
		_py[i] = _y + lengthdir_y(_len, _d)
		draw_vertex(_px[i], _py[i])
		draw_vertex(x, y)
	}
	draw_vertex(_px[0], _py[0])
	draw_primitive_end();
} else { //not filled
	draw_primitive_begin(pr_linestrip) //set up primitive
	for (i = 0; i < _sides; i++) {
		_d = _dir + i*(360/_sides)
		_px[i] = _x + lengthdir_x(_len, _d)
		_py[i] = _y + lengthdir_y(_len, _d)
		draw_vertex(_px[i], _py[i])
	}
	draw_vertex(_px[0], _py[0])
	draw_primitive_end();
	
	
	
	//draw_primitive_begin(pr_linestrip) //set up primitive
	//for (i = 0; i < sides - 1; i++) {
	//	draw_vertex((_px[i] + _px[i+1])/2, (_py[i] + _py[i+1])/2)
	//}
	//draw_vertex((_px[i] + _px[0])/2, (_py[i] + _py[0])/2)
	//draw_vertex((_px[0] + _px[1])/2, (_py[0] + _py[1])/2)
	
	//draw_primitive_end();
}