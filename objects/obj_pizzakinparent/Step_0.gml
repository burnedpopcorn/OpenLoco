visible = (room == rank_room || room == timesuproom) ? false : playerid.visible;
playerid = obj_player1.spotlight ? obj_player1 : obj_player2;

if (state != states.backbreaker)
{
    if (sprite_index == spr_intro && floor(image_index) == (image_number - 1))
        sprite_index = spr_idle;
    
    if (sprite_index != spr_intro)
    {
        image_alpha = playerid.image_alpha;
        sprite_index = (xprev != x) ? spr_run : spr_idle;
        depth = -6;
    }
    
    if (global.panic && !instance_exists(obj_ghostcollectibles))
    {
        if (sprite_index == spr_idle)
            sprite_index = spr_panic;
        else if (sprite_index == spr_run)
            sprite_index = spr_runpanic;
    }
    
    if (obj_player1.state == states.backbreaker)
    {
        instance_create(x, y, obj_tinytaunt);
        sprite_index = spr_taunt;
        image_index = irandom(sprite_get_number(spr_idle) - 1);
        state = states.backbreaker;
        lock = 1;
    }
}
else
{
    hsp = 0;
    vsp = 0;
    
    if (sprite_index != spr_intro)
    {
        var s = obj_player1.sprite_index;
        
        if (s == get_charactersprite("spr_supertaunt1", s) || s == get_charactersprite("spr_supertaunt2", s) || s == get_charactersprite("spr_supertaunt3", s) || s == get_charactersprite("spr_supertaunt4", s))
        {
            sprite_index = spr_intro;
            image_index = 0;
        }
    }
    
    if (obj_player1.state != states.backbreaker || (sprite_index == spr_intro && floor(image_index) == (image_number - 1)))
    {
        interp = 0;
        sprite_index = spr_idle;
        lock = 0;
        state = states.normal;
    }
}
