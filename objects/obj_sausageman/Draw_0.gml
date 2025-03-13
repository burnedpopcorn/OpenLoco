if (cigar == 1)
{
    pal_swap_set(105, 1, 0);
    draw_self();
    shader_reset();
}
else
{
    gpu_set_fog(flash, c_white, 1, 1);
    draw_self();
    gpu_set_fog(false, c_black, 0, 0);
}
