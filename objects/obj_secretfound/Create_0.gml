secretos = "SECRETO";

if (ds_list_find_index(global.saveroom, id) == -1 && global.snickchallenge == 0)
{
    global.secretfound += 1;
    
    with (instance_create(0, 0, obj_transformationtext))
        message = langstr_get("SecretFoundSeg1") + " " + string(global.secretfound) + " " + langstr_get("SecretFoundSeg2");
    
    ds_list_add(global.saveroom, id);
}
