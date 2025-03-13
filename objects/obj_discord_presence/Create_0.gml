ready = false;
location_map = ds_map_create();
state_text = "Score: 0";
small_icon_name = "";
small_icon = -4;
big_icon = "rpc_base";
details = "???";
target_icon = 
{
    main: "rpc_base",
    escape: "rpc_base"
};

function add_location(argument0, argument1, argument2, argument3)
{
    var _data = 
    {
        location: argument0,
        icon: argument1,
        escape_icon: argument2,
        text: argument3
    };
    
    if (!is_array(_data.location))
    {
        ds_map_add(location_map, _data.location, _data);
    }
    else
    {
        for (var i = 0; i < array_length(_data.location); i++)
            ds_map_add(location_map, _data.location[i], _data);
    }
}

alarm[0] = room_speed * 5;

if (!np_initdiscord("1238873135952953415", true, "0") || false)
{
    trace("NekoPresence init fail");
    ds_map_destroy(location_map);
    instance_destroy();
}

add_location([rm_devtest, rm_test], "rpc_base", "rpc_base", "Developering!");
add_location([hub_start, hub_boss1, hub_hallway, hub_3, hub_lobby, hub_afterstart, hub_afterhall, hub_tutorial, hub_hall], "rpc_hub", "rpc_hub", "Hub");
add_location(Nhall_1, "rpc_hall", "rpc_hall_panic", "Hallway Longway");
add_location([lawn_1, Nlocotown_8], "rpc_base", "rpc_base", "Crazii Lawn");
add_location([Nlocotown_9, Nlocotown_10, Nlocotown_14], "rpc_sewer", "rpc_sewer_panic", "Crazii Lawn");
add_location([Nlocotown_11, Nlocotown_13], "rpc_cementary", "rpc_cementary_panic", "Crazii Lawn");
