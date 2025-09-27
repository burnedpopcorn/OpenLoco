levels = [];

function add_level(argument0, argument1)
{
    array_push(levels, 
    {
        name: argument0,
        room: argument1
    });
}

add_level("CAFE", hub_cafe);
add_level("LOBBY", hub_lobby);
add_level("HALL", hub_hall);
add_level("LOCO TOWN", hub_locotown);
selected = 0;
xscale = 1.5;
yscale = 0.5;
t_xscale = 1;
t_yscale = 1;
active = false;
time = 0;
alpha = 0;
pid = noone;
