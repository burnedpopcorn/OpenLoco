function scr_enemyinit()
{
    scr_collision_init();
    lunge_throw = 0;
    lungeHP = 3;
    lunged = 0;
    shoulderbashed = 0;
    under = 0;
    underescape = 0;
    stundraw = 0;
    instakilled = 0;
    roomchange = 0;
    linethrown = 0;
    scaredbuffer = 0;
    parryable = 1;
    invtime = 0;
    hitLag = 0;
    hitX = x;
    hitY = y;
    hitvsp = 0;
    hithsp = 0;
    elite = 0;
    elitehit = 0;
    maxelitehit = 0;
    elitegrab = 0;
    destroyable = 1;
    mach3destroy = 0;
    dashcloudid = obj_null;
    yscale = 1;
    xscale = 1;
    stun_snd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/enemy/stun"));
    provoked = 0;
    bombreset = 0;
}
