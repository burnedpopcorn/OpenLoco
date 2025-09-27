depth = -520;
vspeedsprite = 0;
sPauseGUI = noone;
scalepause = 1;
sPause = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), false, false, obj_screen.actualWidth / 2, obj_screen.actualHeight / 2);
sPauseGUI = sprite_create_from_surface(obj_screen.guiSurface, 0, 0, surface_get_width(obj_screen.guiSurface), surface_get_height(obj_screen.guiSurface), false, false, obj_screen.actualWidth / 2, obj_screen.actualHeight / 2);
