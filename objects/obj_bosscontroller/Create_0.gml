if (instance_number(object_index) > 1)
{
    instance_destroy();
    exit;
}

hp = 
{
    boss: 6,
    player: 6,
    boss_shakemag: 0,
    player_shakemag: 0
};
state = boss_states.intro1;
intro_scene = 
{
    portraits_alpha: 0,
    p1: 
    {
        sprite: spr_vsdamian,
        shadow: spr_vsdamianshadow,
        xoff: -500,
        shown: false
    },
    p2: 
    {
        sprite: spr_vsnoise,
        shadow: spr_vsnoise,
        xoff: 500,
        shown: false
    },
    vstitle: spr_vstitle,
    title_alpha: 0,
    portrait_back: false,
    white_alpha: 0,
    back_alpha: 0,
    back_shown: false,
    reveal_time: 120
};
time = 0;
phase_transit_time = 0;
phase_transit_yoff = -obj_screen.actualHeight;
spotlight_radius = 0;
spotlight_radius_spd = 0;
obj_player.state = states.actor;
surf = surface_create(obj_screen.actualWidth, obj_screen.actualHeight);
surfs = 
{
    left: surface_create(412, obj_screen.actualHeight),
    right: surface_create(412, obj_screen.actualHeight)
};
boss_hp_sprite = spr_bossfight_pepperhp;
phase = 1;
registered_hit = false;
dead_hat_spawn = undefined;
