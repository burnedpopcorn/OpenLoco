instance_create(x + (obj_player.xscale * 40), y, obj_punchdust);
state = states.capefall;
obj_player.state = states.grab;
instance_destroy(other.id);
obj_player.suplexhavetomash = 5;
obj_player.sprite_index = spr_player_grab;
