if (other.object_index == obj_player1)
    global.collect += 25;
else
    global.collectN += 25;

with (instance_create(x, y, obj_smallnumber))
    number = "25";

fmod_studio_event_oneshot("event:/sfx/level_structure/collects/plushie");
instance_destroy();
