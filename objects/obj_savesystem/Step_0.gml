if (state != savestate.idle)
{
    showicon = 1;
    icon_alpha = 3;
}
else if (showicon)
{
    icon_alpha = Approach(icon_alpha, 0, 0.05);
    
    if (icon_alpha <= 0)
        showicon = 0;
}

if (showicon)
{
    icon_index += 0.35;
    
    if (icon_index > (icon_max - 1))
    {
        var t = frac(icon_index);
        icon_index = t;
    }
}
