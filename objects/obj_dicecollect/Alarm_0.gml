var _val;

if (collect >= 10)
{
    _val = 10;
    collect -= 10;
}
else
{
    _val = collect;
    collect = 0;
}

fmod_studio_event_oneshot_3d("event:/sfx/level_structure/collects/normal");
global.collect += _val;
global.combotime += 10;
global.combotime = clamp(global.combotime, 0, 60);

with (instance_create(x, y, obj_smallnumber))
    number = string(_val);

create_collect(x, y, choose(spr_shroomcollect, spr_cheesecollect, spr_tomatocollect, spr_sausagecollect, spr_pineapplecollect), _val);
alarm[0] = 10 + irandom_range(-1, 1);
