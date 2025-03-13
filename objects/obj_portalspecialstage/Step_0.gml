portaly = Wave(-7, 7, 2, 5);
xscale = lerp(xscale, 1, 0.1);
yscale = lerp(yscale, 1, 0.1);
zscale = lerp(zscale, 1, 0.1);

if (going)
{
    xspd = Approach(xspd, 6.2, 0.05);
    yspd = Approach(yspd, 6.4, 0.05);
}

xoff += xspd;
yoff += yspd;
