switch (room)
{
    case hub_start:
        global.roommessage = langstr_get("HubstartRN");
        message = global.roommessage;
        showtext = 1;
        alarm[0] = 200;
        break;
    
    case hub_tutorial:
        global.roommessage = langstr_get("HubtutorialRN");
        message = global.roommessage;
        showtext = 1;
        alarm[0] = 200;
        break;
    
    case hub_afterstart:
        global.roommessage = langstr_get("Hub1RN");
        message = global.roommessage;
        showtext = 1;
        alarm[0] = 200;
        break;
    
    case hub_lobby:
        global.roommessage = langstr_get("Hub2RN");
        message = global.roommessage;
        showtext = 1;
        alarm[0] = 200;
        break;
    
    case hub_hall:
        global.roommessage = langstr_get("HubhallRN");
        message = global.roommessage;
        showtext = 1;
        alarm[0] = 200;
        break;
    
    case hub_locotown:
        global.roommessage = langstr_get("HublocotownRN");
        message = global.roommessage;
        showtext = 1;
        alarm[0] = 200;
        break;
    
    case hub_forestmaze:
        global.roommessage = langstr_get("HubforestmazeRN");
        message = global.roommessage;
        showtext = 1;
        alarm[0] = 200;
        break;
    
    case hub_3:
        global.roommessage = langstr_get("HubmiddleRN");
        message = global.roommessage;
        showtext = 1;
        alarm[0] = 200;
        break;
    
    case hub_magmamine:
        global.roommessage = langstr_get("HubmagmamineRN");
        message = global.roommessage;
        showtext = 1;
        alarm[0] = 200;
        break;
    
    default:
        break;
}
