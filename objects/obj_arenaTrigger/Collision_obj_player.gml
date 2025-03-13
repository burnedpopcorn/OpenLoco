if (other.bbox_left > bbox_left)
{
    with (instance_create(0, 0, obj_zombiearena))
    {
        state = UnknownEnum.Value_1;
        instance_destroy(other);
        saveroom_add();
    }
}
