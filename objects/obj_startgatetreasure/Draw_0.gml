treasureanim += 0.35;
draw_self();

if (found)
    draw_sprite(treasure_spr, treasureanim, x, (y - sprite_height) + Wave(5, 5, 1, 0));
