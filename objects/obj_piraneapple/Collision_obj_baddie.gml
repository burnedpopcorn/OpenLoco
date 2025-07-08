with (other.id)
{
    if ((other.state == states.capefall && other.thrown == 1) || (other.state == states.grabbed && obj_player.state == states.superslam))
        instance_destroy();
}
