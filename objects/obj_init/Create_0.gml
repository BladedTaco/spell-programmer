/// @description 
macros()

draw_set_font(fnt_main)

draw_set_circle_precision(64)

show_debug_overlay(global.debug)

instance_create_depth(room_width/2, room_height/2, 0, obj_spell)
