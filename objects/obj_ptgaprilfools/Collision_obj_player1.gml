if (!jumpscare && !fading)
{
    visible = true;
    audio_stop_all();
    
    repeat (10)
        alarm[0] = 400;
    
    jumpscare = 1;
}
