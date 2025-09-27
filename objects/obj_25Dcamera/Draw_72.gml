var _camW = camera_get_view_width(camera);
var _camH = camera_get_view_height(camera);
var _camX = camera_get_view_x(camera);
var _camY = camera_get_view_y(camera);
var target = obj_player1;

if (target.state == states.mach2 || target.state == states.mach3 || target.state == states.tumble || target.state == states.lawnmower)
{
    var _targetcharge = target.xscale * ((target.movespeed / 4) * 50);
    var _tspeed = 0.3;
    chargecamera = Approach(chargecamera, _targetcharge, _tspeed);
}
else if (abs(target.hsp) >= 16 && target.state != states.climbwall && target.state != states.Sjump)
{
    var _targetcharge = target.xscale * ((abs(target.movespeed) / 4) * 50);
    var _tspeed = 2;
    
    if ((_targetcharge > 0 && chargecamera < 0) || (_targetcharge < 0 && chargecamera > 0))
        _tspeed = 8;
    
    chargecamera = Approach(chargecamera, _targetcharge, _tspeed);
}
else if (target.state == states.machslide)
    chargecamera = Approach(chargecamera, 0, 10);
else
    chargecamera = Approach(chargecamera, 0, 6);

if (!(room_width == 960 && room_height == 540))
{
    _camX = target.x + chargecamera;
    _camY = target.y - 50;
    _camX = clamp(_camX, 0, room_width - _camW);
    _camY = clamp(_camY, 0, room_height - _camH);
}
else
{
    _camX = 480;
    _camY = 270;
}

var _viewMat = matrix_build_lookat(_camX, _camY - 50, camDist, _camX, _camY, 0, 0, 1, 0);
var _projMat = matrix_build_projection_perspective_fov(camFov, camAsp, 3, 30000);
camera_set_view_mat(camera, _viewMat);
camera_set_proj_mat(camera, _projMat);
camera_apply(camera);
