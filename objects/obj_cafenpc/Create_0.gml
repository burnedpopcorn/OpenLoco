spr_normal = spr_yoshiNCP;
spr_panic = spr_yoshiNCP;
contentindex = 0;
contentalpha = 0;
contenty = 0;
bubblealpha = 1;
image_speed = 0.35;
depth = -6;
sprite_index = spr_normal;
activatex = 0;
bubblebox_index = 0;
ttext[0] = "Hello, you can change the special attack by pressing up again.\nCurrent Attack : ";
sound[0] = noone;
characterportrait = spr_yoshiportrait;
flash = 0;
sprbubblebox = spr_bubbleboxsmall;

function get_attack_name(argument0)
{
    switch (argument0)
    {
        case playerspecialmove.kungfu:
            return "Kung Fu";
        
        case playerspecialmove.shoulderbash:
            return "Shoulder Bash";
        
        case playerspecialmove.faceplant:
            return "Faceplant";
        
        case playerspecialmove.cappy:
            return "Cappy";
        
        default:
            return "Undefined";
    }
}
