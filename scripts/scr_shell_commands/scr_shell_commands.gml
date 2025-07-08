for (var i = 0; room_exists(i); i++)
    global.roomlist[i] = room_get_name(i);

global.soundlist = [];

function sh_reset(argument0)
{
    game_restart();
}

function meta_reset()
{
    return 
    {
        description: "Resets game",
        arguments: [],
        suggestions: [],
        argumentDescriptions: ["Resets game"]
    };
}

function sh_setcombo(argument0)
{
    var arg0 = argument0[1];
    global.combotime = 60;
    global.combo = arg0;
    obj_player1.supercharge = arg0;
}

function meta_setcombo()
{
    return 
    {
        description: "Sets your combo to the number inputted",
        arguments: ["<Combo>"],
        suggestions: [],
        argumentDescriptions: ["Combo"]
    };
}

function sh_hidehud()
{
    if (global.hidehud)
        global.hidehud = false;
    else
        global.hidehud = true;
}

function meta_hidehud()
{
    return 
    {
        description: "Hides the HUD"
    };
}

function sh_setcharacter(argument0)
{
    var arg0 = string(argument0[1]);
    
    with (obj_player1)
        character = arg0;
}

function meta_setcharacter()
{
    return 
    {
        description: "Sets your main character",
        arguments: ["<Name>"],
        suggestions: [],
        argumentDescriptions: ["Name"]
    };
}

function sh_setheat()
{
    global.heattime = 60;
    global.style += (2 + global.combo);
}

function meta_setheat()
{
    return 
    {
        description: "Sets your heat",
        arguments: [],
        suggestions: [],
        argumentDescriptions: []
    };
}

function sh_toggle_collisions(argument0)
{
    var arg1 = argument0[1];
    
    switch (arg1)
    {
        case "true":
        case "1":
            arg1 = true;
            break;
        
        case "false":
        case "0":
            arg1 = false;
            break;
        
        default:
            arg1 = !global.showcollisions;
            break;
    }
    
    global.showcollisions = arg1;
    toggle_collision_function();
}

function meta_toggle_collisions()
{
    return 
    {
        description: "toggles collision object visibility",
        arguments: ["<bool>"],
        suggestions: [["true", "false"]],
        argumentDescriptions: ["toggles visibility"]
    };
}

function toggle_collision_function()
{
    if (!variable_global_exists("showcollisionarray"))
    {
        i = 0;
        global.showcollisionarray[i++] = obj_solid;
        global.showcollisionarray[i++] = obj_slope;
        global.showcollisionarray[i++] = obj_platform;
        global.showcollisionarray[i++] = obj_slopePlatform;
        global.showcollisionarray[i++] = obj_slopePlatformskateboard;
        global.showcollisionarray[i++] = obj_sidePlatform;
        global.showcollisionarray[i++] = obj_secretblock;
        global.showcollisionarray[i++] = obj_secretbigblock;
        global.showcollisionarray[i++] = obj_secretmetalblock;
        global.showcollisionarray[i++] = obj_doorA;
        global.showcollisionarray[i++] = obj_doorB;
        global.showcollisionarray[i++] = obj_doorC;
        global.showcollisionarray[i++] = obj_doorD;
        global.showcollisionarray[i++] = obj_doorE;
        global.showcollisionarray[i++] = obj_ladder;
    }
    
    var array = global.showcollisionarray;
    var length = array_length(array);
    
    for (var i = length - 1; i >= 0; i--;)
    {
        with (array[i])
        {
            if (object_index == array[i])
            {
                visible = global.showcollisions;
                image_alpha = 1;
            }
        }
    }
}

function sh_danikyo()
{
    global.danikyo = !global.danikyo;
}

function meta_danikyo()
{
    return 
    {
        description: "danikyo",
        arguments: [],
        suggestions: [],
        argumentDescriptions: []
    };
}

function sh_fastrank()
{
    global.lap = 1;
    global.laps++;
    global.secretfound = 3;
}

function meta_fastrank()
{
    return 
    {
        description: "fast L rank",
        arguments: [],
        suggestions: [],
        argumentDescriptions: []
    };
}

function sh_smoothcam()
{
    global.smoothcam = !global.smoothcam;
}

function meta_smoothcam()
{
    return 
    {
        description: "makes camera smooth",
        arguments: [],
        suggestions: [],
        argumentDescriptions: []
    };
}

function sh_anglerotation()
{
    global.anglerotation = !global.anglerotation;
}

function meta_anglerotation()
{
    return 
    {
        description: "makes player change angle on slopes",
        arguments: [],
        suggestions: [],
        argumentDescriptions: []
    };
}

function sh_show_message(argument0)
{
    var arg0 = string(argument0[1]);
    
    with (instance_create(0, 0, obj_transformationtext))
        message = arg0;
}

function meta_show_message()
{
    return 
    {
        description: "show a message",
        arguments: ["<message>"],
        suggestions: [],
        argumentDescriptions: ["shows message wanted"]
    };
}

function sh_escape(argument0)
{
    var arg0 = string(argument0[1]);
    var arg1 = argument0[2];
    var arg2 = argument0[3];
    var arg3 = argument0[4];
    
    switch (arg0)
    {
        case "true":
        case "1":
            arg0 = true;
            break;
        
        case "false":
        case "0":
            arg0 = false;
            break;
        
        default:
            arg0 = !global.panic;
            break;
    }
    
    switch (arg3)
    {
        case "true":
        case "1":
            arg3 = true;
            break;
        
        case "false":
        case "0":
            arg3 = false;
            break;
        
        default:
            arg3 = !obj_music.escapetheme;
            break;
    }
    
    global.panic = 0;
    obj_music.escapetheme = arg3;
    global.panic = arg0;
    global.minutes = real(string_digits(arg1));
    global.seconds = real(string_digits(arg2));
    global.fill = ((global.minutes * 60) + global.seconds) * 60;
    
    with (obj_tv)
        chunkmax = global.fill;
    
    with (obj_chunktimer)
        fillmax = global.fill;
    
    with (obj_escapecollect)
        image_alpha = 1;
    
    with (obj_escapecollectbig)
        image_alpha = 1;
    
    global.wave = 0;
    global.maxwave = ((global.minutes * 60) + global.seconds) * 60;
    obj_camera.alarm[1] = 60;
}

function meta_escape()
{
    return 
    {
        description: "activates escape, sets escape time and decides if escape music plays",
        arguments: ["<bool>", "<min>", "<sec>", "<theme>"],
        suggestions: [["true", "false"], [], [], ["true", "false"]],
        argumentDescriptions: ["activate/deactivate escape", "set minutes", "set seconds", "activate/deactivate escape theme"]
    };
}

function sh_sound_play(argument0)
{
    return "UNFUNCTIONAL";
}

function meta_sound_play()
{
    return 
    {
        description: "Plays a sound",
        arguments: ["<event path>", "<loop>", "<pitch>"],
        suggestions: [global.soundlist, ["true", "false"]],
        argumentDescriptions: ["sound you want to play", "sound loops forever", "sets sound/music speed"]
    };
}

function sh_sound_stop(argument0)
{
    var arg0 = asset_get_index(argument0[1]);
    
    if (asset_get_type(argument0[1]) != 2)
        return "Can't find sound " + string(argument0[1]);
    
    if (asset_get_type(argument0[1]) == 2)
        audio_stop_sound(arg0);
}

function meta_sound_stop()
{
    return 
    {
        description: "stops a sound",
        arguments: ["<sound>"],
        suggestions: [global.soundlist],
        argumentDescriptions: ["sound you want to play"]
    };
}

function sh_toggle_debugmode(argument0)
{
    var arg1 = argument0[1];
    
    switch (arg1)
    {
        case "true":
        case "1":
            arg1 = true;
            break;
        
        case "false":
        case "0":
            arg1 = false;
            break;
        
        default:
            arg1 = !global.debugmode;
            break;
    }
    
    global.debugmode = arg1;
    
    if (!instance_exists(obj_debug))
        instance_create(0, 0, obj_debug);
    
    with (obj_debug)
        showdetails = true;
}

function meta_toggle_debugmode()
{
    return 
    {
        description: "toggles debugmode",
        arguments: ["<bool>"],
        suggestions: [["true", "false"]],
        argumentDescriptions: ["toggles debugmode"]
    };
}

function sh_room_goto(argument0)
{
    var arg1 = asset_get_index(argument0[1]);
    var arg2 = argument0[2];
    
    if (asset_get_type(argument0[1]) != 3)
        return "Can't find room " + string(argument0[1]);
    
    if (asset_get_type(argument0[1]) == 3)
    {
        obj_player1.targetRoom = arg1;
        obj_player2.targetRoom = arg1;
        obj_player1.targetDoor = arg2;
        obj_player2.targetDoor = arg2;
        instance_create(0, 0, obj_fadeout);
    }
}

function meta_room_goto()
{
    return 
    {
        description: "allows you to go to another room",
        arguments: ["<room>", "<door>"],
        suggestions: [global.roomlist, ["N/A", "A", "B", "C", "D", "E"]],
        argumentDescriptions: ["sets targetRoom", "sets targetDoor"]
    };
}

function sh_instance_create(argument0)
{
    instance_create(argument0[1], argument0[2], asset_get_index(argument0[3]));
}

function meta_instance_create()
{
    return 
    {
        description: "create an object",
        arguments: ["<x>", "<y>", "<object>"],
        suggestions: [[], [], []],
        argumentDescriptions: ["the X coordinate to create the object at", "the Y coordinate to create the object at", "the object to create"]
    };
}

function sh_player_setstate(argument0)
{
    var arg1 = string(argument0[1]);
    var arg2 = argument0[2];
    
    switch (arg1)
    {
        case "player1":
        case "1":
            arg1 = obj_player1;
            break;
        
        case "player2":
        case "2":
            arg1 = obj_player2;
            break;
    }
    
    with (arg1)
        state = arg2;
}

function meta_player_setstate()
{
    return 
    {
        description: "changes state of player",
        arguments: ["<player>", "<state>"],
        suggestions: [["player1", "player2"], ["knight", "geno"]],
        argumentDescriptions: ["changes player to change character", "select the character to change into"]
    };
}

function sh_noclip(argument0)
{
    var arg1 = string(argument0[1]);
    
    switch (arg1)
    {
        case "player1":
        case "1":
            arg1 = obj_player1;
            break;
        
        case "player2":
        case "2":
            arg1 = obj_player2;
            break;
    }
    
    with (arg1)
        state = states.debugstate;
}

function meta_noclip()
{
    return 
    {
        description: "makes player noclip",
        arguments: ["<player>"],
        suggestions: [["player1", "player2"]],
        argumentDescriptions: ["changes player to change character", "select the character to change into"]
    };
}

function sh_player_collect(argument0)
{
    var arg1 = string(argument0[1]);
    global.collect = arg1;
}

function meta_player_collect()
{
    return 
    {
        description: "sets player collectibles",
        arguments: ["<player>"],
        suggestions: [],
        argumentDescriptions: ["sets the player collectibles"]
    };
}

function sh_boss_hit()
{
    with (obj_bosscontroller)
        hp.boss--;
}
