var p = 0;

with (obj_player)
{
    if (targetDoor == "LAP")
    {
        p = 1;
        state = states.portal;
        vsp = 0;
        hsp = 0;
        x = other.x;
        y = other.y;
        roomstartx = x;
        roomstarty = y;
        visible = false;
        
        switch (global.laps)
        {
            case 3:
                create_transfotext("Enemies will last longer now...", texteffect.crazyshake);
                break;
            
            case 4:
                if (!instance_exists(obj_patripi))
                    instance_create(room_width / 2, -10, obj_patripi);
                
                create_transfotext("Patripi is coming...", texteffect.crazyshake);
                break;
            
            case 5:
                if (!instance_exists(obj_giantpoofeffect))
                    instance_create(0, 0, obj_giantpoofeffect);
                
                create_transfotext("The Heat has risen...", texteffect.crazyshake);
        }
    }
}

if (!p)
    instance_destroy();
else
    active = 1;
