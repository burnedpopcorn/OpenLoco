var roomname = room_get_name(room);

if (set == 0)
{
    switch (pizzakin)
    {
        case 1:
            depth = -6;
            followid = playerid;
            spr_idle = spr_pizzakinshroom;
            spr_run = spr_pizzakinshroom_run;
            global.pizzakin1 = id;
            set = 1;
            break;
        
        case 2:
            depth = -5;
            
            if (variable_global_exists("pizzakin1"))
                followid = global.pizzakin1;
            else
                followid = playerid;
            
            spr_idle = spr_pizzakincheese;
            spr_run = spr_pizzakincheese_run;
            global.pizzakin2 = id;
            set = 1;
            break;
        
        case 3:
            depth = -4;
            
            if (variable_global_exists("pizzakin2"))
                followid = global.pizzakin2;
            else if (variable_global_exists("pizzakin1"))
                followid = global.pizzakin1;
            else
                followid = playerid;
            
            spr_idle = spr_pizzakintomato;
            spr_run = spr_pizzakintomato_run;
            global.pizzakin3 = id;
            set = 1;
            break;
        
        case 4:
            depth = -3;
            
            if (variable_global_exists("pizzakin3"))
                followid = global.pizzakin3;
            else if (variable_global_exists("pizzakin2"))
                followid = global.pizzakin2;
            else if (variable_global_exists("pizzakin1"))
                followid = global.pizzakin1;
            else
                followid = playerid;
            
            spr_idle = spr_pizzakinsausage;
            spr_run = spr_pizzakinsausage_run;
            global.pizzakin4 = id;
            set = 1;
            break;
        
        case 5:
            depth = -2;
            
            if (variable_global_exists("pizzakin4"))
                followid = global.pizzakin4;
            else if (variable_global_exists("pizzakin3"))
                followid = global.pizzakin3;
            else if (variable_global_exists("pizzakin2"))
                followid = global.pizzakin2;
            else if (variable_global_exists("pizzakin1"))
                followid = global.pizzakin1;
            else
                followid = playerid;
            
            spr_idle = spr_pizzakinpineapple;
            spr_run = spr_pizzakinpineapple_run;
            global.pizzakin5 = id;
            set = 1;
            break;
        
        case 6:
            depth = -2;
            
            if (variable_global_exists("pizzakin5"))
                followid = global.pizzakin5;
            else if (variable_global_exists("pizzakin4"))
                followid = global.pizzakin4;
            else if (variable_global_exists("pizzakin3"))
                followid = global.pizzakin3;
            else if (variable_global_exists("pizzakin2"))
                followid = global.pizzakin2;
            else if (variable_global_exists("pizzakin1"))
                followid = global.pizzakin1;
            else
                followid = playerid;
            
            spr_idle = spr_noisebomb_idle;
            spr_run = spr_noisebomb_walk;
            global.pizzakin6 = id;
            set = 1;
            break;
        
        case 7:
            depth = -1;
            
            if (variable_global_exists("pizzakin6"))
                followid = global.pizzakin6;
            else if (variable_global_exists("pizzakin5"))
                followid = global.pizzakin5;
            else if (variable_global_exists("pizzakin4"))
                followid = global.pizzakin4;
            else if (variable_global_exists("pizzakin3"))
                followid = global.pizzakin3;
            else if (variable_global_exists("pizzakin2"))
                followid = global.pizzakin2;
            else if (variable_global_exists("pizzakin1"))
                followid = global.pizzakin1;
            else
                followid = playerid;
            
            spr_idle = spr_gerome_idle;
            spr_run = spr_gerome_run;
            global.pizzakin7 = id;
            set = 1;
            break;
    }
}

if (playerid.grounded == 1)
{
    if (space < 30 && dir == -1)
        space++;
    
    if (space > -30 && dir == 1)
        space--;
}
else if (space > 0)
{
    space--;
}
else if (space < 0)
{
    space++;
}

if (instance_exists(followid))
{
    ds_queue_enqueue(followQueue, followid.x + space);
    
    if (followid == obj_player1)
    {
        if (pizzakin != 6 && pizzakin != 7)
            ds_queue_enqueue(followQueue, followid.y + 2);
        else
            ds_queue_enqueue(followQueue, followid.y);
    }
    else if (pizzakin == 7 || pizzakin == 6)
    {
        ds_queue_enqueue(followQueue, followid.y - 2);
    }
    else
    {
        ds_queue_enqueue(followQueue, followid.y);
    }
    
    LAG_STEPS = 10;
    
    if (ds_queue_size(followQueue) > (LAG_STEPS * 2))
    {
        x = ds_queue_dequeue(followQueue);
        y = ds_queue_dequeue(followQueue);
    }
}

var prv_x_sign = -sign(xprevious - x);

if (prv_x_sign != 0)
    image_xscale = prv_x_sign;
else if (playerid.hsp == 0)
    image_xscale = playerid.xscale;

if (dir != playerid.xscale)
    dir = playerid.xscale;

if (image_xscale == 0)
    image_xscale = 1;

if (playerid.state != 53)
{
    if (x != xprevious || y != yprevious)
        sprite_index = spr_run;
    else
        sprite_index = spr_idle;
}
