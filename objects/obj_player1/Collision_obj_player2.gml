with (obj_player2)
{
    if (state == states.handstandjump && (other.hurted == 0 && (other.state != states.hurt && (other.state != states.knightpepslopes && (other.state != states.knightpep && (other.state != states.tumble && (other.state != states.fireass && (other.state != states.bombpep && (other.cutscene == 0 && (other.hurted == 0 && hurted == 0))))))))))
    {
        if (obj_player1.spotlight == 1)
        {
            obj_camera.shoving = 1;
            obj_camera.image_index = 0;
        }
        
        obj_player1.spotlight = 0;
        scr_changetoppings();
        movespeed = 0;
        image_index = 0;
        sprite_index = spr_haulingstart;
        baddiegrabbedID = other.id;
        state = states.grab;
        other.state = states.grabbed;
        obj_player1.depth = -6;
        obj_player2.depth = -7;
        
        if (global.collect > 100)
        {
            global.collectN += 100;
            global.collect -= 100;
            instance_create(x, y, obj_100);
        }
    }
    
    if (state == states.freefall && (other.hurted == 0 && (other.state != states.stunned && (other.state != states.hurt && hurted == 0))))
    {
        if (obj_player1.spotlight == 1)
        {
            obj_camera.shoving = 1;
            obj_camera.image_index = 0;
        }
        
        obj_player1.spotlight = 0;
        scr_changetoppings();
        obj_player1.depth = -6;
        obj_player2.depth = -7;
        obj_player1.state = states.stunned;
        obj_player1.sprite_index = get_charactersprite("spr_squished", obj_player1);
        obj_player1.image_index = 0;
        
        if (global.collect > 100)
        {
            global.collectN += 100;
            global.collect -= 100;
            instance_create(x, y, obj_100);
        }
    }
}
