if (marxseconds <= 0)
{
    marxstunned = false;
    
    if (!instance_exists(obj_marx))
    {
        with (instance_create(obj_player1.x, obj_player1.y, obj_marx))
        {
            leftshoex = other.leftshoex;
            leftshoey = other.leftshoey;
            leftwingx = other.leftwingx;
            leftwingy = other.leftwingy;
            rightshoex = other.rightshoex;
            rightshoey = other.rightshoey;
            rightwingx = other.rightwingx;
            rightwingy = other.rightwingy;
        }
    }
}
else
{
    marxseconds--;
    alarm[5] = 60;
}
