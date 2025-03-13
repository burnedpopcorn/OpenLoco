if (!writer.done)
    exit;

portrait.sprite = portrait.blink;
portrait.subimg = 0;
alarm[0] = irandom_range(30, 120);
