if (other.image_index == 0)
{
    fmod_studio_event_oneshot("event:/sfx/player/damage");
    instance_create(x, y, obj_bangeffect);
    sprite_index = get_charactersprite("spr_machfreefall");
    drop = 1;
    vsp = -20;
    hsp = 8;
    other.image_index = 1;
}
