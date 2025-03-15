#region Flags for Excluding specific types of Collision Object.
enum Exclude {
	NONE = 0, 
	SLOPES = 1,
	SOLIDS = 2,
	MOVING = 4,
	PLATFORMS = 8,
	ALL = 15 
}
#endregion

// Create DS_list for collisions
global.MyCollisionList = ds_list_create();

function slope_check(xx, yy)
{
    return place_meeting_slope(xx, yy, false) || place_meeting_slopePlatform(xx, yy);
}

// custom func
function place_meeting_collision(xx, yy, exclude = Exclude.NONE)
{
    // Exclude specific types of collisions
	var 
	check_slopes = Exclude.SLOPES&exclude != Exclude.SLOPES,
	check_solids = Exclude.SOLIDS&exclude != Exclude.SOLIDS,
	check_platforms = Exclude.PLATFORMS&exclude != Exclude.PLATFORMS,
	check_moving = Exclude.MOVING&exclude != Exclude.MOVING;
    
    if (check_solids)
    {
        if (place_meeting_solid(xx, yy))
            return true;
        
        if (place_meeting_slopeSolid(xx, yy))
            return true;
    }
    
    if (check_slopes)
    {
        if (check_solids)
        {
            if (place_meeting_slope(xx, yy, false))
                return true;
            
            if (place_meeting_roundSlope(xx, yy))
                return true;
        }
        
        if (check_platforms)
        {
            if (place_meeting_slopePlatform(xx, yy))
                return true;
        }
    }
    
    if (check_platforms)
    {
        if (place_meeting_platform(xx, yy))
            return true;
        
        if (place_meeting_sidePlatform(xx, yy))
            return true;
    }
    
    if (check_moving)
    {
        if (place_meeting_movingPlatform(xx, yy))
            return true;
    }
    
    return false;
}

#region Collisions
/// @desc With this function you can check a place for collision objects. 
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {ID.DsList} list The DS list to use to store the IDs of colliding platforms.
/// @param {real} [exclude] Using the EXLCUDE flags you can exclude types of objects. Ex: (Exclude.SLOPES|Exclude.PLATFORMS). You can also invert it like so: (~Exclude.MOVING).
/// @returns {real} The number of instances found to be in collision.
function instance_place_list_collision(xx, yy, list = undefined, exclude = Exclude.NONE)
{
    var collided = 0;
	// Exclude specific types of collisions
	var 
	check_slopes = Exclude.SLOPES&exclude != Exclude.SLOPES,
	check_solids = Exclude.SOLIDS&exclude != Exclude.SOLIDS,
	check_platforms = Exclude.PLATFORMS&exclude != Exclude.PLATFORMS,
	check_moving = Exclude.MOVING&exclude != Exclude.MOVING;

	
	if (check_solids) { // Basic Solid Collisions and Backside of Slopes
		collided += instance_place_list_solid(xx, yy, list);
	}
	
	if (check_slopes) { // Sloped Collisions
		
		if (check_solids) {
			collided += instance_place_list_slope(xx, yy, list);
		}
		
		if (check_platforms) {
			collided += instance_place_list_slopePlatform(xx, yy, list);		
		}
	}
	if (check_platforms) { // Semisolid Collisions
		collided += instance_place_list_platform(xx, yy, list);
		collided += instance_place_list_sidePlatform(xx, yy, list);
	}
	if (check_moving) { // Moving Platforms
		collided += instance_place_list_movingPlatform(xx, yy, list);
	}
	return collided;
}

#endregion
#region Solids

/// @desc With this function you can check a place for basic solid collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {ID.DsList} [list] The DS list to use to store the IDs of colliding solids. (Optional)
/// @returns {real} The number of instances found to be in collision.
function instance_place_list_solid(xx, yy, list = undefined)
{
    if (place_meeting(xx, yy, obj_solid))
    { // Basic Solids		
		var solid_number = instance_place_list(xx, yy, obj_solid, global.MyCollisionList, false);
		var collided = 0;
		if (solid_number > 0) {
			for (var i = 0; i < solid_number; ++i;) {
				var solid_object = (global.MyCollisionList[| i]);
				
				var _can_collide = true;
				if (variable_instance_exists(solid_object, "canCollide")) {
					_can_collide = solid_object.canCollide(object_index);
				}
				
				if (_can_collide == true) {				
					collided++;
					if (!is_undefined(list)) { // Add to List
						ds_list_add(list, solid_object.id);
					} else {
						break;
					}
				}	
			}
		}
		ds_list_clear(global.MyCollisionList);
		if (collided > 0) {	
			return (collided);
		}		
	}	
	return 0;
}

/// @desc With this function you can check a place for basic solid collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @returns {bool}
function place_meeting_solid(xx, yy) {
	return (instance_place_list_solid(xx, yy) > 0);
}

#endregion

/// @desc With this function you can check a place for platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {ID.DsList} [list] The DS list to use to store the IDs of colliding platforms. (Optional)
/// @returns {real} The number of instances found to be in collision.
function instance_place_list_platform(xx, yy, list = undefined)
{
    var collided = 0;
	if (place_meeting(xx, yy, obj_platform)) { // Basic platforms		
		var platform_number = instance_place_list(xx, yy, obj_platform, global.MyCollisionList, false);
		if (platform_number > 0) {
			for (var i = 0; i < platform_number; ++i;) {
				var platform_object = (global.MyCollisionList[| i]);
				
				var _can_collide = true;
                if (variable_instance_exists(platform_object, "canCollide"))
                    _can_collide = platform_object.canCollide(object_index);
                
                var _check = (sign(platform_object.image_yscale) <= -1 ? yy <= y : yy > y);
                // custom
                if (object_index == obj_player)
                {
                    if (_check == true && _can_collide && place_meeting(xx, yy, platform_object) && !place_meeting(xx, y, platform_object))
                    {
                        collided++;
                        if (!is_undefined(list)) // Add to list
                            ds_list_add(list, platform_object.id);
                        else
                            break;
                    }
                }
				// normal
                else if (_check == true && _can_collide && place_meeting(xx, yy, platform_object) && !place_meeting(xx, y, platform_object)) {			
					collided++;
					if (!is_undefined(list)) { // Add to List
						ds_list_add(list, platform_object.id);
					} else {
						break;
					}
				}	
			}
		}
		ds_list_clear(global.MyCollisionList);
		if (collided > 0) {	
			return (collided);
		}		
	}	
	return 0;
}

/// @desc With this function you can check a place for side platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {ID.DsList} [list] The DS list to use to store the IDs of colliding platforms. (Optional)
/// @returns {real} The number of instances found to be in collision.
function instance_place_list_sidePlatform(xx, yy, list = undefined) {
	var collided = 0;
	if (place_meeting(xx, yy, obj_sidePlatform)) { // Basic Side Platforms		
		var side_platform_number = instance_place_list(xx, yy, obj_sidePlatform, global.MyCollisionList, false);
		if (side_platform_number > 0) {
			for (var i = 0; i < side_platform_number; ++i;) {
				var side_platform_object = (global.MyCollisionList[| i]);
				
				var _can_collide = true;
				if (variable_instance_exists(side_platform_object, "canCollide")) {
					_can_collide = side_platform_object.canCollide(object_index);
				}
				var _check = (sign(side_platform_object.image_xscale) < 0 ? xx >= x : xx <= x);			
				if (_check == true && _can_collide && place_meeting(xx, yy, side_platform_object) && !place_meeting(x, yy, side_platform_object)) {			
					collided++;
					if (!is_undefined(list)) { // Add to List
						ds_list_add(list, side_platform_object.id);
					} else {
						break;
					}
				}	
			}
		}
		ds_list_clear(global.MyCollisionList);
		if (collided > 0) {	
			return (collided);
		}		
	}	
	return 0;
}

/// @desc With this function you can check a place for platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @returns {bool}
function place_meeting_platform(xx, yy) {
	return (instance_place_list_platform(xx, yy) > 0);
}

/// @desc With this function you can check a place for side platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @returns {bool}
function place_meeting_sidePlatform(xx, yy) {
	return (instance_place_list_sidePlatform(xx, yy) > 0);
}

/// @desc With this function you can check a place for moving platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject|Id.Instance} [obj] The object to check for. (Optional)
/// @param {ID.DsList} [list] The DS list to use to store the IDs of colliding moving platforms. (Optional)
/// @returns {real} The number of instances found to be in collision.
function instance_place_list_movingPlatform(xx, yy, list = undefined) {
	var collided = 0;
	if (place_meeting(xx, yy, obj_movingPlatform)) { // Basic moving Platforms		
		var movingplatform_number = instance_place_list(xx, yy, obj_movingPlatform, global.MyCollisionList, false);
		if (movingplatform_number > 0) {
			for (var i = 0; i < movingplatform_number; ++i;) {
				var movingplatform_object = (global.MyCollisionList[| i]);
				
				var _can_collide = true;
				if (variable_instance_exists(movingplatform_object, "canCollide")) {
					_can_collide = movingplatform_object.canCollide(object_index);
				}
				var _check = (sign(movingplatform_object.image_yscale) <= -1 ? yy <= y : yy > y);			
				if (_check == true && _can_collide && place_meeting(xx, yy, movingplatform_object) && !place_meeting(xx, y, movingplatform_object)) {			
					collided++;
					if (!is_undefined(list)) { // Add to List
						ds_list_add(list, movingplatform_object.id);
					} else {
						break;
					}
				}	
			}
		}
		ds_list_clear(global.MyCollisionList);
		if (collided > 0) {	
			return (collided);
		}		
	}	
	return 0;
}
/// @desc With this function you can check a place for moving platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @returns {bool}
function place_meeting_movingPlatform(xx, yy)
{
    return instance_place_list_movingPlatform(xx, yy) > 0;
}
/// @desc With this function you can check a place for sloped platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {ID.DsList} [list] The DS list to use to store the IDs of colliding sloped platforms. (Optional)
/// @returns {real} The number of instances found to be in collision.
function instance_place_list_slopePlatform(xx, yy, list = undefined) {
	var old_x = x;
	var old_y = y;
	var old_bbox_top = bbox_top;
	var old_bbox_bottom = bbox_bottom;	
	x = xx;
	y = yy;
	
	var collided = 0;
	if (place_meeting(x, y, obj_slopePlatform)) { // Basic sloped Platforms		
		var slopeplatform_number = instance_place_list(x, y, obj_slopePlatform, global.MyCollisionList, false);
		if (slopeplatform_number > 0) {
			for (var i = 0; i < slopeplatform_number; ++i;) {
				var slopeplatform_object = (global.MyCollisionList[| i]);
				
				var _can_collide = true;
				if (variable_instance_exists(slopeplatform_object, "canCollide")) {
					_can_collide = slopeplatform_object.canCollide(object_index);
				}
				
				if (_can_collide) {			
					#region Checks
					var object_side =  slopeplatform_object.image_xscale > 0 ? bbox_right : bbox_left;
					object_side = (object_side - x) + old_x;
					
					var player_pos = point_direction(slopeplatform_object.x + slopeplatform_object.sprite_width, slopeplatform_object.y + slopeplatform_object.sprite_height, x, y);
					
					
					var _check1;
					if (slopeplatform_object.image_yscale > 0) {
						_check1 = slopeplatform_object.image_xscale > 0 ? (player_pos <= 180 && player_pos >= 90) : (player_pos <= 90 && player_pos >= 0);
					} else {
						_check1 = slopeplatform_object.image_xscale > 0 ? (player_pos <= 270 && player_pos >= 180) : ((player_pos <= 360 || player_pos <= 0) && player_pos >= 270);
					}
					
					var _check2 = !triangle_meeting(old_x, old_y, slopeplatform_object.x, slopeplatform_object.y + slopeplatform_object.sprite_height, slopeplatform_object.x + slopeplatform_object.sprite_width, slopeplatform_object.y, slopeplatform_object.x + slopeplatform_object.sprite_width, slopeplatform_object.y + slopeplatform_object.sprite_height);
					var _check3 = (slopeplatform_object.image_xscale > 0 ? object_side <= slopeplatform_object.bbox_left : object_side >= slopeplatform_object.bbox_right);
					#endregion
					if (_check1 && (_check2 || _check3) && (slopeplatform_object.image_yscale > 0 ? old_bbox_bottom <= slopeplatform_object.bbox_bottom : old_bbox_top >= slopeplatform_object.bbox_top) && triangle_meeting(x, y, slopeplatform_object.x, slopeplatform_object.y + slopeplatform_object.sprite_height, slopeplatform_object.x + slopeplatform_object.sprite_width, slopeplatform_object.y, slopeplatform_object.x + slopeplatform_object.sprite_width, slopeplatform_object.y + slopeplatform_object.sprite_height)) {
						collided++;
						if (!is_undefined(list)) { // Add to List
							ds_list_add(list, slopeplatform_object.id);
						} else {
							break;
						}
					}						

				}	
			}
		}
		ds_list_clear(global.MyCollisionList);
		if (collided > 0) {	
			x = old_x;
			y = old_y;			
			return (collided);
		}		
	}	
	x = old_x;
	y = old_y;	
	return 0;
}

/// @desc With this function you can check a place for sloped platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @returns {bool}
function place_meeting_slopePlatform(xx, yy) {
	return (instance_place_list_slopePlatform(xx, yy) > 0);
}

/// @desc With this function you can check a place for slope collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {ID.DsList} [list] The DS list to use to store the IDs of colliding slopes. (Optional)
/// @returns {real} The number of instances found to be in collision.
function instance_place_list_slope(xx, yy, list = undefined) {
	if (place_meeting(xx, yy, obj_slope)) { // Basic slopes		
		var slope_number = instance_place_list(xx, yy, obj_slope, global.MyCollisionList, false);
		var collided = 0;
		if (slope_number > 0) {
			for (var i = 0; i < slope_number; ++i;) {
				var slope_object = (global.MyCollisionList[| i]);
				
				var _can_collide = true;
				if (variable_instance_exists(slope_object, "canCollide")) {
					_can_collide = slope_object.canCollide(object_index);
				}
				
				if (_can_collide == true && triangle_meeting(xx, yy, slope_object.x, slope_object.y + slope_object.sprite_height, slope_object.x + slope_object.sprite_width, slope_object.y, slope_object.x + slope_object.sprite_width, slope_object.y + slope_object.sprite_height)) {				
					collided++;
					if (!is_undefined(list)) { // Add to List
						ds_list_add(list, slope_object.id);
					} else {
						break;
					}
				}	
			}
		}
		ds_list_clear(global.MyCollisionList);
		if (collided > 0) {	
			return (collided);
		}		
	}	
	return 0;
}

/// @desc With this function you can check a place for slope collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {bool} [check_slopePlatform] Toggle to check for Sloped Platforms.
/// @returns {bool}
function place_meeting_slope(xx, yy, check_slopePlatform = true) {
	var _check2 = (check_slopePlatform ? place_meeting_slopePlatform(xx, yy) : false);
	return (instance_place_list_slope(xx, yy) > 0 || _check2);
}

// custom one for round slopes
function instance_place_list_roundSlope(xx, yy, list = undefined)
{
    if (place_meeting(xx, yy, obj_roundSlope))
    {
        var slope_number = instance_place_list(xx, yy, obj_roundSlope, global.MyCollisionList, false);
        var collided = 0;
        
        if (slope_number > 0)
        {
            for (var i = 0; i < slope_number; i++)
            {
                var slope_object = (global.MyCollisionList[| i]);
                var _can_collide = true;
                
                if (variable_instance_exists(slope_object, "canCollide"))
                    _can_collide = slope_object.canCollide(object_index);
                
                if (_can_collide == true)
                {
                    collided++;
                    
                    if (!is_undefined(list))
                        ds_list_add(list, slope_object.id);
                    else
                        break;
                }
            }
        }
        
        ds_list_clear(global.MyCollisionList);
        
        if (collided > 0)
            return collided;
    }
    
    return 0;
}

function place_meeting_roundSlope(xx, yy)
{
    return instance_place_list_roundSlope(xx, yy) > 0;
}

function place_meeting_slopeSolid(xx, yy)
{
    if (place_meeting(xx, yy, obj_slope))
    {
        var slope_number = instance_place_list(xx, yy, obj_slope, global.MyCollisionList, false);
        var collided = 0;
        
        if (slope_number > 0)
        {
            for (var i = 0; i < slope_number; i++)
            {
                var slope_object = (global.MyCollisionList[| i]);
                var _can_collide = true;
                
                if (variable_instance_exists(slope_object, "canCollide"))
                    _can_collide = slope_object.canCollide(object_index);
                
                var _xscale = xx - x;
                
                if (_can_collide == true && (sign(slope_object.image_xscale) != _xscale && _xscale != 0) && triangle_meeting(xx, yy, slope_object.x, slope_object.y + slope_object.sprite_height, slope_object.x + slope_object.sprite_width, slope_object.y, slope_object.x + slope_object.sprite_width, slope_object.y + slope_object.sprite_height))
                {
                    collided++;
                    break;
                }
            }
        }
        
        ds_list_clear(global.MyCollisionList);
        
        if (collided > 0)
            return true;
    }
    
    return false;
}
