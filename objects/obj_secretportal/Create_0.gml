targetRoom = NoRoom;
active = 1;
trigger = 0;
touched = 0;
playerid = -4;
secret = 0;
depth = 3;
mask_index = spr_secretportal_idle;
paletteselect = floor(irandom(sprite_get_width(spr_eggpalette) - 1));

if (ds_map_find_value(global.palettesaveroom, id) == undefined)
    ds_map_set(global.palettesaveroom, id, paletteselect);
