var roomname = room_get_name(room);
timer_xstart = (obj_screen.actualWidth / 2) - 153;
timer_ystart = obj_screen.actualHeight - 76;

if (room == rank_room || room == NoRoom || room == rm_intro || room == rm_titlecard || string_letters(roomname) == "Tutori" || string_letters(roomname) == "Tutorii" || room == hub_start || room == hub_cafe || room == hub_afterstart || room == hub_hall || room == hub_afterhall || room == hub_magmamine || room == hub_boss1 || room == hub_lobby || room == hub_hallway || room == hub_locotown || room == hub_forestmaze || room == rm_introcustene || room == rm_titleselect || room == Realtitlescreen || room == Disclamer || room == Titlescreen || room == Scootertransition || room == credits || room == timesuproom || room == boss_room1 || room == characterselect || room == rm_antileak)
{
    visible = false;
    state = TVstates.start;
}
else
{
    visible = true;
}

image_speed = 0.35;
alpha = Approach(alpha, alphaend, 0.07);

if (fadebg > 0)
    fadebg = Approach(fadebg, 0, 0.1);

if (bubblespr != noone && bubblespr != spr_tv_bubbleclosed)
{
    if (prompt != noone)
        prompt_buffer = 2;
    
    bubbleindex += image_speed;
    
    if (floor(bubbleindex) == sprite_get_number(bubblespr))
    {
        bubbleindex = 0;
        
        switch (bubblespr)
        {
            case spr_tv_bubbleopen:
                bubblespr = spr_tv_bubble;
                break;
            
            case spr_tv_bubbleclose:
                bubblespr = spr_tv_bubbleclosed;
                
                if (prompt == noone || prompt == "")
                    bubblespr = noone;
                
                break;
        }
    }
}

tvbg_scroll += ((obj_player1.hsp / 2) * -1);
tvbg_secret_scroll += 0.25;
tvbg_secret_alpha = Approach(tvbg_secret_alpha, instance_exists(obj_secretportal) && obj_secretportal.secret, 0.05);
var _transfo = false;
var _anim_speed = 0.35;
var _charstate = obj_player1.state;
var _charspd = abs(obj_player1.hsp);
var _charspr = obj_player1.sprite_index;

if (obj_player1.state == states.backbreaker || obj_player1.state == states.chainsaw)
{
    _charstate = obj_player1.tauntstoredstate;
    _charspd = abs(obj_player1.tauntstoredmovespeed);
    _charspr = obj_player1.tauntstoredsprite;
}

switch (state)
{
    case TVstates.start:
        if (!visible)
        {
            image_index = 0;
            sprite_index = get_charactersprite("spr_tvoff");
        }
        else if (alpha == alphaend)
        {
            tv_trigger_whitenoise(TVstates.maintv, 0.35, true, get_charactersprite("spr_tvopen"));
        }
        
        break;
    
    case TVstates.maintv:
        standard_sprite = global.panic ? get_charactersprite("spr_tvpanic") : get_charactersprite("spr_tvidle");
        
        if (global.laps >= 3)
            standard_sprite = get_charactersprite("spr_tvheat");
        else if (global.laps == 2)
            standard_sprite = get_charactersprite("spr_tvlap2");
        
        if (!global.panic && global.combo >= 3)
        {
            var _high = "";
            
            if (global.combo >= 50)
                _high = "high";
            
            standard_sprite = get_charactersprite(concat("spr_tv", _high, "combo"));
        }
        
        _transfo = sprite_index == get_charactersprite("spr_tvidle") || sprite_index == get_charactersprite("spr_tvheat") || sprite_index == get_charactersprite("spr_tvlap2") || sprite_index == get_charactersprite("spr_tvcombo") || sprite_index == get_charactersprite("spr_tvhighcombo");
        
        switch (_charstate)
        {
            case states.machslide:
            case states.mach3:
                _transfo = false;
                var _machslide = obj_player1.sprite_index == get_charactersprite("spr_machslide") || obj_player1.sprite_index == get_charactersprite("spr_machslidestart") || obj_player1.sprite_index == get_charactersprite("spr_machslideend") || obj_player1.sprite_index == get_charactersprite("spr_machslideboost");
                
                if (_charspr == get_charactersprite("spr_crazyrun"))
                {
                    standard_sprite = get_charactersprite("spr_tvmach4");
                    _anim_speed = 0.4;
                }
                else if (!_machslide)
                {
                    standard_sprite = get_charactersprite("spr_tvmach3");
                }
                
                break;
            
            case states.hurt:
                _transfo = false;
                standard_sprite = get_charactersprite("spr_tvhurt");
                break;
            
            case states.zombie:
            case states.zombiejump:
            case states.zombieattack:
                _transfo = true;
                standard_sprite = get_charactersprite("spr_tvzombie");
                break;
            
            case states.debugstate:
                _transfo = true;
                standard_sprite = spr_tvnoclip_damian;
                break;
        }
        
        if (instance_exists(obj_secretportal) && obj_secretportal.secret)
        {
            _transfo = true;
            standard_sprite = global.panic ? get_charactersprite("spr_tvsecretpanic") : get_charactersprite("spr_tvsecret");
        }
        
        switch (sprite_index)
        {
            case spr_tvidle_damian:
            case spr_tvidle_nauta:
                idletime--;
                
                if (idletime <= 0 && animation_end())
                {
                    image_index = 0;
                    sprite_index = choose(get_charactersprite("spr_tvidleanim1"), get_charactersprite("spr_tvidleanim2"));
                }
                
                break;
            
            case spr_tvidleanim1_damian:
            case spr_tvidleanim2_damian:
                if (animation_end())
                {
                    idletime = irandom_range(300, 600);
                    image_index = 0;
                    sprite_index = tvsprite;
                }
                
                break;
        }
        
        if (instance_exists(obj_exitbubble))
        {
            _transfo = true;
            standard_sprite = get_charactersprite("spr_tvbubble");
        }
        
        if (tvsprite != standard_sprite && _transfo && sprite_index != expression_sprite)
        {
            tvsprite = standard_sprite;
            sprite_index = tvsprite;
            image_index = 0;
        }
        else if (tvsprite != standard_sprite || sprite_index == expression_sprite)
        {
            tvsprite = standard_sprite;
            tv_trigger_whitenoise(TVstates.maintv);
        }
        
        image_speed = _anim_speed;
        break;
    
    case TVstates.whitenoise:
        whitenoise_index += whitenoise_speed;
        var _whitenoise_frames = sprite_get_number(get_charactersprite("spr_tvwhitenoise")) - 1;
        
        if (animation_end(floor(whitenoise_index), _whitenoise_frames))
        {
            state = previous_state;
            sprite_index = tvsprite;
            image_index = 0;
        }
        
        break;
    
    case TVstates.delay:
        if (expression_time > 0)
        {
            expression_time--;
        }
        else if (sprite_exists(expression_que[| 0]))
        {
            trace("Queued expression");
            expression_sprite = expression_que[? 0].sprite;
            expression_time = expression_que[? 0].duration;
            expression_priority = expression_que[? 0].prio;
            usepalette = expression_que[? 0].usepal;
            expression_forced = expression_que[? 0].forced;
            
            if (expression_que[? 0].instant)
            {
                tvsprite = expression_sprite;
                sprite_index = tvsprite;
                state = TVstates.delay;
            }
            else
            {
                tvsprite = expression_sprite;
                tv_trigger_whitenoise(TVstates.delay);
            }
            
            ds_list_delete(expression_que, 0);
        }
        else
        {
            expression_priority = 0;
            state = TVstates.maintv;
        }
        
        break;
}

marx_index += 0.35;
hand_index += 0.35;
johnface_index += 0.35;

if (global.panic && global.fill > 0)
{
    showtime_buffer = 100;
    
    if (!instance_exists(obj_ghostcollectibles))
        timer_y = Approach(timer_y, timer_ystart, 1);
    else
        timer_y = Approach(timer_y, timer_ystart + 212, 4);
}
else if (global.panic)
{
    if (marx_sprite == spr_timer_marx1)
    {
        marx_sprite = spr_timer_marx2;
        marx_index = 0;
    }
    else if (marx_sprite == spr_timer_marx2)
    {
        if (floor(marx_index) == (sprite_get_number(marx_sprite) - 1))
        {
            marx_sprite = spr_timer_marx3;
            marx_index = 0;
        }
    }
    else if (showtime_buffer > 0)
    {
        showtime_buffer--;
    }
    else
    {
        timer_y = Approach(timer_y, timer_ystart + 212, 1);
    }
}
else
{
    marx_sprite = spr_timer_marx1;
    timer_y = timer_ystart + 212;
}

barfill_x -= 0.2;

if (barfill_x < -306)
    barfill_x = 0;

if (marx_index > (sprite_get_number(marx_sprite) - 1))
    marx_index = frac(marx_index);

if (patricksun_index > (sprite_get_number(patricksun_sprite) - 1))
    patricksun_index = frac(patricksun_index);

if (johnface_index > (sprite_get_number(johnface_sprite) - 1))
    johnface_index = frac(johnface_index);

if (showtext == 1)
{
    xi = 500 + random_range(1, -1);
    
    if (yi > 500)
        yi -= 5;
}

if (showtext == 0)
{
    xi = 500 + random_range(1, -1);
    
    if (yi < 600)
        yi += 1;
}

if (!(obj_player.state == states.knightpep && obj_player.state == states.knightpepattack && obj_player.state == states.knightpepslopes))
    once = 0;

var change_pos = 0;

if (obj_player.x > (room_width - 224) && obj_player.y < 187)
    change_pos = 1;

var spd = 15;

if (change_pos)
    hud_posY = Approach(hud_posY, -300, spd);
else
    hud_posY = Approach(hud_posY, 0, spd);

combo_posX = Wave(-5, 5, 2, 20);

if (global.combotime > 0 && global.combo != 0)
{
    switch (combo_state)
    {
        case combonum.state0:
            combo_posY += combo_vsp;
            combo_vsp += 0.5;
            
            if (combo_posY > 20)
                combo_state++;
            
            break;
        
        case combonum.state1:
            combo_posY = lerp(combo_posY, 0, 0.05);
            
            if (combo_posY < 1)
            {
                combo_posY = 0;
                combo_vsp = 0;
                combo_state++;
            }
            
            break;
        
        case combonum.state2:
            if (global.combotime < 30)
            {
                combo_posY += combo_vsp;
                
                if (combo_vsp < 20)
                    combo_vsp += 0.5;
                
                if (combo_posY > 0)
                {
                    combo_posY = 0;
                    combo_vsp = -1;
                    
                    if (global.combotime < 15)
                        combo_vsp = -2;
                }
            }
            else
            {
                combo_posY = Approach(combo_posY, 0, 10);
            }
            
            break;
    }
}
else
{
    combo_posY = Approach(combo_posY, -500, 5);
    combo_vsp = 0;
    combo_state = combonum.state0;
}

combofill_index += 0.35;

if (combofill_index > (sprite_get_number(spr_tv_combobubblefill) - 1))
    combofill_index = frac(combofill_index);
