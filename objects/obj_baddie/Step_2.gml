if (state == states.grabbed)
    scr_enemy_grabbed();

if (state == states.superslam)
    scr_enemy_lungeattack();

if (obj_player1.state != states.lungeattack && obj_player1.state != states.chainsaw && obj_player1.state != states.handstandjump && state != states.superslam && state != states.hit && lunged)
    lunged = 0;

if (state != states.grabbed && state != states.unknown126)
{
    scr_collision();
    
    if (yscale == -1)
        yscale = 1;
}

xscale = Approach(xscale, 1, 0.07);

if (yscale != -1)
    yscale = Approach(yscale, 1, 0.07);

if (invtime > 0)
    invtime--;

if (y > (room_height + 100))
    instance_destroy();

if (thrown && (x > (room_width + 100) || x < -100 || y < -100))
    instance_destroy();

if (state == states.actor)
    image_speed = 0.35 + (global.baddiespeed * 0.05);

if (obj_player1.baddiegrabbedID == id && state == states.grabbed)
    persistent = true;
else
    persistent = false;

switch (object_index)
{
    case obj_waddledee:
        if (floor(image_index) == (image_number - 1) && sprite_index == walkspr)
            instance_create(x - (image_xscale * 20), y + 43, obj_cloudeffect);
        
        break;
}

with (instance_nearest(x, y, obj_player))
{
    if (state == states.backbreaker)
    {
        other.stunned = 0;
        
        if (other.state != states.unknown126 && !other.provoked && other.bombreset > 0)
        {
            other.bombreset = 0;
            other.provoked = true;
        }
        
        other.scaredbuffer = 0;
    }
    else if (other.state != states.unknown126)
        other.provoked = false;
}

fmod_studio_event_instance_move(stun_snd);

if (!fmod_studio_event_instance_is_playing(stun_snd) && state == states.capefall)
    fmod_studio_event_instance_start(stun_snd);
else if (state != states.capefall)
    fmod_studio_event_instance_stop(stun_snd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
