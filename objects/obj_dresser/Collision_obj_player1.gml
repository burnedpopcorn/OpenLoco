if (obj_player1.key_up2 && obj_player1.grounded && obj_player1.state == states.normal)
{
    if (obj_player1.paletteselect < 42)
        obj_player1.paletteselect++;
    
    if (obj_player1.paletteselect >= 42)
        obj_player1.paletteselect = 0;
}
