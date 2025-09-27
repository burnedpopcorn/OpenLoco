function scr_boss_grabbed()
{
    var playerid = (grabbedby == 1) ? obj_player1.id : obj_player2.id;
    
    with (playerid)
    {
        if (state != states.tackle || baddiegrabbedID != other)
        {
            if (other.elitehit <= 1)
                other.destroyable = 1;
            
            baddiegrabbedID = other.id;
            movespeed = 4;
            state = states.tackle;
            sprite_index = array_random(sprarr_kungfu);
            image_index = 0;
        }
    }
    
    image_xscale = -playerid.xscale;
    sprite_index = grabbedspr;
    state = states.grabbed;
    stunned = 200;
    thrown = 1;
    linethrown = 1;
    var f = 15;
    
    if (obj_player.tauntstoredstate == states.mach3)
        f = 25;
    
    if (abs(hithsp) > abs(hitvsp))
    {
        if (abs(hithsp) < f)
            hithsp = sign(hithsp) * f;
    }
    else if (abs(hitvsp) < f)
        hitvsp = sign(hitvsp) * f;
    
    vsp = hitvsp;
    hsp = hithsp;
}
