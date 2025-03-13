image_xscale = scale;
image_yscale = scale;

if (scale < 7)
    image_angle = Approach(image_angle, angleoption, 3.5);

scale = Approach(scale, 7, 0.4);
X = Approach(X, 0, 2);
YY = Approach(YY, 0, 2);

if (scale == 7 && shake == 0)
{
    X = 35;
    YY = 35;
    shake = 1;
}

preY += Y;
y = preY + random_range(-YY, YY);
x = preX + random_range(-X, X);

if (down)
    Y = Approach(Y, 15, 0.7);
