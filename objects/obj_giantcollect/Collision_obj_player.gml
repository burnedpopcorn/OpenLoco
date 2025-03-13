with (instance_create(x, y, obj_smallnumber))
    number = "1000";

if (other.object_index == obj_player1)
    global.collect += 1000;
else
    global.collectN += 1000;

var _x = x - 48;
var _y = y - 48;
var _xstart = _x;

for (var yy = 0; yy < 4; yy++)
{
    for (var xx = 0; xx < 4; xx++)
    {
        create_collect(_x, _y, choose(spr_shroomcollect, spr_cheesecollect, spr_tomatocollect, spr_sausagecollect, spr_pineapplecollect), 62.5);
        _x += 16;
    }
    
    _x = _xstart;
    _y += 16;
}

instance_destroy();
