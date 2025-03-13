options = [];
selected = 0;
activity_buffer = 15;
add_toggle("SMOOTH CAMEERA", global.smoothcam);
add_toggle("ANGLE ROTATION", global.anglerotation);
add_toggle("DANIKYO", global.danikyo);
add_toggle("MUTE SOUNDS WHEN UNFOCUSED", global.unfocus);
var pals = [];

for (var i = 0; i < sprite_get_width(spr_dsipausepalette); i++)
{
    var col = "UNDEFINED";
    
    switch (i)
    {
        case 0:
            col = "BLUE";
            break;
        
        case 1:
            col = "ORANGE";
            break;
        
        case 2:
            col = "YELLOW";
            break;
        
        case 3:
            col = "TUTORII GREEN";
            break;
        
        case 4:
            col = "RED";
            break;
        
        case 5:
            col = "TV PURPLE";
            break;
        
        case 6:
            col = "PINK";
            break;
        
        case 7:
            col = "DARK";
            break;
        
        case 8:
            col = "LIGHT";
            break;
    }
    
    array_push(pals, col);
}

add_select("DSI COLOR", pals, obj_pause.dsipalette);
depth = -539;
