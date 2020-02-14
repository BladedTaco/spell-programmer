/// @description destroy self or go back one menu
if (active) {
	if (instance_exists(parent)) {
		parent.active = true	
		parent.child = noone;
	}
	instance_destroy();
}