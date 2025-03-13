if (global.panic && flash == 0 && sprite_index == spr_normal)
{
    flash = 1;
    alarm[0] = 5;
}

if (!global.panic)
    sprite_index = activatex ? spr_blockertalk : spr_normal;

if (place_meeting(x, y, obj_player1) && (sprite_index == spr_blocker || sprite_index == spr_blockertalk) && obj_player1.grounded && obj_player1.key_up2 && obj_player1.state == states.normal)
{
    if (!instance_exists(obj_textbox))
    {
        obj_player1.state = 8;
        
        with (instance_create(x, y, obj_textbox))
        {
            for (var i = 0; i < array_length(other.ttext); i++)
                ttext[i] = other.ttext[i];
            
            for (var i = 0; i < array_length(other.sound); i++)
                sound[i] = other.sound[i];
            
            characterportrait = other.characterportrait;
        }
        
        activatex = true;
    }
}

if (sprite_index == spr_blocker || sprite_index == spr_blockertalk)
{
    if (sprbubblebox == spr_bubbleboxsmall && distance_to_object(obj_player1) < 70)
    {
        bubblebox_index = 0;
        sprbubblebox = spr_bubbleboxsizeup;
    }
    
    if (sprbubblebox == spr_bubblebox && distance_to_object(obj_player1) > 70)
    {
        bubblebox_index = 0;
        sprbubblebox = spr_bubbleboxsizedown;
    }
    
    if (sprbubblebox == spr_bubblebox && place_meeting(x, y, obj_player1))
    {
        bubblebox_index = 0;
        sprbubblebox = spr_bubbleboxtotextbox;
    }
    
    if (sprbubblebox == spr_squarebubblebox && !place_meeting(x, y, obj_player1))
    {
        bubblebox_index = 0;
        sprbubblebox = spr_textboxtobubblebox;
    }
    
    bubblebox_index += 0.25;
    
    if (bubblebox_index > (sprite_get_number(sprbubblebox) - 1))
    {
        if (sprbubblebox == spr_bubbleboxsizeup)
            sprbubblebox = spr_bubblebox;
        
        if (sprbubblebox == spr_bubbleboxsizedown)
            sprbubblebox = spr_bubbleboxsmall;
        
        if (sprbubblebox == spr_bubbleboxtotextbox)
            sprbubblebox = spr_squarebubblebox;
        
        if (sprbubblebox == spr_textboxtobubblebox)
            sprbubblebox = spr_bubblebox;
        
        bubblebox_index = frac(bubblebox_index);
    }
}

contenty = Wave(-2, 2, 3, 1);
bubblealpha = Approach(bubblealpha, instance_exists(obj_textbox) ? 0 : 1, 0.1);
contentalpha = Approach(contentalpha, (sprbubblebox == spr_squarebubblebox) ? 1 : 0, 0.1);

if (!instance_exists(obj_textbox) && activatex)
    activatex = false;

if (activatex)
    obj_player1.x = Approach(obj_player1.x, x + (image_xscale * 60), 2.5);
