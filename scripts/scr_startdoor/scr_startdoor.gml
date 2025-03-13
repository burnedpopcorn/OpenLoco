function scr_startdoor()
{
    if (other.hallway == 1)
        other.x = x + (other.hallwaydirection * 100);
    else if (other.vhallway == 1)
        other.x = x + other.vhallwayoffset;
    else if (other.box == 1)
        other.x = x + 32;
    else
        other.x = x + 16;
    
    if (other.hallway == 1)
        other.y = y - 16;
    else if (other.vhallway == 1)
        other.y = y + (other.vhallwaydirection * -100);
    else if (other.fastpizzabox == 1)
        other.y = y + 18;
    else
        other.y = y - 14;
}
