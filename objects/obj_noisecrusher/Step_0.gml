switch (state)
{
    case baddiestates.idle:
        scr_enemy_idle();
        break;
    
    case baddiestates.bounce:
        scr_enemy_bounce();
        break;
    
    case baddiestates.stun:
        scr_enemy_stun();
        break;
    
    case baddiestates.grabbed:
        scr_enemy_grabbed();
        break;
}

if (state == baddiestates.grabbed && stunned > 40 && birdcreated == 0)
{
    birdcreated = 1;
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id;
}

if (state != baddiestates.grabbed)
    birdcreated = 0;

if (state == baddiestates.idle && obj_player.x != x)
    image_xscale = sign(obj_player.x - x);

if (state == baddiestates.idle)
    attack--;

if (attack <= 0 && state == baddiestates.idle)
{
    sprite_index = jumpprepspr;
    image_index = 0;
    state = baddiestates.bounce;
}

if (global.bosshealth == 5)
    helmet = 1;

if (helmet == 0)
{
    idlespr = spr_noisecrusherhelmet_bounce;
    stunfallspr = spr_noisecrusherhelmet_stun;
    walkspr = spr_noisecrusherhelmet_jump;
    grabbedspr = spr_noisecrusherhelmet_stun;
    jumpprepspr = spr_noisecrusherhelmet_jumpprep;
    jumpspr = spr_noisecrusherhelmet_jump;
    landspr = spr_noisecrusherhelmet_land;
    airspr = spr_noisecrusherhelmet_air;
}
else
{
    idlespr = spr_noisecrusher_idle;
    stunfallspr = spr_noisecrusher_stun;
    walkspr = spr_noisecrusher_bounce;
    grabbedspr = spr_noisecrusher_stun;
    jumpprepspr = spr_noisecrusher_jumpprep;
    jumpspr = spr_noisecrusher_jump;
    landspr = spr_noisecrusher_land;
    airspr = spr_noisecrusher_air;
}

if (global.bosshealth <= 0)
    instance_destroy();

if (caughtplayer == 1 && !grounded)
{
    obj_player.state = states.bump;
    obj_player.image_index = 0;
    obj_player.x = x;
    obj_player.y = y;
}

if (caughtplayer == 1 && grounded)
{
    obj_player.state = 15;
    
    if (obj_player.sprite_index != spr_boxxedpep_intro)
        obj_player.sprite_index = spr_boxxedpep_intro;
    
    obj_player.image_index = 0;
    obj_player.hsp = 0;
    obj_player.vsp = 0;
    obj_player.x = x;
    obj_player.y = y - 20;
    caughtplayer = 0;
}

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != baddiestates.grabbed)
    depth = 0;

scr_collide();

if (state != baddiestates.grabbed)
    thrown = 0;
