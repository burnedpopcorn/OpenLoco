if (instance_number(obj_particlesystem) > 1)
{
    instance_destroy();
    exit;
}

colorpalettesprite = noone;
colorpalette = noone;
depth = -99;
global.particle_system = part_system_create();
global.part_map = ds_map_create();
global.part_depth = ds_map_create();
global.part_emitter = part_emitter_create(global.particle_system);
global.debris_list = ds_list_create();
global.collect_list = ds_list_create();
var p = declare_particle(1, spr_cloudeffect, 0.35, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(2, spr_crazyrunothereffect, 0.5, -99);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(3, spr_highjumpcloud1, 0.5, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(4, spr_highjumpcloud2, 0.5, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(5, spr_jumpdust, 0.35, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(6, spr_balloonpop, 0.5, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(7, spr_shotgunimpact, 0.5, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(8, spr_impact, 0.5, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(9, spr_genericpoofeffect, 1, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(15, spr_cloudeffect, 0.35, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(10, spr_keyparticles, 0.35, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(11, spr_cloudeffect, 0.5, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(12, spr_landcloud, 0.5, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(13, spr_cloudeffect, 0.7, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(14, spr_groundpoundeffect, 0.35, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(15, spr_bubbleeffect, 0.35, 0);
part_type_speed(p, 0, 0, 0, 0);
p = declare_particle(16, spr_groundpoundjumpeffect, 0.35, 0);
part_type_speed(p, 0, 0, 0, 0);
