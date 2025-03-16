Round = 0;
state = zarena.idle;
state_jump_wait = 0;
zombie_list = ds_list_create();
closedGates = false;
var rounds = 0;

for (var i = 0; i < instance_number(obj_zombiearena_tombstone); i++)
{
    var obj = instance_find(obj_zombiearena_tombstone, i);
    
    if (rounds < (ds_list_size(obj.content_list) - 1))
        rounds = ds_list_size(obj.content_list) - 1;
}

totalRounds = rounds;
trace("TOTAL ROUNDS: ", totalRounds + 1);
