if (scr_3dcheck())
    exit;

if (marxstunned)
{
    var _angle = marxangle;
    var add = 72;
    var i = 0;
    var _partspr = spr_marx_leftwingNEW;
    draw_set_alpha(marxalphatarget);
    
    repeat (5)
    {
        i++;
        
        if (i == 1)
            _partspr = spr_marx_leftwingNEW;
        
        if (i == 2)
            _partspr = spr_marx_leftshoeNEW;
        
        if (i == 3)
            _partspr = spr_marx_bowtieNEW;
        
        if (i == 4)
            _partspr = spr_marx_rightshoeNEW;
        
        if (i == 5)
            _partspr = spr_marx_rightwingNEW;
        
        _angle += add;
        var targ_x = obj_player1.x + lengthdir_x(marxdist, _angle);
        var targ_y = obj_player1.y + lengthdir_y(marxdist, _angle);
        
        if (i == 1)
        {
            leftwingsx = targ_x;
            leftwingsy = targ_y;
        }
        
        if (i == 2)
        {
            rightwingsx = targ_x;
            rightwingsy = targ_y;
        }
        
        if (i == 3)
        {
            rightshoex = targ_x;
            rightshoey = targ_y;
        }
        
        if (i == 4)
        {
            leftshoex = targ_x;
            leftshoey = targ_y;
        }
        
        draw_sprite(_partspr, 0, targ_x, targ_y);
    }
    
    draw_set_alpha(1);
}
