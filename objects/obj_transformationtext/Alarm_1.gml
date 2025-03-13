if (++char < string_length(message))
    alarm[1] = char_time;

fmod_studio_event_oneshot("event:/sfx/player/step");
