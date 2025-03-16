if (other.bbox_left > bbox_left)
{
    with (instance_create(0, 0, obj_zombiearena))
    {
        state = zarena.start;
        instance_destroy(other);
        saveroom_add();
    }
}
