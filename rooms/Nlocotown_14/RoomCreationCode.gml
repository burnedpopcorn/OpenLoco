if (global.panic)
{
    var lay = layer_get_id("Tiles_1");
    tilemap_tileset(layer_tilemap_get_id(lay), ts_townsewersescape);
    var lay2 = layer_get_id("Tiles_2");
    tilemap_tileset(layer_tilemap_get_id(lay2), ts_townsewersescape);
    var lay3 = layer_get_id("Tiles_Secret1");
    tilemap_tileset(layer_tilemap_get_id(lay3), ts_townsewersescape);
    var lay4 = layer_get_id("Backgrounds_stillH1");
    layer_background_sprite(layer_background_get_id(lay4), bg_locotownsewerescape);
}
