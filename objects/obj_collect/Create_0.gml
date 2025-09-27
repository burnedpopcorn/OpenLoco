image_speed = 0.35;
global.collected = 0;
global.collectsound = 0;

if (obj_player.character == "S")
    sprite_index = spr_snickcollectible1;

depth = 11;
gotowardsplayer = 0;
movespeed = 5;
colorpalette = irandom_range(0, 3);
var spr_pair = choose([spr_sausagecollect, spr_coincolorpalette], [spr_shroomcollect, spr_coincolorpalette], [spr_cheesecollect, spr_fishcolorpalette], [spr_tomatocollect, spr_sposcolorpalette], [spr_pineapplecollect, spr_starcolorpalette]);
sprite_index = spr_pair[0];
colorpalettesprite = spr_pair[1];

if (global.palettesaveroom[? id] == undefined)
    global.palettesaveroom[? id] = colorpalette;
else
    colorpalette = global.palettesaveroom[? id];
