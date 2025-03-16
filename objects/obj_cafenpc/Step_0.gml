event_inherited();

if (obj_player1.state == 8 && obj_player1.key_up2)
{
    if (obj_player1.special_attack == playerspecialmove.cappy)
        obj_player1.special_attack = playerspecialmove.shoulderbash;
    else if (obj_player1.special_attack == playerspecialmove.shoulderbash)
        obj_player1.special_attack = playerspecialmove.faceplant;
    else if (obj_player1.special_attack == playerspecialmove.faceplant)
        obj_player1.special_attack = playerspecialmove.kungfu;
    else if (obj_player1.special_attack == playerspecialmove.kungfu)
        obj_player1.special_attack = playerspecialmove.cappy;
    
    var attack_name = get_attack_name(obj_player1.special_attack);
    
    with (obj_textbox)
        ttext[0] = other.ttext[0] + attack_name;
}

if (place_meeting(x, y, obj_player) && obj_player1.grounded && obj_player1.key_up2 && obj_player1.state == states.normal)
{
    if (!instance_exists(obj_textbox))
    {
        obj_player1.state = 8;
        var attack_name = get_attack_name(obj_player1.special_attack);
        
        with (instance_create(x, y, obj_textbox))
        {
            for (var i = 0; i < array_length(other.ttext); i++)
                ttext[i] = other.ttext[i] + attack_name;
            
            for (var i = 0; i < array_length(other.sound); i++)
                sound[i] = other.sound[i];
            
            characterportrait = other.characterportrait;
        }
        
        activatex = 1;
    }
}

if (sprbubblebox == spr_bubbleboxsmall && distance_to_object(obj_player) < 70)
{
    bubblebox_index = 0;
    sprbubblebox = spr_bubbleboxsizeup;
}

if (sprbubblebox == spr_bubblebox && distance_to_object(obj_player) > 70)
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

contenty = Wave(-2, 2, 3, 1);
bubblealpha = Approach(bubblealpha, instance_exists(obj_textbox) ? 0 : 1, 0.1);
contentalpha = Approach(contentalpha, (sprbubblebox == spr_squarebubblebox) ? 1 : 0, 0.1);

if (!instance_exists(obj_textbox) && activatex)
    activatex = 0;

if (activatex)
    obj_player1.x = Approach(obj_player1.x, x + (image_xscale * 60), 2.5);
