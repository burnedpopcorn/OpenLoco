function dograb()
{
    if (((key_slap2 || input_buffer_slap > 0) && !(shotgunAnim == 1 && key_up)) && !genomode)
    {
        input_buffer_slap = 0;
        breakdance_pressed = 0;
        suplexmove = 1;
        fmod_studio_event_instance_start(grabsnd);
        state = states.handstandjump;
        image_index = 0;
        sprite_index = get_charactersprite("spr_suplexdash");
        
        if (movespeed <= 8)
            movespeed = 8;
        
        particle_set_scale(5, xscale, 1);
        create_particle(x, y, 5, 0);
    }
}

// unused
function scr_do_geno_shit() { }

function do_groundpound()
{
    if ((key_down2 && !genomode) || state == states.tumble)
    {
        image_index = 0;
        state = states.freefall;
        sprite_index = get_charactersprite("spr_bodyslamstart");
        vsp = -6;
    }
}

function scr_doslidekick()
{
    grav = 0.5;
    machhitAnim = 0;
    vsp = -3;
    grounded = false;
    crouchslipbuffer = 25;
    sprite_index = get_charactersprite("spr_mach2jump");
    image_index = 0;
    
    if (abs(movespeed) < 12)
        movespeed = 12;
    
    state = states.slidekick;
}

function scr_dotaunt()
{
    if (!place_meeting(x, y, obj_secretportal) && !place_meeting(x, y, obj_secretportalstart) && (key_taunt2 || input_finisher_buffer > 0))
    {
        input_finisher_buffer = 0;
        
        if (state == states.lawnmower && cutscene == 0)
        {
            fmod_studio_event_instance_start(styledtauntsnd);
            flash = 1;
            styledtaunting = 1;
            obj_camera.zoom = 0.7;
            obj_camera.spdzooming = 0.1;
        }
        else if (supercharged && key_up)
            fmod_studio_event_instance_start(supertauntsnd);
        else
            fmod_studio_event_instance_start(tauntsnd);
        
        taunttimer = 20;
        tauntstoredmovespeed = movespeed;
        tauntstoredsprite = sprite_index;
        tauntstoredindex = image_index;
        tauntstoredstate = state;
        tauntstoredvsp = vsp;
        state = states.backbreaker;
        
        if (!styledtaunting)
        {
            if (supercharged && key_up)
            {
                image_index = 0;
                sprite_index = choose(get_charactersprite("spr_supertaunt1"), get_charactersprite("spr_supertaunt2"), get_charactersprite("spr_supertaunt3"), get_charactersprite("spr_supertaunt4"));
            }
            else
            {
                taunttimer = 20;
                sprite_index = get_charactersprite("spr_taunt");
                image_index = random_range(0, sprite_get_number(get_charactersprite("spr_taunt")) - 1);
            }
        }
        else
        {
            styledtaunts++;
            sprite_index = get_charactersprite("spr_mowertaunt");
            image_index = random_range(0, sprite_get_number(get_charactersprite("spr_mowertaunt")) - 1);
            room_speed = 30;
        }
        
        with (instance_create(x, y, obj_taunteffect))
        {
            player = other.id;
            image_speed = other.styledtaunting ? 0.65 : 0.35;
        }
    }
}

function taunt_resetvariables()
{
    tauntstoredmovespeed = noone;
    tauntstoredsprite = noone;
    tauntstoredindex = noone;
    tauntstoredstate = noone;
    tauntstoredvsp = noone;
}

function do_specialmoves(_attack = special_attack)
{
    switch (_attack)
    {
        case playerspecialmove.shoulderbash:
            sprite_index = get_charactersprite("spr_shoulderbashstart");
            image_index = 0;
            flash = 1;
            state = states.handstandjump;
            movespeed = 12;
            fmod_studio_event_instance_start(grabsnd);
            particle_set_scale(5, xscale, 1);
            create_particle(x, y, 5, 0);
            break;
        
        case playerspecialmove.kungfu:
            image_index = 0;
            sprite_index = get_charactersprite("spr_kungfu" + choose("1", "2", "3"));
            
            if (!grounded)
                sprite_index = get_charactersprite(concat("spr_kungfuair", choose("1", "2", "3"), "transition"));
            
            flash = 1;
            state = states.kungfu;
            
            if (movespeed < 10)
                movespeed = 10;
            
            fmod_studio_event_instance_start(grabsnd);
            break;
        
        case playerspecialmove.faceplant:
            image_index = 0;
            sprite_index = get_charactersprite("spr_faceplant");
            image_speed = 0.5;
            state = states.faceplant;
            
            if (!grounded)
                vsp = -4;
            
            if (movespeed < 12)
                movespeed = 12;
            
            with (instance_create(x, y, obj_crazyrunothereffect))
                image_xscale = other.xscale;
            
            break;
        
        default:
            if (instance_exists(obj_cappy))
                break;
            
            state = states.cappythrow;
            image_index = 0;
            image_speed = 0.6;
            
            if (key_down)
                sprite_index = get_charactersprite("spr_cappythrow_down");
            else if (key_up)
                sprite_index = get_charactersprite("spr_cappythrow_up");
            else
                sprite_index = get_charactersprite("spr_cappythrow");
            
            break;
    }
    
    return argument0;
}
