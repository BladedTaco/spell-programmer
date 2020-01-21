/// @description 

if (instance_exists(obj_spell_part)) {
	with (all) {
		if (id != other.id) {
			instance_destroy(id)
		}
	}
	global.spell_part = obj_spell_part_old
	instance_create_depth(room_width/2, room_height/2, 0, obj_spell)
} else if (instance_exists(obj_spell_part_old)) {
	with (all) {
		if (id != other.id) {
			instance_destroy(id)
		}
	}
	instance_create_depth(room_width/2, room_height/2, 0, obj_circle)
} else if (instance_exists(obj_circle)) {
	with (all) {
		if (id != other.id) {
			instance_destroy(id)
		}
	}
	global.spell_part = obj_spell_part_new
	instance_create_depth(room_width/2, room_height/2, 0, obj_spell)
} else if (instance_exists(obj_spell_part_new)) {
	with (all) {
		if (id != other.id) {
			instance_destroy(id)
		}
	}
	global.spell_part = obj_spell_part
	instance_create_depth(room_width/2, room_height/2, 0, obj_spell)
}


