/// @description 

anim_index++
var _anim_mul = 0.5
var _circle_size = size
var _px, _py, _len, _dir, _mul; //lengthdir
var i, o, _num, _sign, _str; //various uses

//move whole circle
start_x = x - lengthdir_x(_circle_size, anim_index*_anim_mul - 120)
start_y = y - lengthdir_y(_circle_size, anim_index*_anim_mul - 120)


draw_set_colour(c_white)

//name circle
draw_circle(x, y, _circle_size*2.6, false)

//name
draw_set_colour(c_ltgray)
draw_text_circle(x, y, string_repeat("   JUMP ASSIST   ", sides*2), _circle_size*2.6 + 10, 180, anim_index*_anim_mul + 60)


//name circle outer
draw_set_colour(c_white)
draw_circle(x, y, _circle_size*2.6 + 20, true)

//icon outer
for (i = 0; i < sides*4; i++) {
	_len = _circle_size*3.4
	_dir = -anim_index*_anim_mul - i/(sides*4)*360
	_px = x + lengthdir_x(_len, _dir)
	_py = y + lengthdir_y(_len, _dir)
	draw_sprite_ext(sprite_index, image_index, _px, _py, 1, 1, _dir - 90, c_white, 1)
}

//outer triangle
_px = []
_py = []
for (i = 0; i < 3; i++) {
	_len = _circle_size*4
	_dir = anim_index*_anim_mul + i*120 + 60
	_px[i] = x + lengthdir_x(_len, _dir)
	_py[i] = y + lengthdir_y(_len, _dir)
}

draw_set_colour(c_black)
draw_triangle(_px[0], _py[0], _px[1], _py[1], _px[2], _py[2], false);

//triangle circles
for (i = 0; i < 3; i++) {
	_len = _circle_size*4
	if (i = 0) { _len *=2.5}
	_dir = anim_index*_anim_mul - i*120 + 60 //make sure its done clockwise
	
	_mul = 1 - sub_size[i] //value from 0.5 - 1
	_px[i+3] = x + lengthdir_x(_len, _dir)*_mul
	_py[i+3] = y + lengthdir_y(_len, _dir)*_mul

	//connector rods
	if (_mul >= 0.5) {//not max size
		//draw connector
		draw_set_colour(sub_colour[i])
		draw_line_width(
			x + lengthdir_x(_circle_size, _dir),
			y + lengthdir_y(_circle_size, _dir),
			_px[i+3], _py[i+3], 24
		)
		//draw black inner
		draw_set_colour(c_black)
		draw_line_width(
			x + lengthdir_x(_circle_size, _dir),
			y + lengthdir_y(_circle_size, _dir),
			_px[i+3], _py[i+3], 18
		)
		
		//draw text
		draw_set_colour(sub_colour[i])
		draw_set_halign(fa_left)
		draw_text_transformed(
			x + lengthdir_x(_circle_size, _dir),
			y + lengthdir_y(_circle_size, _dir),
			string_repeat(sub_string[i], ceil((_len*_mul - _circle_size - _circle_size*(2-_mul*2))/string_width(sub_string[i]))),
			1, 1, _dir
		)
	}
	
	//circles
	draw_set_colour(c_black)
	draw_circle(_px[i+3], _py[i+3], _circle_size*(2-_mul*2), false)
	draw_set_colour(sub_colour[i])
	draw_circle(_px[i+3], _py[i+3], _circle_size*(2-_mul*2), true)
	draw_sprite_ext(sub_sprite[i], 0, _px[i+3], _py[i+3], 1, 1, _dir - 90, sub_colour[i], 1)
	
	if (i = 0) { //construct vector
		draw_circle(_px[i+3], _py[i+3], _circle_size*(2-_mul*2)/2 - 20, false) //centre fill
		draw_circle(_px[i+3], _py[i+3], _circle_size*(2-_mul*2)/2 - 10, true) //centre donut inner
		draw_circle(_px[i+3], _py[i+3], _circle_size*(2-_mul*2)/2 + 10, true) //centre donut outer
		draw_text_circle(_px[i+3], _py[i+3], string_repeat("VECTOR   ", 3), _circle_size*(2-_mul*2)/2, 180, anim_index*_anim_mul)
		
		
	} else if (i = 1) { //mana
		for (o = 0; o < string_length(string(mana)); o++) {
			//counter
			_num = real(string_char_at(string(mana), o+1))
			_sign = sign((o/2 != round(o/2)) - 0.5)
			_sign += (_sign + 1)/2
			switch (string_length(string(mana)) - o) {
				case 1:	_str = "ONE "; break;
				case 2:	_str = "TEN "; break;	
				case 3:	_str = "HUN "; break;
				case 4:	_str = "THO "; break;	
			}
			draw_text_circle(
				_px[i+3], _py[i+3], string_repeat(_str, 10), _circle_size*(2-_mul*2) - 10 - o*20,
				180, -anim_index*_anim_mul*_sign
			)
			draw_circle_curve(
				_px[i+3], _py[i+3], _circle_size*(2-_mul*2) - 10 - o*20,
				(_num/10)*64, anim_index*_anim_mul*_sign,
				_num*36, 20, 1
			)
			draw_circle(_px[i+3], _py[i+3], _circle_size*(2-_mul*2) - o*20 - 20, true)
		}
		_sign = sign((o/2 != round(o/2)) - 0.5)
		_sign += (_sign + 1)/2
		draw_text_circle(_px[i+3], _py[i+3], string_repeat(sub_name[i] + "  ", 2), _circle_size*(2-_mul*2) - o*20 - 10, 180, -anim_index*_anim_mul*_sign)
		draw_circle(_px[i+3], _py[i+3], _circle_size*(2-_mul*2) - o*20 - 20, true)
	} else if (i = 2) { //caster
		draw_text_circle(_px[i+3], _py[i+3], string_repeat(sub_name[i] + "  ", 4), _circle_size*(2-_mul*2) - 10, 180, anim_index*_anim_mul)
		draw_circle(_px[i+3], _py[i+3], _circle_size*(2-_mul*2) - 20, true)
	}
}

//draw outer triangle
draw_set_colour(c_white)
draw_triangle(_px[0], _py[0], _px[1], _py[1], _px[2], _py[2], true);

//icon
draw_sprite(trick_sprite, image_index, x, y)

//trick text and ring
draw_circle(x, y, _circle_size - 40, true)
draw_text_circle(x, y, string_repeat(trick_string + "  ", 3), _circle_size - 30, 180, anim_index*_anim_mul + 60)

//inner circle
draw_circle(x, y, _circle_size - 20, true)

//input param text
for (i = 0; i < 3; i++) {
	draw_set_colour(sub_colour[i])
	draw_text_circle(x, y, sub_string_spaced[i], _circle_size - 10, 180, -anim_index*_anim_mul + 60)
}


//outer circle
draw_set_colour(c_white)
draw_circle(x, y, _circle_size, true)

//triangle
_px = []
_py = []
for (i = 0; i < 3; i++) { //for each cell/edge
	_len = _circle_size*2
	_dir = anim_index*_anim_mul + i*120
	_px[i] = x + lengthdir_x(_len, _dir)
	_py[i] = y + lengthdir_y(_len, _dir)
}

draw_triangle(_px[0], _py[0], _px[1], _py[1], _px[2], _py[2], true);

//draw trick outer ring
draw_set_colour(c_white)
draw_circle(x, y, _circle_size*4, true)

//draw actvation ring
draw_set_colour(c_lime)
draw_circle(start_x, start_y, _circle_size*5, true)
draw_circle(start_x, start_y, _circle_size*5 + 20, true)
draw_circle(start_x, start_y, _circle_size*5 + 40, true)
					 
//draw activation text
draw_text_circle(start_x, start_y, string_repeat("   ON JUMP   ", sides*3), _circle_size*5 + 10, 180, -anim_index*_anim_mul + 60)
draw_text_circle(start_x, start_y, string_repeat("   NOT CROUCH  ", sides*3), _circle_size*5 + 30, 180, anim_index*_anim_mul + 60)
