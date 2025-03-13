function scr_shell_openconsole()
{
    global.shellactivate = true;
}

function scr_shell_closeconsole()
{
    global.shellactivate = false;
}

function scr_fartcommand(argument0 = "BALLS")
{
    switch (argument0)
    {
        case "fart":
        case "poop":
        case "crap":
        case "fard":
        case "shart":
        case "shit":
        case "brap":
            return true;
            break;
    }
}

function scr_shell_roomstart()
{
    toggle_collision_function();
}
