var range = sprite_width / 2;
create_debris((x + irandom_range(-range, range)) - 4, (y + sprite_height) - 2 - irandom_range(0, 15), spr_riseupdirt_debris);
alarm[0] = irandom(riseup_alarm);
