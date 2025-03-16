switch (state)
{
    case baddiestates.idle:
        scr_enemy_idle();
        break;
    
    case baddiestates.charge:
        scr_enemy_charge();
        break;
    
    case baddiestates.turn:
        scr_enemy_turn();
        break;
    
    case states.actor:
        scr_enemy_walk();
        break;
    
    case baddiestates.land:
        scr_enemy_land();
        break;
    
    case baddiestates.hit:
        scr_enemy_hit();
        break;
    
    case baddiestates.stun:
        scr_enemy_stun();
        break;
    
    case baddiestates.throwing:
        scr_pizzagoblin_throw();
        break;
    
    case states.grabbed:
        scr_enemy_grabbed();
        break;
}

if (state == baddiestates.stun && (stunned > 40 && birdcreated == 0))
{
    birdcreated = 1;
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id;
}

if (state != states.grabbed)
    birdcreated = 0;

if (hp <= 0)
    instance_destroy();

if (cigar == 1)
{
    landspr = spr_ballgoal;
    idlespr = spr_beantreasuregot;
    fallspr = spr_balloonpop;
    hitceillingspr = spr_backslide_damian;
    stunfalltransspr = spr_backkick_damian;
    hitwallspr = spr_angrycloud;
    stunfallspr = spr_backbreaker_damian;
    rollingspr = spr_ancho_charge;
    walkspr = spr_barrelfloat;
    turnspr = spr_bangeffect;
    flyingspr = spr_baddie;
    hitspr = spr_baddiespawn;
    stunlandspr = spr_anchobounce;
    stunspr = spr_ancho_scared;
    recoveryspr = spr_airdash2_damian;
    stompedspr = spr_arenagate_open;
    grabbedspr = spr_aimup_damian;
}

if (cigar == 0)
{
    landspr = spr_baddiespawner;
    idlespr = spr_beantreasure;
    fallspr = spr_balloon;
    hitceillingspr = spr_backkickprep_damian;
    stunfalltransspr = spr_backflip_damian;
    hitwallspr = spr_anchodead;
    stunfallspr = spr_arenagate_opened;
    rollingspr = spr_alien;
    walkspr = spr_barrel;
    turnspr = spr_banana;
    flyingspr = spr_backslideland_damian;
    hitspr = spr_baddiegibs;
    stunlandspr = spr_ancho;
    stunspr = spr_ancho_chargestart;
    recoveryspr = spr_airdash1_damian;
    stompedspr = spr_arenagate_close;
    grabbedspr = UnknownEnum.Value_128;
}

if (cigar == 1 && (cigarcreate == 0 && (state == baddiestates.idle || (state == states.actor || (state == 98 || state == baddiestates.land)))))
{
    cigarcreate = 1;
    
    with (instance_create(x, y, obj_sausagemancigar))
        ID = other.id;
}

if (state != states.grabbed)
    depth = 0;

if (state != states.grabbed)
    thrown = 0;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;
