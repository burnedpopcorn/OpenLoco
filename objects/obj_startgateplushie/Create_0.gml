image_speed = 0.35;
mask_index = spr_pizzakinmask;
depth = 15;
gateid = noone;
move_duration = irandom_range(30, 90);
move_cooldown = irandom_range(60, 120);
state = "idle";
storedstate = "idle";
idlespr = spr_pizzakincheese;
movespr = spr_pizzakincheese_run;
tauntspr = spr_toppincheese_taunt;
storedspr = spr_pizzakincheese;
scr_collision_init();
grav = 0.5;
stored_walkspeed = 0;

function plushietaunt()
{
    with (instance_create(x, y, obj_tinytaunt))
        depth = other.depth + 1;
    
    storedspr = sprite_index;
    stored_walkspeed = hsp;
    storedstate = state;
    hsp = 0;
    vsp = 0;
    sprite_index = tauntspr;
    state = "taunt";
}
