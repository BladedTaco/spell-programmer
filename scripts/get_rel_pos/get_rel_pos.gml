function get_rel_pos() {
	//draw children(draw*)
	///@param draw* - optional, skip drawing unless true

	var _len = size*2
	var i = argument[1]
	with (argument[0]) {
		var _dir = 90  + zero_angle + i*360/children_number
		with (children[| i]) {
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
				
				} else {
					_len = other.size*4 - size*2; //nestle into triangle
					x = other.x + lengthdir_x(_len, _dir)
					y = other.y + lengthdir_y(_len, _dir)
				} 
			} else { //has children
				////draw connector
				////_len = other.size*4 + bubble_size;
				//_len = other.size*4*other.image_xscale + bubble_size*image_xscale
				//x = other.x + lengthdir_x(_len, _dir)
				//y = other.y + lengthdir_y(_len, _dir)
			}
		}
	}



}
