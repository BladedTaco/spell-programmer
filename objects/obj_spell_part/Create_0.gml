/// @description 

index = -1;
tile = SPELL.MANA
type = TYPE.BASIC
name = ""
value = 0;
max_size = 0;
children = []
children_number = 0;
base_size = 60;
size = base_size;
size_ratio = 0.5
age = 0
connector_queue = [];
inputs = [];
input_colour = [];
input_number = 0;
parent = noone; //the trick tile
spell = noone; //the obj_spell
//width = room_width;
//height = room_height;
zero_angle = 0;

width = 4096
height = 4096

spell_surface = surface_create(width, height)
clip_surface = surface_create(width, height)