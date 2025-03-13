with (obj_player)
{
    if (state != states.hurt && (hurted == 0 && (cutscene == 0 && (state != states.bump && (state != states.mach3 && state != states.handstandjump)))))
        scr_hurtplayer(self);
}

if (obj_player.state == states.mach3 || obj_player.state == states.handstandjump)
    instance_destroy();
