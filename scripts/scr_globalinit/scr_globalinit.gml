function scr_globalinit()
{
    global.coop = 0;
    global.hidehud = false;
    global.bigfont = __scribble_font_add_sprite_ext(spr_font, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ!¿?.:1234567890ÁÉÍÓÚ", 1, 0);
    global.collectfont = __scribble_font_add_sprite_ext(spr_font_collect, "0123456789", 1, 0);
    global.scorefont = __scribble_font_add_sprite_ext(spr_font_collectds, "0123456789", 1, 0);
    global.collectfontds = __scribble_font_add_sprite_ext(spr_font_collectds, "0123456789", 1, 0);
    global.combofont2 = __scribble_font_add_sprite_ext(spr_tv_combobubbletext, "0123456789", 1, 0);
    global.smallfont = __scribble_font_add_sprite_ext(spr_smallerfont, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ!.:?1234567890ÁÉÍÓÚ", 1, 0);
    global.smallerfont = __scribble_font_add_sprite_ext(spr_smallfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!.,_1234567890:?", 1, 0);
    global.smallnumber = __scribble_font_add_sprite_ext(spr_smallnumber, "1234567890", 1, 0);
    global.creditsfont = __scribble_font_add_sprite_ext(spr_creditsfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.:!0123456789?'\"ÁÉÍÓÚáéíóú_-[]▼()&#风雨廊桥전태양*яиБжидГзвбнль", 1, 2);
    global.tutorialfont = __scribble_font_add_sprite_ext(spr_tutorialfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!,.:0123456789'?-", true, 2);
    global.minifont = __scribble_font_add_sprite_ext(spr_minifont, "0123456789:.", 1, 0);
    global.stylelock = 0;
    global.heattime = 0;
    global.stylethreshold = 0;
    global.hub_bgsprite = -4;
    ini_open("saveData.ini");
    
    if (!ini_section_exists("SAGE2019"))
    {
        ini_write_string("SAGE2019", "shotgunsnick", 0);
        ini_write_string("SAGE2019", "dungeonbackup", 0);
        ini_write_string("SAGE2019", "srank", 0);
        ini_write_string("SAGE2019", "snicksrank", 0);
        ini_write_string("SAGE2019", "combo10", 0);
        ini_write_string("SAGE2019", "secret", 0);
        ini_write_string("SAGE2019", "knight", 0);
        ini_write_string("SAGE2019", "toppin", 0);
        ini_write_string("SAGE2019", "treasure", 0);
    }
    
    global.SAGEshotgunsnick = ini_read_string("SAGE2019", "shotgunsnick", 0);
    global.SAGEshotgunsnicknumber = 0;
    global.SAGEdungeonbackup = ini_read_string("SAGE2019", "dungeonbackup", 0);
    global.SAGEsrank = ini_read_string("SAGE2019", "srank", 0);
    global.SAGEsnicksrank = ini_read_string("SAGE2019", "snicksrank", 0);
    global.SAGEcombo10 = ini_read_string("SAGE2019", "combo10", 0);
    global.SAGEsecret = ini_read_string("SAGE2019", "secret", 0);
    global.SAGEknight = ini_read_string("SAGE2019", "knight", 0);
    global.SAGEknighttaken = 0;
    global.SAGEtoppin = ini_read_string("SAGE2019", "toppin", 0);
    global.SAGEtreasure = ini_read_string("SAGE2019", "treasure", 0);
    global.option_fullscreen = ini_read_real("Option", "fullscreen", 1);
    global.option_resolution = ini_read_real("Option", "resolution", 1);
    global.option_language = ini_read_string("Option", "language", 0);
    global.option_master_volume = ini_read_real("Option", "master_volume", 1);
    global.option_music_volume = ini_read_real("Option", "music_volume", 1);
    global.option_sfx_volume = ini_read_real("Option", "sfx_volume", 1);
    global.smoothcam = ini_read_real("Option", "smoothcamera", 0);
    global.anglerotation = ini_read_real("Option", "anglerotation", 0);
    global.texfilter = ini_read_real("Option", "texture_filter", true);
    global.danikyo = ini_read_real("Option", "danikyo", 0);
    global.unfocus = ini_read_real("Option", "unfocus", 1);
    ini_close();
    global.secretfound = 0;
    global.shotgunammo = 0;
    global.golfhit = 0;
    window_set_fullscreen(global.option_fullscreen);
    global.resolutionMap = ds_map_create();
    ds_map_set(global.resolutionMap, 0, [480, 270]);
    ds_map_set(global.resolutionMap, 1, [960, 540]);
    ds_map_set(global.resolutionMap, 2, [1920, 1080]);
    window_set_size(array_get(ds_map_find_value(global.resolutionMap, global.option_resolution), 0), array_get(ds_map_find_value(global.resolutionMap, global.option_resolution), 1));
    global.afterimage_array = [];
    global.style = 0;
    global.panic = 0;
    global.snickchallenge = 0;
    global.key_inv = 0;
    global.shroomfollow = 0;
    global.cheesefollow = 0;
    global.tomatofollow = 0;
    global.sausagefollow = 0;
    global.pineapplefollow = 0;
    global.gerome = 0;
    global.keyget = 0;
    global.collect = 0;
    global.collectN = 0;
    global.treasure = 0;
    global.combo = 0;
    global.highest_combo = 0;
    global.combotime = 0;
    global.combofreeze = 0;
    global.comboscore = 0;
    global.previouscombo = 0;
    global.savedcombo = 0;
    global.pizzacoin = 0;
    global.toppintotal = 1;
    global.hit = 0;
    global.baddieroom = ds_list_create();
    global.gotshotgun = 0;
    global.playerhealth = 5;
    global.saveroom = ds_list_create();
    global.escaperoom = ds_list_create();
    global.followerlist = ds_list_create();
    global.instancelist = ds_list_create();
    global.palettesaveroom = ds_map_create();
    global.currentsavefile = 1;
    global.leveltosave = -4;
    global.lap = 0;
    global.laps = 1;
    global.option_vibration = 0;
    global.collectspecial = 0;
    global.collectspecialmax = 10;
    global.combodrop = 0;
    global.leveltoreset = -4;
    global.doortoreset = -4;
    global.roomtorestart = -4;
    global.lap3activate = false;
    global.music = 0;
    global.mu = -4;
    global.secretmusic = -4;
    global.lowpassEffect = audio_effect_create(4);
    global.lowpassEffect.cutoff = 600;
    global.lowpassEffect.q = 0;
    global.lowpassEffect.bypass = 1;
    global.musicemitter = audio_emitter_create();
    global.musicbus = audio_bus_create();
    global.musicbus.effects[0] = global.lowpassEffect;
    audio_emitter_bus(global.musicemitter, global.musicbus);
    global.option_speedrun_timer = 0;
    global.option_timer_type = 0;
    global.treasurelastroom = -4;
    global.treasurelastdoor = "A";
    global.boxhp = 20;
}

// very important
__global_object_depths();