function scr_enemy_lungeattack()
{
    hsp = 0;
    vsp = 0;
    x = obj_player1.x + (obj_player1.xscale * 30);
    y = obj_player1.y + 10;
    check_grabbed_solid(obj_player1);
    var _l = obj_player1.state != states.lungeattack && obj_player1.state != states.chainsaw;
    
    if (_l)
    {
        if (hitLag > 0)
            hitLag--;
        else
        {
            state = states.capefall;
            hsp = hithsp;
            vsp = hitvsp;
            stunned = 200;
            
            if (lungeHP <= 3)
            {
                trace("died during Lungeattack");
                instance_destroy();
                instance_create(x, y, obj_genericpoofeffect);
            }
        }
    }
}
