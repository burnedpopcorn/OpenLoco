randomize();
text = "testing stuff and cool other stuff |f10| anyway bye";
sounds = [noone];
writer = 
{
    ch: 0,
    buf: 3,
    maxbuf: 3,
    text: "",
    alpha: 1,
    done: false
};
portrait = 
{
    idle: spr_yoshiportrait,
    blink: spr_yoshiportraitBLINK,
    talk: spr_yoshiportraitTALK,
    sprite: spr_yoshiportrait,
    subimg: 0,
    xoff: -sprite_get_width(spr_yoshiportrait)
};
textbox_xscale = 1;
textbox_sprite = spr_textbox;
font = font_dialogue;
state = npctext.startidle;
sound = undefined;
fmod_studio_event_oneshot("event:/sfx/transitions/circleout");
