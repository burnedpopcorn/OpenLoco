if (activated == 1)
    alpha = Approach(alpha, 1, 0.02);

if (activated == 0)
{
    alpha = Approach(alpha, 0, 0.02);
    
    if (alpha == 0 && ending)
    {
        instance_activate_all();
        instance_destroy();
    }
}
