if (writer.done)
    exit;

if (writer.buf <= writer.maxbuf)
    event_user(0);

alarm[1] = irandom_range(10, 20);
