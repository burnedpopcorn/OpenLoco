if (global.hidehud)
    exit;

spritereal = global.danikyo ? spr_danikyo : sprite_index;
yscale = upsidedown ? -1 : 1;

if (styledtaunting)
{
    draw_set_font(global.bigfont);
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_halign(fa_center);
    draw_text(x, y - 70, concat("X", (styledtaunts < 10) ? ("0" + string(styledtaunts)) : styledtaunts));
}

pal_swap_set(get_charactersprite("spr_palette"), paletteselect, 0);
draw_sprite_ext(spritereal, image_index, x, (yscale == 1) ? y : (y + 50), xscale * scale_xs, yscale * scale_ys, angle, image_blend, image_alpha);
shader_reset();

if (flash)
{
    gpu_set_fog(true, c_white, 1, 1);
    draw_sprite_ext(spritereal, image_index, x, (yscale == 1) ? y : (y + 50), xscale * scale_xs, yscale * scale_ys, angle, image_blend, image_alpha);
    gpu_set_fog(false, c_black, 0, 0);
}

if (genomode)
{
    var _timer = 0;
    _timer = (genotimer / genotimer_max) * 100;
    var _delay = 0;
    _delay = ((genodelay_max - genodelay) / genodelay_max) * 100;
    var beamcharge = 0;
    beamcharge = Approach(beamcharge, geno_beamcharges * 34, 3);
    draw_healthbar(x - 25, y - 50, x, y - 40, _delay, c_black, c_yellow, c_yellow, 0, true, true);
    draw_healthbar(x - 25, y - 65, x + 25, y - 50, _timer, c_black, c_red, c_green, 0, true, true);
    draw_healthbar(x - 25, y - 85, x + 15, y - 67, beamcharge, c_black, c_yellow, c_red, 0, true, true);
}

if (character == "T")
    draw_circle_color(x, y, 120, c_white, c_white, true);
