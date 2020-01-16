/// @description 
if (surface_exists(clip_surface)) {
	surface_free(clip_surface)
}
if (surface_exists(anticlockwise_surface)) {
	surface_free(anticlockwise_surface)
}
if (surface_exists(clockwise_surface)) {
	surface_free(clockwise_surface)
}