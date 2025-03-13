if (instance_exists(obj_geromefollow))
    obj_geromefollow.visible = true;
else
    instance_create(x, y, obj_geromefollow);

instance_destroy();
