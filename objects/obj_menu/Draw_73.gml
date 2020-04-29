/// @description 
//draw_self();

var _a = 0.5 + active*0.5 //reduce alpha if not active
draw_set_alpha(_a)
draw_set_colour(c_black)
draw_polygon(x, y, obj_spell.hex_size, 90, 6, false)
draw_set_colour(c_ltgray + $4f4f4f)
draw_set_alpha(_a*0.3)
draw_polygon(x, y, obj_spell.hex_size, 90, 6, true)
draw_set_colour(c_black)
draw_set_alpha( _a * 0.75)
draw_circle(x, y, 30, false)
draw_set_alpha( _a * 1)
draw_set_colour(c_white)
draw_circle_outline(x, y, 30)
draw_set_halign(fa_center)
draw_text(x, y, name)

if (value > -1) {
	draw_text(x - value*string_width("0") + string_width(string_delete(name, 1, 1))/2 - 1, y + 12, "^")
}

draw_set_halign(fa_left)
var _x, _y, _dir, _sep;
_sep = 60//360/menu_length
for (var i = 0; i < menu_length; i++) {
	if (menu_active[i]) {
		_dir = image_angle + min(life*6*(life/20), 120) - i*_sep - 30 //add a spin out animation
		_x = round(x + lengthdir_x(min(life*3, 60), _dir))
		_y = round(y + lengthdir_y(min(life*3, 60), _dir))
		draw_set_colour(c_black)
		draw_set_alpha( _a * 0.75)
		if (menu_options[i] != "") {
			draw_line_width(_x - 20 + 40*(i < 3), _y, _x + (min(life*life, 400)/400)*(30 + string_width(menu_options[i]))*2*((i < 3)-0.5), _y, 20)
			if (active and point_in_circle(mouse_x, mouse_y, _x, _y, 20)) {
				draw_set_colour(c_dkgray)
			}
		}
		draw_circle(_x, _y, 20, false)
		draw_set_alpha( _a * 1)
		draw_set_colour(c_white)
		draw_circle_outline(_x, _y, 20)
		draw_sprite_ext(menu_sprite[i], image_index, _x + 1, _y + 1, 1, 1, menu_angle[i] + (min(life*6*(life/20), 120) - 120), c_white, _a)
		if (life > 19) {
			if (i < 3) {
				draw_text(_x + 25, _y, menu_options[i])
			} else {
				draw_set_halign(fa_right)
				draw_text(_x - 25, _y, menu_options[i])
			}
		}
	}
}

//draw group selection
if (group > -1) {
	if (ds_exists(group, ds_type_list)) {
		draw_set_colour(c_dkgray)
		for (i = 0; i < ds_list_size(group); i++) {
			_x = spell.x + group[| i].pos_x*group[| i].bubble_size
			_y = spell.y + group[| i].pos_y*group[| i].hex_size*HEX_MUL
			draw_set_alpha(_a*0.35)
			draw_circle(_x, _y, 20, false)
			draw_set_alpha( _a * 1)
			draw_circle_outline(_x, _y, 20)	
			draw_set_alpha(1)
			draw_sprite(spr_menu_circle, 0, _x, _y)
		}
		draw_set_colour(c_white)
	}
}
//draw_set_halign(fa_center)