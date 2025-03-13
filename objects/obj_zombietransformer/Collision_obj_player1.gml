if (other.state != states.zombie && other.state != states.zombiejump && other.state != states.debugstate)
{
    with (other)
    {
        state = states.zombie;
        sprite_index = get_charactersprite("spr_zombieidle");
        movespeed = 0;
    }
}
