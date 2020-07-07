///@func draw_polygon(x, y, len, dir, sides, fill)
///@param x - the x-centre of the polygon
///@param y - the y-centre of the polygon
///@param len - the radius of the circle to be inscribed in
///@param dir - the direction of the first point
///@param sides - the amount of sides
///@param fill - if the polygon should be filled or an outline
///@desc draws a polygon with the given parameters
<<<<<<< HEAD
function draw_polygon() {


	//argument variables
	var _x, _y, _len, _dir, _sides; 
	_x = argument[0]
	_y = argument[1]
	_len = argument[2]
	_dir = argument[3]
	_sides = argument[4]

	//other variables
	var i, _d;

	if (argument[5]) {//if filled
		draw_primitive_begin(pr_trianglestrip) //set up primitive
		for (i = 0; i < _sides; i++) {
			_d = _dir + i*(360/_sides)
			draw_vertex(_x + lengthdir_x(_len, _d), _y + lengthdir_y(_len, _d))
			draw_vertex(_x, _y)
		}
		draw_vertex(_x + lengthdir_x(_len, _dir), _y + lengthdir_y(_len, _dir)) //draw start point
		//draw the shape
		draw_primitive_end();
	} else { //not filled
		var _t = 2
		draw_primitive_begin(pr_trianglestrip) //set up primitive
		for (i = 0; i < _sides; i++) {
			_d = _dir + i*(360/_sides)
			draw_vertex(_x + lengthdir_x(_len+_t, _d), _y + lengthdir_y(_len+_t, _d))
			draw_vertex(_x + lengthdir_x(_len-_t, _d), _y + lengthdir_y(_len-_t, _d))
		}
		//draw initial corner
		draw_vertex(_x + lengthdir_x(_len+_t, _dir), _y + lengthdir_y(_len+_t, _dir))
		draw_vertex(_x + lengthdir_x(_len-_t, _dir), _y + lengthdir_y(_len-_t, _dir))
		//draw the shape
		draw_primitive_end();
	}


}
=======


//argument variables
var _x, _y, _len, _dir, _sides; 
_x = argument[0]
_y = argument[1]
_len = argument[2]
_dir = argument[3]
_sides = argument[4]

//other variables
var i, _d;

if (argument[5]) {//if filled
	draw_primitive_begin(pr_trianglestrip) //set up primitive
	for (i = 0; i < _sides; i++) {
		_d = _dir + i*(360/_sides)
		draw_vertex(_x + lengthdir_x(_len, _d), _y + lengthdir_y(_len, _d))
		draw_vertex(_x, _y)
	}
	draw_vertex(_x + lengthdir_x(_len, _dir), _y + lengthdir_y(_len, _dir)) //draw start point
	//draw the shape
	draw_primitive_end();
} else { //not filled
	var _t = 2
	draw_primitive_begin(pr_trianglestrip) //set up primitive
	for (i = 0; i < _sides; i++) {
		_d = _dir + i*(360/_sides)
		draw_vertex(_x + lengthdir_x(_len+_t, _d), _y + lengthdir_y(_len+_t, _d))
		draw_vertex(_x + lengthdir_x(_len-_t, _d), _y + lengthdir_y(_len-_t, _d))
	}
	//draw initial corner
	draw_vertex(_x + lengthdir_x(_len+_t, _dir), _y + lengthdir_y(_len+_t, _dir))
	draw_vertex(_x + lengthdir_x(_len-_t, _dir), _y + lengthdir_y(_len-_t, _dir))
	//draw the shape
	draw_primitive_end();
}
>>>>>>> master
