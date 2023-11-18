/// @description destroy ds_lists

for (var i = 0; i < ds_list_size(children); i++) {
	children[| i].destroy();
}
for (var i = 0; i < ds_list_size(spell); i++) {
	ds_list_destroy(spell[| i].children)	
	ds_list_destroy(spell[| i].inputs)	
}
ds_list_destroy(spell)
ds_list_destroy(children)

if (surface_exists(spell_surface))			surface_free(spell_surface)
if (surface_exists(alt_particle_surface))	surface_free(alt_particle_surface)
if (surface_exists(noise_surface))			surface_free(noise_surface)
if (surface_exists(particle_surface))		surface_free(particle_surface)
