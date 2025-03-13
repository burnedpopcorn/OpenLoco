if (!ended)
{
    alpha = Approach(alpha, 1, 0.2);
}
else
{
    alpha = Approach(alpha, 0, 0.02);
    
    if (alpha == 0)
        instance_destroy();
}
