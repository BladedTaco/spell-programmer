/// @description 
//draw_self();

draw_set_colour(c_black)
draw_polygon(x, y, obj_spell.hex_size, 90, 6, false)
draw_set_colour(c_black)
draw_set_alpha(0.75)
draw_circle(x, y, 30, false)
draw_set_alpha(1)
draw_set_colour(c_white)
draw_circle_outline(x, y, 30)
draw_set_halign(fa_center)
draw_text(x, y, string(pos_x) + "," + string(pos_y))

draw_set_halign(fa_left)
var _x, _y, _dir, _sep;
_sep = 60//360/menu_length
for (var i = 0; i < menu_length; i++) {
	if (menu_active[i]) {
		_dir = min(life*6*(life/20), 120) - i*_sep - 30 //add a spin out animation
		_x = round(x + lengthdir_x(min(life*3, 60), _dir))
		_y = round(y + lengthdir_y(min(life*3, 60), _dir))
		draw_set_colour(c_black)
		draw_set_alpha(0.75)
		draw_line_width(_x - 20 + 40*(i < 4), _y, _x + (min(life*life, 400)/400)*(30 + string_width(menu_options[i]))*2*((i < 4)-0.5), _y, 20)
		draw_circle(_x, _y, 20, false)
		draw_set_alpha(1)
		draw_set_colour(c_white)
		draw_circle_outline(_x, _y, 20)
		draw_sprite(menu_sprite[i], image_index, _x + 1, _y + 1)
		if (life > 19) {
			if (i < 4) {
				draw_text(_x + 25, _y, menu_options[i])
			} else {
				draw_set_halign(fa_right)
				draw_text(_x - 25, _y, menu_options[i])
			}
		}
	}
}

//draw_set_halign(fa_center)