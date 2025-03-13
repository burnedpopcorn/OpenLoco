instance_create(x, y, obj_genericpoofeffect);

repeat (2)
{
    with (create_debris(x, y, spr_secretportal_debris))
    {
        vsp = random_range(-2, -4);
        hsp = random_range(-4, 4);
        palette_spr = spr_eggpalette;
        palette = other.paletteselect;
    }
}
