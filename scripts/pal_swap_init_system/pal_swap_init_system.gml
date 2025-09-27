function pal_swap_init_system()
{
    global.Pal_Shader = shd_pal_swapper;
    global.Pal_Texel_Size = shader_get_uniform(shd_pal_swapper, "texel_size");
    global.Pal_UVs = shader_get_uniform(shd_pal_swapper, "palette_UVs");
    global.Pal_Index = shader_get_uniform(shd_pal_swapper, "palette_index");
    global.Pal_Texture = shader_get_sampler_index(shd_pal_swapper, "palette_texture");
    
    if (argument_count > 1 && argument[1])
        global.Pal_Map = ds_map_create();
    
    global.Pattern_Texture_Indexed = noone;
    global.Base_Pattern_Color = [1, 2];
    global.Pattern_Texture = shader_get_sampler_index(shd_pal_swapper, "pattern_texture");
    global.Pattern_Enable = shader_get_uniform(shd_pal_swapper, "pattern_enabled");
    global.Pattern_Tex_Data = shader_get_uniform(shd_pal_swapper, "pattern_tex_data");
    global.Pattern_UVs = shader_get_uniform(shd_pal_swapper, "pattern_UVs");
    global.Pattern_Spr_UVs = shader_get_uniform(shd_pal_swapper, "sprite_UVs");
    global.Pattern_Spr_Tex_Data = shader_get_uniform(shd_pal_swapper, "sprite_tex_data");
    global.Pattern_Spr_Scale = shader_get_uniform(shd_pal_swapper, "sprite_scale");
    global.Pattern_Color_Array = shader_get_uniform(shd_pal_swapper, "color_array");
}
