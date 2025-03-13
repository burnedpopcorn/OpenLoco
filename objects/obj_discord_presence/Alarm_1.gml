var _secret = instance_exists(obj_secretportal) && obj_secretportal.secret;
var _secreticon = global.panic ? "rpc_secret_panic" : "rpc_secret";
var _targicon = global.panic ? target_icon.escape : target_icon.main;
big_icon = _secret ? _secreticon : _targicon;
np_setpresence_more(small_icon_name, "Loco Tower", false);
np_setpresence(state_text, details, big_icon, small_icon);
alarm[1] = 9;
