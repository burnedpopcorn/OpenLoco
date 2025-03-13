angle += 1;
x = obj_player.x;
y = obj_player.y;

if (angle > 360)
    angle = 0;

if (angle < 0)
    angle = 360;

if (state == 1)
{
    if (coins <= coinmax)
    {
        coincountdown--;
        
        if (coincountdown <= 0)
        {
            coins++;
            coincountdown = coincountdownmax;
            fmod_studio_event_oneshot_3d("event:/sfx/enemy/spitprojectile", obj_player1.x, obj_player1.y);
            
            if (coins == coinmax)
                state = 2;
        }
    }
}

if (state == 2)
{
    countdown--;
    
    if (countdown <= 0)
    {
        coincountdown--;
        
        if (coincountdown <= 0)
        {
            coincountdown = coincountdownmax;
            coins--;
            fmod_studio_event_oneshot_3d("event:/sfx/misc/kashing", obj_player1.x, obj_player1.y);
            obj_tv.wallettimer = 30;
            global.levelcoins++;
            
            if (coins <= 0)
                instance_destroy();
        }
    }
}
