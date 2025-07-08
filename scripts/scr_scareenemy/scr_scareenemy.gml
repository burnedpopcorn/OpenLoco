function scr_scareenemy()
{
    if ((obj_player1.x > (x - 400) && obj_player1.x < (x + 400)) && (y <= (obj_player1.y + 60) && y >= (obj_player1.y - 60)))
    {
        if (state != states.normal && state != states.hit && state != states.capefall && (obj_player1.state == states.mach3 || obj_player1.state == states.lawnmower))
        {
            if (irandom(100) <= 10)
                fmod_studio_event_oneshot_3d("event:/sfx/enemy/scream");
            
            state = states.normal;
            sprite_index = scaredspr;
            
            if (x != obj_player1.x)
                image_xscale = -sign(x - obj_player1.x);
            
            scaredbuffer = 100;
            
            if (grounded && object_index != obj_zombiewater)
                vsp = -3;
        }
    }
}
