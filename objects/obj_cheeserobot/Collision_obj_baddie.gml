with (other.id)
{
    if ((other.state == baddiestates.stun && other.thrown == 1) || (other.state == baddiestates.grabbed && obj_player.state == states.superslam))
        instance_destroy();
}
