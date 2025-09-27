var ev_type = async_load[? "event_type"];

if (ev_type == "DiscordReady")
{
    global.discord_initialized = true;
    ready = true;
    var _bigtext = string(global.combo) + "x Combo";
    np_setpresence_more(small_icon_name, _bigtext, false);
    np_setpresence(state_text, details, big_icon, small_icon);
    sprite_add(np_get_avatar_url(async_load[? "user_id"], async_load[? "avatar"]), 1, false, false, 0, 0);
    alarm[1] = 1;
}
