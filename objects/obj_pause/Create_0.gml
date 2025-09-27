options = [];
pause_music = noone;
stored_panic_state = 0;
pause_options_map = ds_map_create();
add_button("CONTINUE", function()
{
    instance_activate_all();
    instance_destroy(obj_pausescreen);
    scr_deactivate_escape();
    music_set_paused(false);
    fmod_studio_event_instance_kill(pause_music);
    pause = 0;
});
add_button("RESTART", function()
{
    if (global.leveltosave != noone)
    {
        music_set_paused(false);
        fmod_studio_event_instance_kill(pause_music);
        instance_destroy(obj_pausescreen);
        instance_activate_all();
        
        with (obj_fadeout)
            instance_destroy();
        
        with (obj_player)
        {
            targetDoor = (global.leveltosave == "tutorial") ? "E" : "A";
            hallway = false;
        }
        
        room = global.roomtorestart;
        scr_playerreset();
        pause = 0;
        obj_player1.state = states.comingoutdoor;
        obj_player1.sprite_index = get_charactersprite("spr_walkfront", obj_player1);
        obj_player1.image_index = 0;
        global.lowpassEffect.bypass = 1;
        restart_music();
    }
    else
    {
        fmod_studio_event_oneshot("event:/sfx/enemy/spitprojectile");
    }
});
add_button("OPTIONS", function()
{
    with (instance_create(x, y, obj_option))
        key_jump = false;
    
    cantmove = 1;
});
add_button("QUIT", function()
{
    var roomname = room_get_name(room);
    instance_destroy(obj_pausescreen);
    global.lowpassEffect.bypass = 1;
    global.key_inv = false;
    
    if (is_hub() || room == Titlescreen || room == credits || room == Scootertransition)
    {
        pause = 0;
        instance_activate_all();
        instance_destroy(obj_fadeout);
        room = Disclamer;
        
        with (obj_player1)
            character = "P";
        
        scr_playerreset();
        obj_player.state = states.titlescreen;
        obj_player.targetDoor = "A";
        global.coop = 0;
        music_set_paused(false);
        fmod_studio_event_instance_kill(pause_music);
    }
    else if (global.leveltosave != noone)
    {
        music_set_paused(false);
        fmod_studio_event_instance_kill(pause_music);
        
        if (!instance_exists(obj_exitbubble))
        {
            pause = 0;
            instance_activate_all();
            obj_player.visible = false;
            obj_player.state = states.actor;
            obj_player.failexit = true;
            obj_player.hsp = 0;
            obj_player1.image_speed = 0.35;
            obj_player1.image_index = 0;
            obj_player1.sprite_index = get_charactersprite("spr_bubblestart");
            instance_create(obj_player1.x, obj_player1.y, obj_exitbubble);
            instance_destroy(obj_fadeout);
        }
    }
    
    fmod_studio_event_instance_kill(pause_music);
});
pause_options_array = ["CONTINUE", "RESTART", "OPTIONS", "QUIT"];
pause = 0;
master_gain = 1;
windowsstate = 1;
windowsprevstate = 1;
var i = 0;
scaledsi = 1.5;
scaletext = 0;
alphapause = 0;
alphapausetile = 0;
color = #796797;
spr_player = spr_idle_damian;
peppino_sprite_number = sprite_get_number(spr_player);
peppino_index = 0;
selected = 0;
image_speed = 0;
shroomdone = 0;
cheesedone = 0;
tomatodone = 0;
sausagedone = 0;
pineappledone = 0;
opcionesdirect = 0;
cantmove = 0;
depth = -998;
draw_screen = 0;
lastcollect = -1;
toppin_sprite[0] = spr_pizzakinshroom;
toppin_sprite[1] = spr_pizzakincheese;
toppin_sprite[2] = spr_pizzakintomato;
toppin_sprite[3] = spr_pizzakinsausage;
toppin_sprite[4] = spr_pizzakinpineapple;
xkin[0] = 569;
xkin[1] = 619;
xkin[2] = 687;
xkin[3] = 756;
xkin[4] = 811;
ykin[0] = 187;
ykin[1] = 149;
ykin[2] = 103;
ykin[3] = 137;
ykin[4] = 187;

for (i = 0; i < array_length(toppin_sprite); i++)
{
    toppin_number[i] = sprite_get_number(toppin_sprite[i]);
    toppin_index[i] = 0;
    toppin_has[i] = 0;
}

dsipalette = randomize_palette(spr_dsipausepalette);
ini_open("saveData.ini");
global.language = ini_read_string("Option", "language", "eng");
global.languagemap = ds_map_create();
reload_langfile();
ini_close();
