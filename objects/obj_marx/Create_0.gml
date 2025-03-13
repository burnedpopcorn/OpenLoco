if (instance_number(object_index) > 1)
{
    instance_destroy();
    exit;
}

laughsound = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/enemy/marx/laugh"));
fmod_studio_event_instance_start(laughsound);
laser_sound_instance = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/enemy/marx/laser"));
amountlaser = 0;
amountlasermax = 320;
laserbar = 0;
usingonce = 0;
image_speed = 0.35;
alarm[1] = 3;
image_alpha = 0;
usepower = 0;
powerlimit = 0;
blackhole = 0;
powerselect = 0;
arrows = 0;
usingarrows = 0;
instakillmove = 0;
laser = 0;
ballpower = 0;
ballscale = 1;
ballmax = 1;
startanim = 0;
highest_y = -170;
leftshoex = x;
leftshoey = y;
rightshoex = x;
rightshoey = y;
tiex = x;
tiey = y;
leftwingsx = x;
leftwingsy = y;
rightwingsx = x;
rightwingsy = y;
lefthexagonx = x;
lefthexagony = y;
righthexagonx = x;
righthexagony = y;
waveamnt = 10;
wavetime = 1;
