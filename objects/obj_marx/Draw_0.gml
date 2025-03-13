draw_set_alpha(image_alpha);
var randomshake = random_range(7, -7);
var randomshake2 = random_range(7, -7);
var randomshake_ = random_range(7, -7);
var randomshake_2 = random_range(7, -7);
var randomshake__ = random_range(7, -7);
var randomshake__2 = random_range(7, -7);
randomshake = randomshake * (laserbar / 100);
randomshake2 = randomshake2 * (laserbar / 100);
randomshake_ = randomshake_ * (laserbar / 100);
randomshake_2 = randomshake_2 * (laserbar / 100);
randomshake__ = randomshake__ * (laserbar / 100);
randomshake__2 = randomshake__2 * (laserbar / 100);
var shake1 = (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1)) + (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1));
var shake2 = (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1)) + (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1));
var shake3 = (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1)) + (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1));
var shake4 = (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1)) + (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1));
var shake5 = (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1)) + (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1));
var shake6 = (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1)) + (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1));
var shake7 = (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1)) + (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1));
var shake8 = (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1)) + (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1));
var shake9 = (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1)) + (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1));
var shake10 = (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1)) + (choose(randomshake, randomshake2, randomshake_, randomshake_2, randomshake__, randomshake__2) * choose(1, -1));

if (!laser)
{
    shake1 = 0;
    shake2 = 0;
    shake3 = 0;
    shake4 = 0;
    shake5 = 0;
    shake6 = 0;
    shake7 = 0;
    shake8 = 0;
}

draw_set_alpha(image_alpha);
draw_sprite(spr_marx_leftshoeNEW, -1, leftshoex + shake1, leftshoey + shake2);
draw_sprite(spr_marx_rightshoeNEW, -1, rightshoex + shake1, rightshoey + shake2);
draw_sprite(spr_marx_bowtie, -1, tiex + shake3, tiey + shake4);
draw_sprite(spr_marx_leftwingNEW, -1, leftwingsx + shake7, leftwingsy + shake9);
draw_sprite(spr_marx_rightwingNEW, -1, rightwingsx + shake7, rightwingsy + shake9);
draw_sprite(spr_marx_hexagonleftNEW, -1, lefthexagonx + shake8, lefthexagony + shake10);
draw_sprite(spr_marx_hexagonrightNEW, -1, righthexagonx + shake8, righthexagony + shake10);
draw_set_alpha(image_alpha);
draw_sprite(sprite_index, image_index, x + shake5, y + shake6);
draw_set_alpha(1);

if (ballpower)
{
    draw_sprite(spr_marx_charged_lazer, -1, x - 10, y);
    draw_sprite_stretched(spr_marxbarfill, 0, x - 50, y - 100, (amountlaser / amountlasermax) * 142, 26);
    draw_sprite(spr_marxbar2, 0, x - 50, y - 100);
    draw_sprite(spr_tinyassmarxicouldsquishlikealittlebug, 0, (x - 50) + ((amountlaser / amountlasermax) * 142), y - 100);
}
