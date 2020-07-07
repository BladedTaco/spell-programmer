function draw_children_newer() {
	//draw children_newer(draw*)
	///@param draw* - optional, skip drawing unless true
	var _dir = 270 + image_angle + spell.age*visible + zero_angle
	var _len = size*2
	for (var i = 0; i < children_number; i++) {
		with (children[| i]) {
			if (children_number = 0) { //no children
				if (other.children_number > 3) {
					if (other.zero_angle = 0) {
						_len = other.size*4 - size/cos(degtorad(180/other.children_number)); //nestle into 5-gon
					} else {
						var _l = (size/cos(degtorad(180/other.children_number))	)*sin(degtorad(180/other.children_number)) //half side length
						_len = sqrt(sqr(other.size*4) - sqr(_l)) - size; //nestle into 5-gon
					}
					x = other.x + lengthdir_x(_len*other.image_xscale, _dir)
					y = other.y + lengthdir_y(_len*other.image_xscale, _dir)
				
				} else {
					_len = other.size*4 - size*2; //nestle into triangle
					if (other.type = TYPE.CONVERTER) {
						x = other.x + lengthdir_x(_len*other.image_xscale, _dir) - lengthdir_x(size*2*sign((i != 0) -0.5), 90 + other.image_angle)
						y = other.y + lengthdir_y(_len*other.image_xscale, _dir) - lengthdir_y(size*2*sign((i != 0) -0.5), 90 + other.image_angle)
					} else {
						x = other.x + lengthdir_x(_len*other.image_xscale, _dir)
						y = other.y + lengthdir_y(_len*other.image_xscale, _dir)
					}
				} 
			} else { //has children
				//draw connector
				//_len = other.size*4 + bubble_size;
				_len = other.size*4*other.image_xscale + bubble_size*image_xscale
				x = other.x + lengthdir_x(_len, _dir)
				y = other.y + lengthdir_y(_len, _dir)
			}
			image_angle = _dir + 90
			if (argument_count = 0) { //not skipped
				event_perform(ev_draw, 0)
			} else {
				if (argument[0]) {
					event_perform(ev_draw, 0)
				}
			}
		
		}
		_dir += 360/children_number
	}



}
