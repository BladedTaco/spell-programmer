//draw children(draw*)
///@param draw* - optional, skip drawing unless true

var _dir = 90 + image_angle + spell.age*visible + zero_angle
var _len = size*2
for (var i = 0; i < children_number; i++) {
	with (children[i]) {
		if (children_number = 0) { //no children
			if (other.children_number > 3) {
				if (other.zero_angle = 0) {
					_len = other.size*4 - size/cos(degtorad(180/other.children_number)); //nestle into 5-gon
				} else {
					var _l = (size/cos(degtorad(180/other.children_number))	)*sin(degtorad(180/other.children_number)) //half side length
					_len = sqrt(sqr(other.size*4) - sqr(_l)) - size; //nestle into 5-gon
				}
				x = other.x + lengthdir_x(_len, _dir)
				y = other.y + lengthdir_y(_len, _dir)
				other.connector_queue[array_length_1d(other.connector_queue)] = id
				
			} else {
				_len = other.size*4 - size*2; //nestle into triangle
				x = other.x + lengthdir_x(_len, _dir)
				y = other.y + lengthdir_y(_len, _dir)
				if (size < other.size) {
					other.connector_queue[array_length_1d(other.connector_queue)] = id
				}
			} 
		} else { //has children
			//draw connector
			_len = (other.size + size)*4;
			x = other.x + lengthdir_x(_len, _dir)
			y = other.y + lengthdir_y(_len, _dir)
			other.connector_queue[array_length_1d(other.connector_queue)] = id
		}
		image_angle = _dir - 90
		if (argument_count = 0) { //not skipped
			event_perform(ev_draw, 0)
		} else {
			if (argument[0]) {
				event_perform(ev_draw, 0)
			}
		}
		//get max size
		max_size = point_distance(x, y, parent.x, parent.y) + size*4*sign(children_number)
		//propogate max size
		if (max_size > other.max_size) {
			other.max_size = max_size	
		}
	}
	_dir += 360/children_number
}
