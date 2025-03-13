depth = -530;
options = [];
selected = 0;
select_sign = -1;
activity_buffer = 15;
active = true;
load_options();
add_toggle(langstr_get("Options_Fullscreen"), global.option_fullscreen);
add_hr();
add_select(langstr_get("Options_Resolution"), ["480X270", "960X540", "1980X1080"], ini_resolution);
add_select(langstr_get("Options_Language"), [langstr_get("Options_LanguageSpanish"), langstr_get("Options_LanguageEnglish")], global.option_language);
add_hr();
add_button2(langstr_get("Options_AudioConfig"), function()
{
    instance_create(x, y, obj_audioconfig);
    active = false;
});
add_button2(langstr_get("Options_KeyConfig"), function()
{
    instance_create(x, y, obj_keyconfig);
    active = false;
});
add_button2("EXTRA", function()
{
    instance_create(x, y, obj_extraoptions);
    active = false;
});
event_user(1);
