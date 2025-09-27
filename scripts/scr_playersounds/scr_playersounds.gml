// unused
function audio_safe_stop(argument0) { }

function init_playersounds()
{
    idlevoice = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/voice/idle"));
    happyvoice = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/voice/happy"));
    hurtvoice = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/voice/hurt"));
    jumpsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/jump"));
    grabsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/grabdash"));
    uppercutsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/uppercut"));
    groundpoundsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/bodyslam"));
    machsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/mach/damian"));
    machrollsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/mach/roll"));
    rollgetupsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/rollgetup"));
    mach2jumpsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/mach/jump"));
    machdriftsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/mach/drift"));
    machslidesnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/mach/slide"));
    divesnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/dive"));
    superjumpsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/sjump"));
    tauntsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/taunt/normal"));
    styledtauntsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/taunt/styled"));
    supertauntsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/taunt/super"));
    shotgunsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/misc/shotgun"));
    slipbanansnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/slip/banan"));
    slipendsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/slip/end"));
    tumblesnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/misc/tumble"));
    capegetsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/cape/get"));
    capeupsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/cape/up"));
    capedownsnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/cape/down"));
    genowalksnd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/geno/genowalk"));
}

function update_playersounds()
{
    var _snd_array = 
	[
		idlevoice, 
		happyvoice, 
		hurtvoice, 
		jumpsnd, 
		grabsnd, 
		uppercutsnd, 
		groundpoundsnd, 
		machsnd, 
		machrollsnd, 
		mach2jumpsnd, 
		machdriftsnd, 
		machslidesnd, 
		divesnd, 
		superjumpsnd, 
		tauntsnd, 
		styledtauntsnd, 
		supertauntsnd, 
		tumblesnd, 
		slipbanansnd, 
		slipendsnd, 
		shotgunsnd, 
		capegetsnd, 
		capeupsnd, 
		capedownsnd, 
		rollgetupsnd, 
		genowalksnd
	];
    var _playerstate = state;
    
    if (state == states.chainsaw)
        _playerstate = tauntstoredstate;
    
    for (var i = 0; i < array_length(_snd_array); i++)
        fmod_studio_event_instance_move(_snd_array[i]);
    
    if (_playerstate != states.mach2 && _playerstate != states.mach3 && _playerstate != states.climbwall)
        fmod_studio_event_instance_stop(machsnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    else
    {
        var _machnum = 0;
        
        if (sprite_index == get_charactersprite("spr_mach1"))
            _machnum = 1;
        else if ((_playerstate == states.mach2 && grounded) || _playerstate == states.climbwall)
            _machnum = 2;
        else if (sprite_index == get_charactersprite("spr_crazyrun"))
            _machnum = 4;
        else if (_playerstate == states.mach3)
            _machnum = 3;
        
        fmod_studio_event_instance_set_paused(machsnd, false);
        fmod_studio_event_instance_set_parameter_by_name(machsnd, "state", _machnum);
        
        if (!fmod_studio_event_instance_is_playing(machsnd))
            fmod_studio_event_instance_start(machsnd);
    }
    
    if (sprite_index == get_charactersprite("spr_machroll") && !fmod_studio_event_instance_is_playing(machrollsnd))
        fmod_studio_event_instance_start(machrollsnd);
    else if (sprite_index != get_charactersprite("spr_machroll"))
        fmod_studio_event_instance_stop(machrollsnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    
    fmod_studio_event_instance_set_parameter_by_name(tumblesnd, "state", _playerstate == states.bump);
    
    if (sprite_index != get_charactersprite("spr_tumble") && sprite_index != get_charactersprite("spr_tumblestart") && sprite_index != get_charactersprite("spr_tumbleend"))
        fmod_studio_event_instance_stop(tumblesnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    else if (!fmod_studio_event_instance_is_playing(tumblesnd))
        fmod_studio_event_instance_start(tumblesnd);
    
    if (_playerstate == states.Sjumpprep || _playerstate == states.Sjump || _playerstate == states.chainsaw)
    {
        var _sjumpstate = _playerstate != states.Sjumpprep;
        fmod_studio_event_instance_set_parameter_by_name(superjumpsnd, "state", _sjumpstate);
        
        if (!fmod_studio_event_instance_is_playing(superjumpsnd))
            fmod_studio_event_instance_start(superjumpsnd);
    }
    else
        fmod_studio_event_instance_stop(superjumpsnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    
    if ((_playerstate != states.freefall && _playerstate != states.freefall) || sprite_index == get_charactersprite("spr_Sjumpcancelstart"))
        fmod_studio_event_instance_stop(groundpoundsnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    else if (!fmod_studio_event_instance_is_playing(groundpoundsnd))
        fmod_studio_event_instance_start(groundpoundsnd);
    
    if ((state != states.handstandjump && state != states.kungfu && state != states.zombieattack && state != states.climbwall) || (state == states.climbwall && sprite_index != get_charactersprite("spr_climbwalldash")))
        fmod_studio_event_instance_stop(grabsnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    
    if (sprite_index != get_charactersprite("spr_mach2jump") && sprite_index != get_charactersprite("spr_faceplant"))
        fmod_studio_event_instance_stop(mach2jumpsnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    else if (!fmod_studio_event_instance_is_playing(mach2jumpsnd))
        fmod_studio_event_instance_start(mach2jumpsnd);
}
