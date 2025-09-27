global.music = 
{
    secret_event_instance: noone,
    event_instance: noone,
    pillar_instance: noone,
    pillar_dist: 10,
    pitch: 1
};

start_bg_escape = false;
secret = false;
music_map = ds_map_create();

#region Level Music
add_music(rm_titleselect, "event:/music/title", "event:/music/title");
add_music([rm_test, NoRoom], "event:/music/misc/debug", "event:/music/misc/debug", function()
{
    fmod_studio_event_instance_set_parameter_by_name(global.music.event_instance, "state", room == rm_test);
});
add_music([hub_start, hub_boss1, hub_hallway, hub_3, hub_lobby, hub_afterstart, hub_afterhall, hub_tutorial, hub_hall, hub_cafe, hub_locotown, hub_forestmaze, hub_magmamine], "event:/music/hub", "event:/music/hub", function()
{
    var _state = 0;
    
    switch (room)
    {
        case hub_cafe:
            _state = 1;
            break;
        
        case hub_locotown:
            _state = 2;
            break;
        
        case hub_forestmaze:
            _state = 3;
            break;
    }
    
    fmod_studio_event_instance_set_parameter_by_name(global.music.event_instance, "state", _state);
});
add_music(Tutori_1, "event:/music/world_1/tutorii", "event:/music/world_1/tutorii");
add_music(Nhall_1, "event:/music/world_1/hallway_longway/hall", "event:/music/world_1/hallway_longway/hall_secret");
add_music([lawn_1, Nlocotown_4, lawn_outside1], "event:/music/world_1/crazii_lawn/lawn", "event:/music/world_1/crazii_lawn/lawn_secret", function()
{
    fmod_studio_event_instance_set_parameter_by_name(global.music.event_instance, "state", room == lawn_outside1);
});
add_music(forestmaze_1, "event:/music/world_1/forest_maze/maze", "event:/music/world_1/forest_maze/maze_secret");
#endregion
