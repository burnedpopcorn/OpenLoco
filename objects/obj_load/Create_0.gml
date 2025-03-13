if (room != rm_preload && room != rm_load)
{
    var _screenfliter = frac(obj_screen.app_scale) > 0;
    drawscreen = true;
    screen = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), false, _screenfliter, 0, 0);
    screen_gui = sprite_create_from_surface(obj_screen.guiSurface, 0, 0, surface_get_width(obj_screen.guiSurface), surface_get_height(obj_screen.guiSurface), false, false, 0, 0);
    transition_object = obj_fadecircle;
    
    transition_obj_cc = function()
    {
    };
    
    texgroups = [];
    alarm[2] = 9;
    exit;
}

draw_flush();
window_set_size(960, 540);
surface_resize(application_surface, 960, 540);
camera_set_view_size(view_camera[0], 960, 540);

if (room == rm_preload)
{
    scr_globalinit();
    alarm[0] = 15;
    exit;
}

state = 0;
data = 
{
    texgroups: ["player_group", "hud_group", "pizza_group", "titlescreen_group", "hub_group", "small_group"],
    loadtext: ["Loading Audio..", "Loading Sprites..", "Loading Shaders.."],
    loadsprites: [spr_musicobject, spr_parralaxobject, spr_cameraobject]
};
alarm[1] = 3;
