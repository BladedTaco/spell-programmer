/// @description 
if (!global.pause and !keyboard_check(vk_shift)) {
	age = (age + 1) mod 360
	sub_age[0] = (sub_age[0] + 1/2) mod 360
	sub_age[1] = (sub_age[1] + 1/3) mod 360
	sub_age[2] = (sub_age[2] + 1/4) mod 360
	true_age++;
}


