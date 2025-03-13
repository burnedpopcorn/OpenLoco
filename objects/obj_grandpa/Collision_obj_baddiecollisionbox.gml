with (other.id)
{
    if (instance_exists(baddieID) && baddieID != other.id)
    {
        if ((baddieID.state == states.capefall && baddieID.thrown == 1) || obj_player.state == states.superslam)
        {
            instance_destroy();
            instance_destroy(baddieID);
            instance_destroy(other.id);
        }
    }
}
