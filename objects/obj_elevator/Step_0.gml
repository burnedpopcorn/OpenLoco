scr_getinput();
alpha = lerp(alpha, active, 0.2);

if (!active)
    exit;

xscale = lerp(xscale, t_xscale, 0.2);
yscale = lerp(yscale, t_yscale, 0.2);
var move = key_down2 - key_up2;

if (move != 0)
    fmod_studio_event_oneshot("event:/sfx/player/step");

selected = clamp(selected + move, 0, array_length(levels) - 1);

if (key_jump)
{
    var level = levels[selected];
    
    if (level.room != room)
    {
        with (obj_player)
        {
            targetRoom = level.room;
            targetDoor = "ELEVATOR";
        }
        
        instance_create(x, y, obj_fadeout);
        t_xscale = 0;
        t_yscale = 2;
        fmod_studio_event_oneshot_3d("event:/sfx/misc/elevator");
    }
    else
    {
        fmod_studio_event_oneshot("event:/sfx/player/damage");
    }
}

if (key_slap2)
{
    fmod_studio_event_oneshot("event:/sfx/enemy/spitprojectile");
    
    with (pid)
    {
        vsp = -4;
        sprite_index = get_charactersprite("spr_idle", id);
        flash = true;
        state = states.normal;
    }
    
    active = false;
}
