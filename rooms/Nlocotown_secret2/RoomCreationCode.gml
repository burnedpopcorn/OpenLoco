if (global.panic)
{
    var lay = layer_get_id("Backgrounds_scroll3");
    layer_background_sprite(layer_background_get_id(lay), bg_secretescape);
    var lay2 = layer_get_id("Backgrounds_scroll2");
    layer_background_sprite(layer_background_get_id(lay2), bg_secretcloudsescape);
    var lay3 = layer_get_id("Backgrounds_scroll");
    layer_background_sprite(layer_background_get_id(lay3), bg_secretbackescape);
}
