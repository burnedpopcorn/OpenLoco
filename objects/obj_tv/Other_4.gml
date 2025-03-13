if (instance_exists(obj_secretportal))
{
    with (obj_secretportal)
    {
        if (secret)
            other.fadebg = 2;
    }
}

if (room == Nhall_1)
{
    global.srank = 30000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == lawn_1)
{
    global.srank = 30000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}
