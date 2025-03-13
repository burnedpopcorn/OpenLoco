var _banks = [master_bank, master_strings_bank, music_bank, sfx_bank];

for (var i = 0; i < array_length(_banks); i++)
{
    if (fmod_studio_bank_get_loading_state(_banks[i]) == UnknownEnum.Value_2 || fmod_studio_bank_get_loading_state(_banks[i]) == UnknownEnum.Value_1)
    {
        alarm[0] = 3;
        exit;
    }
    
    fmod_studio_bank_load_sample_data(_banks[i]);
    
    if (fmod_studio_bank_get_sample_loading_state(_banks[i]) == UnknownEnum.Value_2 || fmod_studio_bank_get_sample_loading_state(_banks[i]) == UnknownEnum.Value_1)
    {
        alarm[0] = 3;
        exit;
    }
}
