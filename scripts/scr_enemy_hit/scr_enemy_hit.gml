function scr_enemy_hit()
{
    hitLag--;
    sprite_index = stunfallspr;
    
    if (hitLag <= 0)
    {
        var _player = noone;
        
        if (grabbedby == 1)
            _player = obj_player1;
        else
            _player = obj_player2;
        
        if ((obj_player1.tauntstoredstate == 2 || obj_player1.tauntstoredstate == states.mach2 || obj_player1.state == states.tumble || obj_player1.state == states.mach2) || ((obj_player1.state == states.mach3 || obj_player1.tauntstoredstate == states.mach3) && (elite && elitehit > 0)))
            thrown = 0;
        else
            thrown = 1;
        
        vsp = hitvsp;
        hsp = hithsp;
        
        if (lunge_throw)
        {
            thrown = 1;
            linethrown = 1;
            lunge_throw = 0;
        }
        
        global.hit += 1;
        
        if (other.object_index == obj_pizzaball)
            global.golfhit += 1;
        
        global.combotime = 60;
        alarm[1] = 5;
        var _hp = 0;
        
        if (((!elite && (hp <= _hp || mach3destroy)) || (elite && elitehit <= 0 && mach3destroy && !lunged)) && (object_get_parent(object_index) != obj_null && object_get_parent(object_index) != par_boss) && destroyable)
        {
            instance_destroy();
            instance_create(x, y, obj_genericpoofeffect);
        }
        
        stunned = 200;
        state = states.capefall;
    }
}
