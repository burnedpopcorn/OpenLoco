if (place_meeting(x, y, obj_player) && obj_player.grounded && obj_player.key_up2)
{
    if (!instance_exists(obj_textbox))
    {
        obj_player1.state = 8;
        
        with (instance_create(x, y, obj_textbox))
            text[0] = "Yo soy el Loco Tower.";
    }
}
