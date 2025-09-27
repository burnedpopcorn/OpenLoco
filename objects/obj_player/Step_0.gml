if (grounded && vsp > 0)
    coyote_time = 8;

if (vsp < 0)
    coyote_time = 0;

can_jump = (grounded && upsidedown ? (vsp < 0) : (vsp > 0)) || (coyote_time && upsidedown ? (vsp < 0) : (vsp > 0));

if (key_slap2)
    input_buffer_slap = 12;

if (key_special2)
    input_buffer_special = 12;

if (key_jump)
    input_buffer_jump2 = 12;

if (timeuntilhpback > 0)
    timeuntilhpback--;

switch (state)
{
    case states.normal:
        scr_player_normal();
        break;
    
    case states.grabbed:
        scr_player_grabbed();
        break;
    
    case states.finishingblow:
        scr_player_finishingblow();
        break;
    
    case states.tumble:
        scr_player_tumble();
        break;
    
    case states.titlescreen:
        scr_player_titlescreen();
        break;
    
    case states.ejected:
        scr_player_ejected();
        break;
    
    case states.firemouth:
        scr_player_firemouth();
        break;
    
    case states.fireass:
        scr_player_fireass();
        break;
    
    case states.tacklecharge:
        scr_player_tacklecharge();
        break;
    
    case states.zombie:
        scr_player_zombie();
        break;
    
    case states.climbwall:
        scr_player_climbwall();
        break;
    
    case states.portal:
        scr_player_portal();
        break;
    
    case states.chainsawbump:
        scr_player_chainsawbump();
        break;
    
    case states.handstandjump:
        scr_player_handstandjump();
        break;
    
    case states.gottreasure:
        scr_player_gottreasure();
        break;
    
    case states.meteorpep:
        scr_player_meteorpep();
        break;
    
    case states.grabbing:
        scr_player_grabbing();
        break;
    
    case states.chainsawpogo:
        scr_player_chainsawpogo();
        break;
    
    case states.shotgunjump:
        scr_player_shotgunjump();
        break;
    
    case states.stunned:
        scr_player_stunned();
        break;
    
    case states.highjump:
        scr_player_highjump();
        break;
    
    case states.chainsaw:
        scr_player_chainsaw();
        break;
    
    case states.facestomp:
        scr_player_facestomp();
        break;
    
    case states.timesup:
        scr_player_timesup();
        break;
    
    case states.machroll:
        scr_player_machroll();
        break;
    
    case states.shotgun:
        scr_player_shotgun();
        break;
    
    case states.machfreefall:
        scr_player_machfreefall();
        break;
    
    case states.throwin:
        scr_player_throw();
        break;
    
    case states.superslam:
        scr_player_superslam();
        break;
    
    case states.slam:
        scr_player_slam();
        break;
    
    case states.lawnmower:
        scr_player_lawnmower();
        break;
    
    case states.grind:
        scr_player_grind();
        break;
    
    case states.grab:
        scr_player_grab();
        break;
    
    case states.punch:
        scr_player_punch();
        break;
    
    case states.backkick:
        scr_player_backkick();
        break;
    
    case states.uppunch:
        scr_player_uppunch();
        break;
    
    case states.shoulder:
        scr_player_shoulder();
        break;
    
    case states.backbreaker:
        scr_player_backbreaker();
        break;
    
    case states.bossintro:
        scr_player_bossintro();
        break;
    
    case states.gameover:
        scr_player_gameover();
        break;
    
    case states.Sjumpland:
        scr_player_Sjumpland();
        break;
    
    case states.freefallprep:
        scr_player_freefallprep();
        break;
    
    case states.keyget:
        scr_player_keyget();
        break;
    
    case states.tackle:
        scr_player_tackle();
        break;
    
    case states.slipnslide:
        scr_player_slipnslide();
        break;
    
    case states.ladder:
        scr_player_ladder();
        break;
    
    case states.jump:
        scr_player_jump();
        break;
    
    case states.victory:
        scr_player_victory();
        break;
    
    case states.comingoutdoor:
        scr_player_comingoutdoor();
        break;
    
    case states.Sjump:
        scr_player_Sjump();
        break;
    
    case states.Sjumpprep:
        scr_player_Sjumpprep();
        break;
    
    case states.crouch:
        scr_player_crouch();
        break;
    
    case states.crouchjump:
        scr_player_crouchjump();
        break;
    
    case states.crouchslide:
        scr_player_crouchslide();
        break;
    
    case states.mach1:
        scr_player_mach1();
        break;
    
    case states.mach2:
        scr_player_mach2();
        break;
    
    case states.mach3:
        scr_player_mach3();
        break;
    
    case states.machslide:
        scr_player_machslide();
        break;
    
    case states.bump:
        scr_player_bump();
        break;
    
    case states.hurt:
        scr_player_hurt();
        break;
    
    case states.freefall:
        scr_player_freefall();
        break;
    
    case states.freefallland:
        scr_player_freefallland();
        break;
    
    case states.hang:
        scr_player_hang();
        break;
    
    case states.door:
        scr_player_door();
        break;
    
    case states.current:
        scr_player_current();
        break;
    
    case states.taxi:
        scr_player_taxi();
        break;
    
    case states.actor:
        scr_player_actor();
        break;
    
    case states.debugstate:
        scr_player_debugstate();
        break;
    
    case states.zombiejump:
        scr_player_zombiejump();
        break;
    
    case states.parrying:
        scr_player_parry();
        break;
    
    case states.faceplant:
        scr_player_faceplant();
        break;
    
    case states.gateeject:
        scr_player_gateeject();
        break;
    
    case states.bubble:
        scr_player_bubble();
        break;
    
    case states.zombieattack:
        scr_player_zombieattack();
        break;
    
    case states.lawnmowerslide:
        scr_player_lawnmowerslide();
        break;
    
    case states.slipbanana:
        scr_player_slipbanana();
        break;
    
    case states.lungeattack:
        scr_player_lungeattack();
        break;
    
    case states.kungfu:
        scr_player_kungfu();
        break;
    
    case states.genobeam:
        scr_player_genobeam();
        break;
    
    case states.slidekick:
        scr_player_slidekick();
        break;
    
    case states.cappythrow:
        scr_player_cappythrow();
        break;
    
    case states.cape:
        scr_player_cape();
        break;
    
    case states.capefall:
        scr_player_capefall();
        break;
    
    case states.geno_normal:
        scr_geno_normal();
        break;
    
    case states.geno_jump:
        scr_geno_jump();
        break;
    
    case states.geno_shoot:
        scr_geno_shoot();
        break;
}

if (grounded && (Doublejump && state != states.jump))
    Doublejump = false;

if (state != states.ladder)
    ladderx = x;

if (global.anglerotation || angle != 0)
    scr_angle_rotate();

if (state != states.backbreaker && styledtaunting == 1)
{
    styledtaunts = 0;
    styledtaunting = 0;
    room_speed = 60;
    obj_camera.zoom = 1;
    obj_camera.spdzooming = 0.3;
}

if (state != states.Sjump)
    sjumpvsp = -12;

if (superchargecombo_buffer > 0)
    superchargecombo_buffer--;

genotimer = Approach(genotimer, 0, 1);
genodelay = Approach(genodelay, 0, 1);

if (genotimer == 0 && genomode)
{
    genotimer_max = 0;
    genomode = false;
}

if ((genodelay == 0 && genodelay_max != 0) && !genomode)
    genodelay_max = 0;
else if (superchargecombo_buffer == 0)
{
    superchargecombo_buffer = -1;
    global.combotime = 4;
}

if (!instance_exists(superchargedeffectid) && supercharged)
{
    with (instance_create(x, y, obj_superchargeeffect))
    {
        playerid = other.id;
        other.superchargedeffectid = id;
    }
}

if (supercharge > 9 && state != states.backbreaker)
    supercharged = 1;

if (!place_meeting(x, y + 1, obj_grindrail))
{
    if (state == states.mach3 || state == states.mach2 || state == states.tumble)
        railmovespeed = Approach(railmovespeed, 0, 0.1);
    else
        railmovespeed = Approach(railmovespeed, 0, 0.5);
}

if (room == Realtitlescreen)
    state = states.titlescreen;

scr_playersounds();

if (global.coop == 0)
    fightball = 0;

if (state != states.mach3 && state != states.grabbed)
    fightball = 0;

if (state != states.grabbed && state != states.hurt)
    thrown = 0;

if (grounded && state != states.handstandjump)
    suplexmove = 0;

if (state != states.freefall)
    freefallsmash = 0;

if (global.playerhealth <= 0 && state != states.gameover)
{
    image_index = 0;
    sprite_index = get_charactersprite("spr_deathstart");
    state = states.gameover;
}

if (state == states.gameover && y > (room_height * 2))
{
    scr_playerreset();
    targetDoor = "C";
    room = hub_hall;
}

if (baddiegrabbedID == 0 && (state == states.grab || (state == states.superslam || state == states.tacklecharge)))
    state = states.normal;

if (!(state == states.grab || (state == states.chainsaw || (state == states.superslam || state == states.mach2))))
    baddiegrabbedID = 0;

if (grinding)
    state = states.grind;

if (anger == 0)
    angry = 0;

if (anger > 0)
{
    angry = 1;
    anger -= 1;
}

if (sprite_index == get_charactersprite("spr_winding") && state != states.normal)
    windingAnim = 0;

if (state != states.grab)
    swingdingbuffer = 0;

if (sprite_index == get_charactersprite("spr_idlevomit") && (image_index > 28 && image_index < 43))
    instance_create(x + random_range(-5, obj_25Dsolid), y + 46, obj_vomit);

if (sprite_index == get_charactersprite("spr_idlevomitblood") && (image_index > 28 && image_index < 43))
{
    with (instance_create(x + random_range(-5, obj_25Dsolid), y + 46, obj_vomit))
        sprite_index = spr_vomit2;
}

if (global.playerhealth == 1 && (!instance_exists(obj_sweat) && obj_player.state == states.normal))
    instance_create(x, y, obj_sweat);

if (angry == 1 && (!instance_exists(angryeffectid) && state == states.normal))
{
    with (instance_create(x, y, obj_angrycloud))
    {
        playerid = other.object_index;
        other.angryeffectid = id;
    }
}

if (global.combo != global.previouscombo)
{
    global.previouscombo = global.combo;
    
    if (global.combo > global.highest_combo)
        global.highest_combo = global.combo;
    
    if ((global.combo % 5) == 0 && global.combo != 0)
    {
        with (instance_create(x, y - 80, obj_combotitle))
        {
            fmod_studio_event_oneshot("event:/sfx/combo/comboup");
            title = floor(global.combo / 5);
            scale = 0;
        }
    }
}

if (object_index == obj_player1)
{
    if (global.combotime > 0 && global.combofreeze <= 0 && (state != states.keyget && state != states.victory && state != states.comingoutdoor && state != states.gottreasure && state != states.portal && state != states.actor && state != states.door) && !(instance_exists(obj_fadeout) || place_meeting(x, y, obj_secretportal) || place_meeting(x, y, obj_secretportalstart)))
        global.combotime -= 0.15;
    
    if (global.combofreeze > 0)
        global.combofreeze--;
    
    if (global.combotime <= 0 && global.combo != 0)
    {
        fmod_studio_event_oneshot("event:/sfx/combo/comboend");
        global.combotime = 0;
        global.combo = 0;
        global.previouscombo = 0;
        supercharge = 0;
        
        if (!global.combodrop)
            global.combodrop = 1;
    }
    
    if (global.heattime > 0)
        global.heattime -= 0.15;
    
    if (global.heattime <= 0 && global.style > -1 && global.stylelock == 0)
        global.style -= 0.05;
}

if (input_buffer_jump < 8)
    input_buffer_jump++;

if (coyote_time > 0)
    coyote_time--;

if (input_buffer_secondjump < 8)
    input_buffer_secondjump++;

if (input_buffer_highjump < 8)
    input_buffer_highjump++;

if (input_attack_buffer > 0)
    input_attack_buffer--;

if (input_finisher_buffer > 0)
    input_finisher_buffer--;

if (input_up_buffer > 0)
    input_up_buffer--;

if (input_down_buffer > 0)
    input_down_buffer--;

if (input_buffer_walljump > 0)
    input_buffer_walljump--;

if (input_buffer_slap > 0)
    input_buffer_slap--;

if (input_buffer_special > 0)
    input_buffer_special--;

if (input_buffer_jump2 > 0)
    input_buffer_jump2--;

if (grabclimbbuffer > 0)
    grabclimbbuffer--;

if (key_particles == 1)
    instance_create(random_range(x + 25, x - 25), random_range(y + 35, y - 25), obj_keyeffect);

if (inv_frames == 0 && hurted == 0)
    image_alpha = 1;

if (state == states.mach2 || (state == states.tacklecharge || (state == states.lawnmower || (state == states.knightpep || (state == 15 || (state == states.zombieattack || (state == states.knightpepslopes || (state == states.knightpepattack || (state == states.bombpep || (state == states.facestomp || (state == states.machfreefall || (state == states.facestomp || (state == states.machroll || (state == states.mach3 || (state == states.freefall || state == states.Sjump)))))))))))))))
    attacking = 1;
else
    attacking = 0;

if (state == states.throwin || ((state == states.punch && (sprite_index != get_charactersprite("spr_Sjumpcancelstart") && sprite_index != get_charactersprite("spr_Sjumpcancel") && sprite_index != get_charactersprite("spr_kungfujump") && sprite_index != get_charactersprite("spr_breakdanceuppercut") && sprite_index != get_charactersprite("spr_breakdanceuppercutend"))) || (state == states.backkick || (state == states.shoulder || state == states.uppunch))))
    grabbing = 1;
else
    grabbing = 0;

if (state == states.faceplant || state == states.slidekick || state == states.kungfu || sprite_index == get_charactersprite("spr_swingding") || state == states.mach3 || state == states.machslide || ((state == states.punch && (sprite_index == get_charactersprite("spr_Sjumpcancelstart") || sprite_index == get_charactersprite("spr_Sjumpcancel") || sprite_index == get_charactersprite("spr_kungfujump") || sprite_index == get_charactersprite("spr_breakdanceuppercut") || sprite_index == get_charactersprite("spr_breakdanceuppercutend"))) || (state == states.slipnslide || ((state == states.hurt && thrown == 1) || (state == states.climbwall || (state == states.freefall || ((state == states.tumble && (sprite_index == get_charactersprite("spr_tumblestart") || sprite_index == get_charactersprite("spr_tumble") || sprite_index == get_charactersprite("spr_tumbleend"))) || (state == states.fireass || (state == states.firemouth || (state == states.hookshot || (state == states.lawnmower || (state == states.unknown35 || (state == states.Sjump || (state == states.machroll || (state == states.machfreefall || (state == states.tacklecharge || ((state == states.superslam && sprite_index == get_charactersprite("spr_piledriver")) || (state == states.knightpep || (state == states.knightpepattack || (state == states.knightpepslopes || (state == states.unknown15 || (state == states.zombieattack || state == states.unknown11))))))))))))))))))))))
    instakillmove = 1;
else
    instakillmove = 0;

if (flash == 1 && alarm[0] <= 0)
    alarm[0] = 0.15 * room_speed;

if (state != states.mach3 && state != states.machslide)
    autodash = 0;

if ((state != states.jump && (state != states.crouchjump && state != states.unknown12)) || vsp < 0)
    fallinganimation = 0;

if (state != states.freefallland && (state != states.normal && state != states.machslide))
    facehurt = 0;

if (state != states.normal && state != states.machslide)
    machslideAnim = 0;

if (state != states.normal)
{
    idle = 0;
    dashdust = 0;
}

if (state != states.mach1 && (state != states.jump && (state != states.hookshot && (state != states.handstandjump && (state != states.normal && (state != states.mach2 && (state != states.mach3 && (state != states.freefallprep && (state != states.knightpep && (state != states.shotgun && state != states.knightpepslopes))))))))))
    momemtum = 0;

if (state != states.Sjump && state != states.Sjumpprep)
    a = 0;

if (state != states.facestomp)
    facestompAnim = 0;

if (state != states.freefall && (state != states.facestomp && (state != states.superslam && state != states.freefallland)))
    superslam = 0;

if (state != states.mach2)
    machpunchAnim = 0;

if (state != states.jump)
    ladderbuffer = 0;

if (state != states.jump)
    stompAnim = 0;

var m3 = false;

if (state == 3 || (state == states.punch && (sprite_index == get_charactersprite("spr_kungfujump") || sprite_index == get_charactersprite("spr_Sjumpcancel") || sprite_index == get_charactersprite("spr_Sjumpcancelstart") || ((sprite_index == get_charactersprite("spr_breakdanceuppercut") || sprite_index == get_charactersprite("spr_breakdanceuppercutend")) && vsp < 0))) || state == states.mach3 || (state == states.grabbed && instance_exists(obj_player2) && obj_player2.state == states.mach3) || state == states.hookshot || state == states.mach2 || state == states.Sjump || (state == states.actor && sprite_index == get_charactersprite("spr_spinjump")) || state == states.tacklecharge || state == states.machroll || state == states.slidekick || (state == states.chainsaw && mach2 >= 100) || state == states.kungfu)
    m3 = true;

if (m3)
{
    if (mach3_afterimage > 0)
        mach3_afterimage -= 1;
    else
    {
        with (instance_create(x, y, obj_afterimage))
        {
            playerid = other.object_index;
            image_index = other.image_index;
            image_xscale = other.xscale;
            sprite_index = other.spritereal;
            alarm[1] = 10;
            type = afterimgs.runningcolors;
            
            output_add = function()
            {
                var _alph = playerid.movespeed / 36;
                var _col = choose(#A020F0, #FFFF00);
                
                if (irandom(100) <= 10)
                    _alph = random(1);
                
                gpu_set_fog(true, _col, 1, 1);
                draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, _alph * visible);
                gpu_set_fog(false, c_white, 0, 0);
            };
        }
        
        mach3_afterimage = 5;
    }
}
else
    mach3_afterimage = 0;

if (toomuchalarm2 > 0)
    toomuchalarm2--;
else if (state == states.tumble || state == states.cape || (state == states.normal && breakdance_speed >= 0.5) || state == states.zombieattack || (state == states.zombie && movespeed >= 6) || (state == states.gateeject && sprite_index == get_charactersprite("spr_machfreefall")) || state == states.handstandjump || state == states.freefall || state == states.lawnmower || (state == states.mach3 && sprite_index == get_charactersprite("spr_crazyrun")))
{
    with (instance_create(x, y, obj_afterimage))
    {
        playerid = other.object_index;
        image_index = other.image_index;
        image_xscale = other.xscale;
        sprite_index = other.spritereal;
        image_alpha = 0.8;
        
        if (other.state == states.freefall)
        {
            output_modifier = function()
            {
                gpu_set_fog(true, #6A0099, 1, 1);
            };
            
            output_resetter = function()
            {
                gpu_set_fog(false, c_black, 0, 0);
            };
        }
    }
    
    toomuchalarm2 = 2;
}

if ((y > (room_height + 300) || y < -800) && state != states.gameover && room != rank_room && room != timesuproom && !place_meeting(x, y, obj_pitfall) && !vhallway)
{
    visible = true;
    
    with (obj_camera)
    {
        shake_mag = 3;
        shake_mag_acc = 3 / room_speed;
    }
    
    state = states.actor;
    visible = false;
    hsp = 0;
    vsp = 0;
    fmod_studio_event_oneshot("event:/sfx/player/bodyslam_land");
    
    with (instance_create(x, y + 540, obj_technicaldifficulty))
    {
        playerid = other.id;
        sprite = spr_technicaldifficulty1;
    }
    
    vsp = 10;
}

if (!place_meeting(x, y, obj_solid))
{
    if (state != states.bump && (sprite_index != get_charactersprite("spr_bombpepintro") && (sprite_index != get_charactersprite("spr_knightpepthunder") && (state != states.tumble && (state != states.fireass && (state != states.crouch && (state != states.unknown15 && ((state != states.pistol && sprite_index != get_charactersprite("spr_crouchshoot")) && (state != states.Sjumpprep && (state != states.chainsaw && (state != states.machroll && state != states.slidekick && (state != states.hurt && (state != states.crouchslide && state != states.crouchjump)))))))))))))
        mask_index = spr_player_mask;
    else
        mask_index = spr_crouchmask;
}
else if (place_meeting(x, y, obj_solid))
    mask_index = spr_crouchmask;

if (state == states.gottreasure || (sprite_index == get_charactersprite("spr_knightpepstart") || (sprite_index == get_charactersprite("spr_knightpepthunder") || (state == states.keyget || (state == states.door || (state == states.ejected || (state == states.victory || (state == states.comingoutdoor || state == states.gameover))))))))
    cutscene = 1;
else
    cutscene = 0;

if (((place_meeting(x, y, obj_door) && !place_meeting(x, y, obj_doorblocked)) || (place_meeting(x, y, obj_dresser) || (place_meeting(x, y, obj_keydoor) || (place_meeting(x, y, obj_exitgate) && global.panic == 1)))) && (!instance_exists(obj_uparrow) && (scr_solid(x, y + 1) && (state == states.normal && obj_player1.spotlight == 1))))
{
    with (instance_create(x, y, obj_uparrow))
        playerid = other.object_index;
}

if (state == states.mach3 && !instance_exists(speedlineseffectid))
{
    with (instance_create(x, y, obj_speedlines))
    {
        playerid = other.object_index;
        other.speedlineseffectid = id;
    }
}

if (state == states.debugstate)
{
    x += hsp;
    y += vsp;
}

if (!grounded)
    storedvsp = vsp;

scr_collide_destructibles();

if (state != 8 && (state != states.grabbed && (state != states.debugstate && (state != states.door && (state != states.Sjump && (state != states.ejected && (state != states.comingoutdoor && (state != states.unknown88 && (state != states.keyget && (state != states.victory && (state != states.portal && (state != states.timesup && (state != states.gottreasure && state != states.gameover)))))))))))))
    scr_collision();

if (state == states.unknown88)
    scr_collision();

if (sprite_index != get_charactersprite("spr_supertaunt1") && sprite_index != get_charactersprite("spr_supertaunt2") && sprite_index != get_charactersprite("spr_supertaunt3") && sprite_index != get_charactersprite("spr_supertaunt4"))
    exit;

for (var i = 0; i < 2; i++)
{
    with (instance_create(x, y, obj_afterimage))
    {
        type = afterimgs.unusedimg;
        invert = (i == 0) ? 1 : -1;
        image_speed = other.image_speed;
        sprite_index = other.sprite_index;
        image_index = other.image_index;
        
        output_modifier = function()
        {
            gpu_set_fog(true, (invert == 1) ? #6A0099 : #FFCD15, 1, 1);
        };
        
        output_resetter = function()
        {
            gpu_set_fog(false, c_black, 0, 0);
        };
    }
}
