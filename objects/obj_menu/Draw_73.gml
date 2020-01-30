/// @description 
draw_self();

draw_set_colour(c_black)
draw_rectangle(x - 25, y - 25, x + 25, y + 25, false)
draw_set_colour(c_white)
draw_set_halign(fa_center)
draw_text(x, y, string(pos_x) + "," + string(pos_y))