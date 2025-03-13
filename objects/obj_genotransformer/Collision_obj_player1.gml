with (other)
{
    if (state != states.geno_normal && state != states.geno_jump && state != states.geno_shoot)
    {
        state = states.geno_normal;
        sprite_index = get_charactersprite("spr_genoidle");
    }
}
