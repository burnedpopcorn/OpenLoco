if (rm_intro == true)
{
    instance_create(x, y, obj_disclamer);
    instance_destroy();
}
else
{
    obj_player.targetRoom = rm_intro;
    obj_player.targetDoor = "E";
    instance_create(x, y, obj_fadeout);
}
