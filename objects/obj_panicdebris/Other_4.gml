if (global.panic && obj_music.start_bg_escape)
{
    var roomname = room_get_name(room);
    
    if (string_letters(roomname) == "Nhall")
    {
        var lay_id = layer_get_id("Backgrounds_1");
        var bg_id = layer_background_get_id(lay_id);
        
        if (layer_background_get_sprite(bg_id) == bg_hall2)
            layer_background_change(bg_id, bg_hall2escape);
        
        var lay_id2 = layer_get_id("Backgrounds_2");
        var bg_id2 = layer_background_get_id(lay_id2);
        
        if (layer_background_get_sprite(bg_id2) == bg_hall1)
            layer_background_change(bg_id2, bg_hall1escape);
    }
    
    if (string_letters(roomname) == "Nhallsecret")
    {
        var lay_id = layer_get_id("Backgrounds_sky3scroll");
        var bg_id = layer_background_get_id(lay_id);
        layer_background_change(bg_id, bg_secretescapeold);
    }
    
    if (string_letters(roomname) == "Nlocotown" || string_letters(roomname) == "Nlocotownb")
    {
        var lay_id = layer_get_id("Backgrounds_sky5");
        var bg_id = layer_background_get_id(lay_id);
        
        if (layer_background_get_sprite(bg_id) == bg_cementary3)
            layer_background_change(bg_id, bg_cementaryescape3);
        
        var lay_id2 = layer_get_id("Backgrounds_sky4");
        var bg_id2 = layer_background_get_id(lay_id2);
        
        if (layer_background_get_sprite(bg_id2) == bg_cementary2)
            layer_background_change(bg_id2, bg_cementaryescape2);
        
        var lay_id3 = layer_get_id("Backgrounds_sky3");
        var bg_id3 = layer_background_get_id(lay_id3);
        
        if (layer_background_get_sprite(bg_id3) == bg_cementary1)
            layer_background_change(bg_id3, bg_cementaryescape1);
        
        var lay_id4 = layer_get_id("Backgrounds_stillH1");
        
        if (lay_id4 != -1)
        {
            var bg_id4 = layer_background_get_id(lay_id4);
            
            if (layer_background_get_sprite(bg_id4) == bg_locotownsewer)
                layer_background_change(bg_id4, bg_locotownsewerescape);
            
            tilemap_tileset(layer_tilemap_get_id("Tiles_1"), ts_townsewersescape);
            tilemap_tileset(layer_tilemap_get_id("Tiles_2"), ts_townsewersescape);
            tilemap_tileset(layer_tilemap_get_id("Tiles_3"), ts_townsewersescape);
            tilemap_tileset(layer_tilemap_get_id("Tiles_BG"), ts_townsewersescape);
        }
    }
    
    var bricksfalling = layer_create(-350, "Foreground_escape");
    var back = layer_background_create(bricksfalling, bg_fallingbricksforefront);
    layer_background_htiled(back, true);
    layer_background_vtiled(back, true);
    
    if (global.lap3activate == false && obj_music.asset == mu_lap3)
        layer_vspeed(bricksfalling, 0);
    else
        layer_vspeed(bricksfalling, (global.lap3activate == true) ? -4 : 4);
}
