if (other.state != 6)
{
    global.collectspecial += 1;
    
    with (instance_create(x + 16, y, obj_smallnumber))
        number = string(global.collectspecial);
    
    instance_destroy();
}
