if (invframes == 0)
{
    if (state != states.grabbed && (obj_player.state != 15 && obj_player.state != states.bump))
    {
        with (obj_player)
        {
            if (other.state == states.capefall && state == states.handstandjump)
            {
                movespeed = 0;
                image_index = 0;
                sprite_index = spr_haulingstart;
                state = 46;
                other.state = states.grabbed;
                other.grabbedby = 1;
            }
            
            if (y > other.y && (other.vsp > 1 && (other.grounded == 0 && other.state == 95)))
                other.caughtplayer = 1;
            
            if (y < other.y && (attacking == 0 && (state == states.jump && (vsp > 0 && sprite_index != spr_player_stompprep))))
            {
                if (other.helmet == 0)
                {
                    other.stunned = 200;
                    other.vsp = -5;
                    other.hsp = -other.image_xscale * 3;
                    other.state = states.capefall;
                    other.image_index = 0;
                }
                else
                {
                    instance_create(x, y + 50, obj_bumpeffect);
                }
                
                fmod_studio_event_oneshot_3d("event:/sfx/enemy/stomped");
                instance_create(x, y + 50, obj_stompeffect);
                image_index = 0;
                stompAnim = 1;
                sprite_index = spr_player_stompprep;
                
                if (key_jump2)
                    vsp = -14;
                else
                    vsp = -9;
            }
            
            if ((state == states.mach2 || (state == states.mach3 || state == states.grab)) && (other.grounded == 1 && other.state == states.capefall))
            {
                global.hit += 1;
                instance_create(other.x, other.y, obj_slapstar);
                instance_create(other.x, other.y, obj_baddiegibs);
                other.flash = 1;
                other.hp -= 1;
                
                if (other.hp <= 0)
                    thrown = 1;
                
                instance_create(x, y, obj_bumpeffect);
                other.vsp = -10;
                other.hsp = xscale;
                other.image_index = 0;
                other.stunned = 200;
                other.state = states.capefall;
                machpunchAnim = 1;
                
                if (!grounded && (state != states.freefall && key_jump2))
                {
                    sprite_index = spr_player_mach2jump;
                    vsp = -11;
                }
            }
            
            if (!(y < other.y) && (state != states.bump && (state != states.hurt && (other.state != states.grabbed && other.state != states.capefall))))
            {
                instance_create(x, y, obj_bumpeffect);
                
                if (x != other.x)
                    xscale = -sign(x - other.x);
                
                hsp = -xscale * 10;
                vsp = -4;
                image_index = 0;
                state = states.bump;
            }
        }
    }
}
