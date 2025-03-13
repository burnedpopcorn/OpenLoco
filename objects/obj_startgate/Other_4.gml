ini_open_from_string(obj_savesystem.ini_str);
rank = ini_read_string("Ranks", string(level), 0);
highscore = ini_read_real("Highscore", string(level), 0);
laps = ini_read_string("Laps", string(level), 0);
secret_count = ini_read_string("Secret", string(level), 0);
toppin[0] = ini_read_real("Toppin", string(level) + "1", 0);
toppin[1] = ini_read_real("Toppin", string(level) + "2", 0);
toppin[2] = ini_read_real("Toppin", string(level) + "3", 0);
toppin[3] = ini_read_real("Toppin", string(level) + "4", 0);
toppin[4] = ini_read_real("Toppin", string(level) + "5", 0);
treasure = ini_read_real("Treasure", string(level), 0);

if (level != "tutorial")
    global.pointstotal += ini_read_real("Highscore", string(level), 0);

switch (rank)
{
    case "l":
    case "p":
        rank_index = 5;
        break;
    
    case "s":
        rank_index = 4;
        break;
    
    case "a":
        rank_index = 3;
        break;
    
    case "b":
        rank_index = 2;
        break;
    
    case "c":
        rank_index = 1;
        break;
    
    case "d":
        rank_index = 0;
}

ini_close();
eggsprite[0] = (secret_count >= 1) ? spr_gateegg_opened : spr_gateegg_unopened;
eggsprite[1] = (secret_count >= 2) ? spr_gateegg_opened : spr_gateegg_unopened;
eggsprite[2] = (secret_count >= 3) ? spr_gateegg_opened : spr_gateegg_unopened;

if (level != "tutorial")
{
    for (var n = 0; n < array_length(durationspeed); n++)
    {
        with (instance_create(x, y, obj_eggate))
        {
            gateid = other.id;
            depthplus = other.depthegg[n];
            durationspeed = other.durationspeed[n];
            durationspeedy = other.durationspeedy[n];
            eggsprite = other.eggsprite[n];
        }
    }
    
    for (var i = 0; i < array_length(toppin); i++)
    {
        if (toppin[i])
        {
            with (instance_create(x + irandom_range(-30, obj_bangeffect), (y + (sprite_height / 2)) - 50, obj_startgateplushie))
            {
                gateid = other.id;
                idlespr = other.toppinsprite.idle[i];
                movespr = other.toppinsprite.run[i];
                tauntspr = other.toppinsprite.taunt[i];
                moving = choose(true, false);
            }
        }
    }
}
