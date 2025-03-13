if (other.object_index == obj_player1)
{
    if (obj_player1.shotgunAnim == 0 && (obj_player1.backupweapon == 0 && obj_player1.state == states.handstandjump))
    {
        obj_player1.shotgunAnim = 1;
        obj_player1.state = states.shotgun;
        obj_player1.image_index = 0;
        obj_player1.sprite_index = get_charactersprite("spr_shotgunpullout", obj_player1);
        global.gotshotgun = 1;
        instance_destroy();
    }
    else if (obj_player1.shotgunAnim == 1 && (obj_player1.backupweapon == 0 && obj_player1.state == states.handstandjump))
    {
        obj_player1.backupweapon = 1;
        instance_destroy();
    }
}

if (other.object_index == obj_player2)
{
    if (obj_player2.shotgunAnim == 0 && (obj_player2.backupweapon == 0 && obj_player2.state == states.handstandjump))
    {
        obj_player2.shotgunAnim = 1;
        obj_player2.state = states.shotgun;
        obj_player2.image_index = 0;
        obj_player2.sprite_index = get_charactersprite("spr_shotgunpullout", obj_player2);
        global.gotshotgun = 1;
        instance_destroy();
    }
    else if (obj_player2.shotgunAnim == 1 && (obj_player2.backupweapon == 0 && obj_player2.state == states.handstandjump))
    {
        obj_player2.backupweapon = 1;
        instance_destroy();
    }
}
