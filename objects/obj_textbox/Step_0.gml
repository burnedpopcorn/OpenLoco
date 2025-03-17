scr_getinput();

switch (state)
{
    case npctext.startidle:
        portrait.sprite = portrait.idle;
        var target = sprite_get_width(portrait.idle) + 20;
        portrait.xoff = lerp(portrait.xoff, target, 0.5);
        
        if ((target - portrait.xoff) < 1)
        {
            portrait.xoff = target;
            state = npctext.opentextbox;
        }
        
        break;
    
    case npctext.opentextbox:
        var target = obj_screen.actualWidth - portrait.xoff - 20 - 68.5;
        textbox_xscale = lerp(textbox_xscale, target, 0.25);
        
        if ((target - textbox_xscale) < 1)
        {
            textbox_xscale = target;
            state = npctext.npctalk;
            alarm[1] = irandom_range(10, 30);
        }
        
        break;
    
    case npctext.npctalk:
        var box = id;
        var length = string_length(text);
        writer.done = writer.ch >= length;
        var type_char = method(
        {
            box: box
        }, function()
        {
            with (box)
            {
                var length = string_length(text);
                writer.buf = writer.maxbuf;
                
                if (writer.done || writer.ch >= length)
                    exit;
                
                var ch = string_char_at(text, writer.ch + 1);
                
                if (ch == "|")
                {
                    writer.ch++;
                    var data = str_read_until(text, "|", writer.ch);
                    writer.ch = data[1];
                    var meta = data[0];
                    
                    if (string_char_at(meta, 1) == "f")
                    {
                        var time = string_copy(meta, 2, string_length(meta) - 1);
                        writer.buf = real(time);
                    }
                    else
                    {
                        trace("can't understand meta instrucion ", meta);
                    }
                    
                    exit;
                }
                
                writer.text += ch;
                writer.ch = clamp(writer.ch + 1, 0, length);
                portrait.sprite = portrait.talk;
                portrait.subimg = 0;
                alarm[0] = irandom_range(30, 60);
            }
        });
        
        if (writer.buf-- <= 0 && !writer.done)
            type_char();
        
        if (key_jump && !writer.done)
        {
            var ch_left = length - writer.ch;
            
            repeat (ch_left)
                type_char();
            
            writer.ch = length;
        }
        
        if (key_jump && writer.done)
            state = npctext.checktxtbox;
        
        break;
    
    case npctext.checktxtbox:
        textbox_xscale = lerp(textbox_xscale, 1, 0.25);
        writer.alpha = lerp(writer.alpha, 0, 0.4);
        
        if (textbox_xscale >= 0.9 && textbox_xscale < 1.1)
        {
            textbox_xscale = 1;
            state = npctext.endidle;
        }
        
        break;
    
    case npctext.endidle:
        portrait.sprite = portrait.idle;
        portrait.xoff = lerp(portrait.xoff, -sprite_get_width(portrait.sprite) - 10, 0.5);
        
        if (portrait.xoff <= -sprite_get_width(portrait.sprite))
        {
            trace("done dialog");
            instance_destroy();
        }
        
        break;
}

portrait.subimg = clamp(portrait.subimg + 0.4, 0, sprite_get_number(portrait.sprite));
