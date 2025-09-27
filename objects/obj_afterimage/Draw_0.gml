if (output_modifier != noone)
    output_modifier();

draw_self();

if (output_resetter != noone)
    output_resetter();

if (output_add != noone)
    output_add();
