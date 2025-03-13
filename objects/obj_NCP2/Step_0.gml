event_inherited();

if (place_meeting(x, y, obj_player) && obj_player.grounded && obj_player.key_up2 && obj_player.state == states.normal)
{
    if (!instance_exists(obj_textbox))
    {
        obj_player1.state = 8;
        
        with (instance_create(x, y, obj_textbox))
        {
            if (global.language == "esp")
            {
                scr_text("Bienvenido a Loco Town!");
                scr_text("La primera region de esta torre, es un pueblo que parece pequeno pero tiene muchas cosas.");
                scr_text("Sugiero que hables con todos y disfrutes este pueblo!");
            }
            
            if (global.language == "eng")
            {
                scr_text("Welcome to Loco Town!");
                scr_text("This is the first region of this tower, this may look like a small town, but it has a lot of things.");
                scr_text("I recommend that you talk with everyone in this town and that you enjoy your stay!");
            }
        }
    }
}
