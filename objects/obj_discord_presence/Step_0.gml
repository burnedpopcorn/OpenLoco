np_update();

if (instance_exists(obj_load) || !ready)
    exit;

var _rank = "d";
var _score = global.collect;

if (_score >= global.srank)
{
    if (global.lap && global.secretfound >= 3 && global.treasure && !global.combodrop)
        _rank = "l";
    else
        _rank = "s";
}
else if (_score >= global.arank)
    _rank = "a";
else if (_score >= global.brank)
    _rank = "b";
else if (_score >= global.crank)
    _rank = "c";

if (global.leveltosave == noone || room == rm_titlecard || instance_exists(obj_pointstotal))
    _rank = "noone";

var _lrankcount = global.laps - 1;
var _lstring = "";

if (global.laps >= 3 && _rank == "l")
    _lstring = "x" + string(_lrankcount);

small_icon_name = string_upper(_rank) + _lstring + " Rank";
small_icon = _rank + "_rank";
var _points = global.collect;
state_text = "Score: " + string(_points);

if (instance_exists(obj_pointstotal))
{
    _points = global.pointstotal;
    state_text = "Total Score: " + string(_points);
}
else if (global.leveltosave == noone)
    state_text = "No Score";
