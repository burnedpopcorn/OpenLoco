if (other.object_index == obj_zombie)
{
    other.hp -= 0.25;
    other.flash = 1;
    instance_destroy();
    
    if (other.hp <= 0)
        instance_destroy(other);
}
