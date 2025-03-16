if (instance_exists(other.baddieID))
{
    with (other.id)
    {
        if (((baddieID.state == baddiestates.stun && (baddieID.hsp != 0 && baddieID.thrown == 1)) && other.state != baddiestates.stun) || (baddieID.state == baddiestates.grabbed && obj_player.state == states.superslam))
        {
            other.state = baddiestates.grabbed;
            instance_create(other.x, other.y, obj_slapstar);
            instance_create(other.x, other.y, obj_baddiegibs);
            other.flash = 1;
            global.hit += 1;
            instance_create(x, y, obj_bumpeffect);
            other.stunned = 200;
            other.vsp = -5;
            other.hsp = -other.image_xscale * 3;
        }
    }
}
