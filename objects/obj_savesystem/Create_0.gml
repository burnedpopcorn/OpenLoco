depth = -400;

if (instance_number(object_index) > 1)
{
    instance_destroy();
    exit;
}

showicon = 0;
ini_str = "";
state = savestate.idle;
icon_index = 0;
icon_max = 3;
