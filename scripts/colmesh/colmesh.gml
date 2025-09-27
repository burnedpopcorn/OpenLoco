enum Colmesh_shapes
{
	// shapes
	defaultmesh = 0,
	sphere = 1,
	capsule = 2,
	cylinder = 3,
	torus = 4,
	cube = 5,
	block = 6,
	dynamicmesh = 7,
	none = 8,
	disk = 9,
	
	// unfinished
	cone = 10,
	// unknown (and possibly unfinished shapes)
	unknown_mesh11 = 11,
	unknown_mesh12 = 12,
	
	// other shit
	uninitializedmesh = 13,
	enumlength = 14,
}

global.ColMeshCallingObject = -1;
global.ColMeshRecursionCounter = 0;
global.ColMeshRayMap = ds_map_create();
global.ColMeshMeshMap = ds_map_create();
global.ColMeshDefaultParent = new colmesh_mesh();
global.ColMeshDebugShapes = array_create(Colmesh_shapes.enumlength, -1);

function colmesh() : colmesh_mesh() constructor
{
    static subdivide = function(argument0)
    {
        var debugTime = get_timer();
        clearSubdiv();
        spHash = ds_map_create();
        regionSize = argument0;
        originX = (minimum[0] + maximum[0]) * 0.5;
        originY = (minimum[1] + maximum[1]) * 0.5;
        originZ = (minimum[2] + maximum[2]) * 0.5;
        shapeNum = ds_list_size(shapeList);
        
        for (var i = 0; i < shapeNum; i++)
            addShapeToSubdiv(shapeList[| i]);
        
        colmesh_debug_message("colmesh.subdivide: Generated spatial hash with " + string(ds_map_size(spHash)) + " regions in " + string((get_timer() - debugTime) / 1000) + " milliseconds");
    };
    
    static addShape = function(argument0)
    {
        if (is_struct(argument0))
        {
            if (argument0.type == Colmesh_shapes.defaultmesh)
            {
                var num = array_length(argument0.triangles);
                
                for (var i = 0; i < num; i++)
                {
                    var V = argument0.triangles[i];
                    
                    if (is_array(argument0.matrix))
                    {
                        tri = V;
                        V = array_create(9);
                        array_copy(V, 0, matrix_transform_vertex(argument0.matrix, tri[0], tri[1], tri[2]), 0, 3);
                        array_copy(V, 3, matrix_transform_vertex(argument0.matrix, tri[3], tri[4], tri[5]), 0, 3);
                        array_copy(V, 6, matrix_transform_vertex(argument0.matrix, tri[6], tri[7], tri[8]), 0, 3);
                    }
                    
                    var tri = addTriangle(V, argument0);
                }
                
                argument0.submeshes++;
                return argument0;
            }
            
            if (argument0.type == Colmesh_shapes.dynamicmesh)
                argument0.colMesh = self;
        }
        
        _expandBoundaries(_getShape(argument0).getMinMax());
        ds_list_add(shapeList, argument0);
        addShapeToSubdiv(argument0);
        shapeNum++;
        return argument0;
    };
    
    static addTrigger = function(argument0, argument1 = true, argument2 = undefined, argument3 = undefined)
    {
        addShape(argument0);
        argument0.setTrigger(argument1, argument2, argument3);
        return argument0;
    };
    
    static addDynamic = function(argument0, argument1)
    {
        return addShape(new colmesh_dynamic(argument0, argument1));
    };
    
    static addMesh = function(argument0, argument1)
    {
        var name = argument0;
        
        if (is_string(argument0))
            name = filename_name(argument0);
        
        if (is_struct(argument0))
        {
            argument0.matrix = argument1;
            return addShape(argument0);
        }
        
        return addShape(new colmesh_mesh(name, argument0, argument1));
    };
    
    static addTriangle = function(argument0, argument1 = global.ColMeshDefaultParent)
    {
        var nx = ((argument0[4] - argument0[1]) * (argument0[8] - argument0[2])) - ((argument0[5] - argument0[2]) * (argument0[7] - argument0[1]));
        var ny = ((argument0[5] - argument0[2]) * (argument0[6] - argument0[0])) - ((argument0[3] - argument0[0]) * (argument0[8] - argument0[2]));
        var nz = ((argument0[3] - argument0[0]) * (argument0[7] - argument0[1])) - ((argument0[4] - argument0[1]) * (argument0[6] - argument0[0]));
        var l = point_distance_3d(0, 0, 0, nx, ny, nz);
        
        if (l <= 0)
            return false;
        
        var tri = array_create(13);
        array_copy(tri, 0, argument0, 0, 9);
        tri[9] = nx / l;
        tri[10] = ny / l;
        tri[11] = nz / l;
        tri[12] = argument1 ?? global.ColMeshDefaultParent;
        addShape(tri);
        return tri;
    };
    
    static removeShape = function(argument0)
    {
        var ind = ds_list_find_index(shapeList, argument0);
        
        if (ind < 0)
            return false;
        
        removeShapeFromSubdiv(argument0);
        ds_list_delete(shapeList, ind);
        return true;
    };
    
    static addShapeToSubdiv = function(argument0, argument1 = undefined, argument2 = true)
    {
        if (spHash < 0)
            exit;
        
        var struct = _getShape(argument0);
        
        if (is_undefined(argument1))
            argument1 = _getRegions(struct.getMinMax());
        
        var xNum = argument1[3] - argument1[0];
        var yNum = argument1[4] - argument1[1];
        var zNum = argument1[5] - argument1[2];
        var xx = argument1[0];
        
        repeat (xNum)
        {
            xx++;
            var yy = argument1[1];
            var _x = ((xx + 0.5) * regionSize) + originX;
            
            repeat (yNum)
            {
                yy++;
                var zz = argument1[2];
                var _y = ((yy + 0.5) * regionSize) + originY;
                
                repeat (zNum)
                {
                    zz++;
                    var _z = ((zz + 0.5) * regionSize) + originZ;
                    
                    if (!argument2 || struct._intersectsCube(regionSize * 0.5, _x, _y, _z))
                    {
                        var key = colmesh_get_key(xx, yy, zz);
                        var list = spHash[? key];
                        
                        if (is_undefined(list))
                        {
                            list = ds_list_create();
                            spHash[? key] = list;
                        }
                        
                        ds_list_add(list, argument0);
                    }
                }
            }
        }
    };
    
    static removeShapeFromSubdiv = function(argument0, argument1 = undefined)
    {
        if (spHash < 0)
            return false;
        
        if (is_undefined(argument1))
            argument1 = _getRegions(_getShape(argument0).getMinMax());
        
        var xNum = argument1[3] - argument1[0];
        var yNum = argument1[4] - argument1[1];
        var zNum = argument1[5] - argument1[2];
        var xx = argument1[0];
        
        repeat (xNum)
        {
            xx++;
            var yy = argument1[1];
            
            repeat (yNum)
            {
                yy++;
                var zz = argument1[2];
                
                repeat (zNum)
                {
                    zz++;
                    var key = colmesh_get_key(xx, yy, zz);
                    var list = spHash[? key];
                    
                    if (is_undefined(list))
                        continue;
                    
                    var ind = ds_list_find_index(list, argument0);
                    
                    if (ind < 0)
                        continue;
                    
                    ds_list_delete(list, ind);
                    
                    if (ds_list_empty(list))
                    {
                        ds_list_destroy(list);
                        ds_map_delete(spHash, key);
                    }
                }
            }
        }
    };
    
    static clearSubdiv = function()
    {
        if (spHash >= 0)
        {
            var region = ds_map_find_first(spHash);
            
            while (!is_undefined(region))
            {
                ds_list_destroy(spHash[? region]);
                region = ds_map_find_next(spHash, region);
            }
            
            ds_map_destroy(spHash);
            spHash = -1;
        }
    };
    
    static clear = function()
    {
        clearSubdiv();
        minimum = [0, 0, 0];
        maximum = [0, 0, 0];
        ds_list_clear(tempList);
        ds_list_clear(shapeList);
        
        for (var i = 0; i < 8; i++)
        {
            if (priority[i] >= 0)
            {
                ds_priority_destroy(priority[i]);
                priority[i] = -1;
            }
            
            if (rayMap[i] >= 0)
            {
                ds_map_destroy(rayMap[i]);
                rayMap[i] = -1;
            }
        }
    };
    
    static destroy = function()
    {
        clear();
        ds_list_destroy(tempList);
        ds_list_destroy(shapeList);
    };
    
    static getRegion = function(argument0)
    {
        var minx = argument0[0];
        var miny = argument0[1];
        var minz = argument0[2];
        var maxx = argument0[3];
        var maxy = argument0[4];
        var maxz = argument0[5];
        
        if (minx > maximum[0] || miny > maximum[1] || minz > maximum[2] || maxx < minimum[0] || maxy < minimum[1] || maxz < minimum[2])
            return undefined;
        
        ds_list_clear(tempList);
        
        if (spHash < 0)
        {
            var i = ds_list_size(shapeList);
            
            repeat (i)
            {
                var shape = shapeList[| --i];
                
                if (!_getShape(shape).checkAABB(minx, miny, minz, maxx, maxy, maxz))
                    continue;
                
                ds_list_add(tempList, shape);
            }
            
            return tempList;
        }
        
        var regions = _getRegions(argument0);
        var xNum = regions[3] - regions[0];
        var yNum = regions[4] - regions[1];
        var zNum = regions[5] - regions[2];
        var xx = regions[0];
        
        repeat (xNum)
        {
            xx++;
            var yy = regions[1];
            
            repeat (yNum)
            {
                yy++;
                var zz = regions[2];
                
                repeat (zNum)
                {
                    zz++;
                    var key = colmesh_get_key(xx, yy, zz);
                    var region = spHash[? key];
                    
                    if (is_undefined(region))
                        continue;
                    
                    var i = ds_list_size(region);
                    
                    repeat (i)
                    {
                        var shape = region[| --i];
                        
                        if (ds_list_find_index(tempList, shape) >= 0)
                            continue;
                        
                        if (!_getShape(shape).checkAABB(minx, miny, minz, maxx, maxy, maxz))
                            continue;
                        
                        ds_list_add(tempList, shape);
                    }
                }
            }
        }
        
        return tempList;
    };
    
    static displaceCapsule = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8 = 0, argument9 = true, argument10 = false)
    {
        var precision = 2 * !argument9;
        var collider = new colmesh_collider_capsule(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, precision);
        collider.avoid(self);
        
        if (argument10)
        {
            global.ColMeshCallingObject = other;
            global.ColMeshRecursionCounter++;
            collider.executeColFunc();
            global.ColMeshRecursionCounter--;
        }
        
        return collider;
    };
    
    static regionDisplaceCapsule = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9 = 0, argument10 = true, argument11 = false)
    {
        var precision = 2 * !argument10;
        var collider = new colmesh_collider_capsule(argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, precision);
        collider.avoidRegion(self, argument0);
        
        if (argument11)
        {
            global.ColMeshCallingObject = other;
            global.ColMeshRecursionCounter++;
            collider.executeColFunc();
            global.ColMeshRecursionCounter--;
        }
        
        return collider;
    };
    
    static capsuleCollision = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7)
    {
        var AABB = colmesh_capsule_get_AABB(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7);
        var region = getRegion(AABB);
        return colmesh__region_capsule_collision(region, argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7);
    };
    
    static regionCapsuleCollision = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8)
    {
        return colmesh__region_capsule_collision(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8);
    };
    
    static getNearestPoint = function(argument0, argument1, argument2)
    {
        var AABB = colmesh_capsule_get_AABB(argument0, argument1, argument2, 0, 0, 1, 0, 0);
        return regionGetNearestPoint(getRegion(AABB), argument0, argument1, argument2);
    };
    
    static regionGetNearestPoint = function(argument0, argument1, argument2, argument3)
    {
        static ret = array_create(3);
        
        if (argument0 < 0)
            return false;
        
        var i = ds_list_size(argument0);
        
        if (i == 0)
            return false;
        
        var minD = 9999999;
        ret[0] = argument1;
        ret[1] = argument2;
        ret[2] = argument3;
        
        repeat (i)
        {
            var shapeInd = abs(argument0[| --i]);
            var shape = _getShape(shapeList[| shapeInd]);
            var p = shape._getClosestPoint(argument1, argument2, argument3);
            var d = point_distance_3d(0, 0, 0, p[0] - argument1, p[1] - argument2, p[2] - argument3);
            
            if (d < minD)
            {
                minD = d;
                ret[0] = p[0];
                ret[1] = p[1];
                ret[2] = p[2];
            }
        }
        
        return ret;
    };
    
    static castRay = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6 = 1)
    {
        if (spHash < 0)
            return regionCastRay(shapeList, [argument0, argument1, argument2, argument3, argument4, argument5], argument6);
        
        var ray = [argument0, argument1, argument2, argument3, argument4, argument5];
        var rayStruct = new colmesh_raycast_result(argument3, argument4, argument5, 0, 0, 1, false, -1);
        
        if (!_constrain_ray(ray))
            return rayStruct;
        
        var map = rayMap[global.ColMeshRecursionCounter];
        
        if (map < 0)
        {
            map = ds_map_create();
            rayMap[global.ColMeshRecursionCounter] = map;
        }
        
        var ldx = ray[3] - ray[0];
        var ldy = ray[4] - ray[1];
        var ldz = ray[5] - ray[2];
        var idx = (ldx == 0) ? 0 : (1 / ldx);
        var idy = (ldy == 0) ? 0 : (1 / ldy);
        var idz = (ldz == 0) ? 0 : (1 / ldz);
        var incx = abs(idx) + (idx == 0);
        var incy = abs(idy) + (idy == 0);
        var incz = abs(idz) + (idz == 0);
        var ox = (ray[0] - originX) / regionSize;
        var oy = (ray[1] - originY) / regionSize;
        var oz = (ray[2] - originZ) / regionSize;
        var currX = ox;
        var currY = oy;
        var currZ = oz;
        var key = colmesh_get_key(floor(currX), floor(currY), floor(currZ));
        var prevKey = key;
        var t = 0;
        var _t = 0;
        
        while (t < 1)
        {
            var tMaxX = -frac(currX) * idx;
            var tMaxY = -frac(currY) * idy;
            var tMaxZ = -frac(currZ) * idz;
            
            if (tMaxX <= 0)
                tMaxX += incx;
            
            if (tMaxY <= 0)
                tMaxY += incy;
            
            if (tMaxZ <= 0)
                tMaxZ += incz;
            
            if (tMaxX < tMaxY)
            {
                if (tMaxX < tMaxZ)
                {
                    _t += tMaxX;
                    currX = round(ox + (ldx * _t));
                    currY = oy + (ldy * _t);
                    currZ = oz + (ldz * _t);
                    key = colmesh_get_key(currX - (ldx < 0), floor(currY), floor(currZ));
                }
                else
                {
                    _t += tMaxZ;
                    currX = ox + (ldx * _t);
                    currY = oy + (ldy * _t);
                    currZ = round(oz + (ldz * _t));
                    key = colmesh_get_key(floor(currX), floor(currY), currZ - (ldz < 0));
                }
            }
            else if (tMaxY < tMaxZ)
            {
                _t += tMaxY;
                currX = ox + (ldx * _t);
                currY = round(oy + (ldy * _t));
                currZ = oz + (ldz * _t);
                key = colmesh_get_key(floor(currX), currY - (ldy < 0), floor(currZ));
            }
            else
            {
                _t += tMaxZ;
                currX = ox + (ldx * _t);
                currY = oy + (ldy * _t);
                currZ = round(oz + (ldz * _t));
                key = colmesh_get_key(floor(currX), floor(currY), currZ - (ldz < 0));
            }
            
            t = min(1, _t * regionSize);
            var region = spHash[? prevKey];
            prevKey = key;
            
            if (is_undefined(region))
                continue;
            
            var i = ds_list_size(region);
            
            repeat (i)
            {
                var _shape = region[| --i];
                var shape = _getShape(_shape);
                
                if ((argument6 & shape.group) == 0)
                    continue;
                
                var hit = map[? _shape];
                
                if (is_undefined(hit))
                {
                    hit = shape._castRay(ray, argument6);
                    map[? _shape] = hit;
                }
                
                if (!is_array(hit))
                    continue;
                
                if (hit[7] >= t)
                    continue;
                
                array_push(rayStruct.intersections, hit);
                
                if ((shape.group & 1) == 0)
                    continue;
                
                t = hit[7];
                rayStruct.x = hit[0];
                rayStruct.y = hit[1];
                rayStruct.z = hit[2];
                rayStruct.nx = hit[3];
                rayStruct.ny = hit[4];
                rayStruct.nz = hit[5];
                rayStruct.hit = true;
            }
            
            if (rayStruct.hit)
                break;
        }
        
        ds_map_clear(map);
        return rayStruct;
    };
    
    static regionCastRay = function(argument0, argument1, argument2 = 1, argument3 = new colmesh_raycast_result(argument1[3], argument1[4], argument1[5], 0, 0, 1, false, -1))
    {
        if (is_undefined(argument0) || (argument1[0] == argument1[3] && argument1[1] == argument1[4] && argument1[2] == argument1[5]))
            return argument3;
        
        var firstHit = -1;
        var i = ds_list_size(argument0);
        
        repeat (i)
        {
            var shape = _getShape(argument0[| --i]);
            
            if ((argument2 & shape.group) == 0)
                continue;
            
            var hit = shape._castRay(argument1, argument2);
            
            if (!is_array(hit))
                continue;
            
            array_push(argument3.intersections, hit);
            
            if ((shape.group & 1) == 0)
                continue;
            
            array_copy(argument1, 3, hit, 0, 3);
            argument3.x = hit[0];
            argument3.y = hit[1];
            argument3.z = hit[2];
            argument3.nx = hit[3];
            argument3.ny = hit[4];
            argument3.nz = hit[5];
            argument3.hit = true;
        }
        
        return argument3;
    };
    
    static _expandBoundaries = function(argument0)
    {
        if (shapeNum == 0)
        {
            minimum[0] = argument0[0];
            minimum[1] = argument0[1];
            minimum[2] = argument0[2];
            maximum[0] = argument0[3];
            maximum[1] = argument0[4];
            maximum[2] = argument0[5];
            exit;
        }
        
        minimum[0] = min(minimum[0], argument0[0]);
        minimum[1] = min(minimum[1], argument0[1]);
        minimum[2] = min(minimum[2], argument0[2]);
        maximum[0] = max(maximum[0], argument0[3]);
        maximum[1] = max(maximum[1], argument0[4]);
        maximum[2] = max(maximum[2], argument0[5]);
    };
    
    static _getShape = function(argument0)
    {
        if (is_array(argument0))
        {
            var parent = argument0[12];
            parent.triangle = argument0;
            return parent;
        }
        
        return argument0;
    };
    
    static _constrain_ray = function(argument0)
    {
        var sx = (maximum[0] - minimum[0]) * 0.5;
        var sy = (maximum[1] - minimum[1]) * 0.5;
        var sz = (maximum[2] - minimum[2]) * 0.5;
        var mx = (maximum[0] + minimum[0]) * 0.5;
        var my = (maximum[1] + minimum[1]) * 0.5;
        var mz = (maximum[2] + minimum[2]) * 0.5;
        var x1 = (argument0[0] - mx) / sx;
        var y1 = (argument0[1] - my) / sy;
        var z1 = (argument0[2] - mz) / sz;
        var x2 = (argument0[3] - mx) / sx;
        var y2 = (argument0[4] - my) / sy;
        var z2 = (argument0[5] - mz) / sz;
        var _min = min(x1, y1, z1, x2, y2, z2);
        var _max = max(x1, y1, z1, x2, y2, z2);
        
        if (_min >= -1 && _max <= 1)
            return true;
        
        if (_min < -1 || _max > 1)
        {
            if ((x1 < -1 && x2 < -1) || (y1 < -1 && y2 < -1) || (z1 < -1 && z2 < -1) || (x1 > 1 && x2 > 1) || (y1 > 1 && y2 > 1) || (z1 > 1 && z2 > 1))
                return false;
        }
        
        var d = x2 - x1;
        
        if (d != 0)
        {
            var s = sign(d);
            var t = (-s - x1) / d;
            
            if (t >= 0 && t <= 1)
            {
                var itsY = lerp(y1, y2, t);
                var itsZ = lerp(z1, z2, t);
                
                if (abs(itsY) <= 1 && abs(itsZ) <= 1)
                {
                    x1 = -s;
                    y1 = itsY;
                    z1 = itsZ;
                    d = x2 - x1;
                }
            }
            
            t = (s - x1) / d;
            
            if (t >= 0 && t <= 1)
            {
                var itsY = lerp(y1, y2, t);
                var itsZ = lerp(z1, z2, t);
                
                if (abs(itsY) <= 1 && abs(itsZ) <= 1)
                {
                    x2 = s;
                    y2 = itsY;
                    z2 = itsZ;
                }
            }
        }
        
        d = y2 - y1;
        
        if (d != 0)
        {
            var s = sign(d);
            var t = (-s - y1) / d;
            
            if (t >= 0 && t <= 1)
            {
                var itsX = lerp(x1, x2, t);
                var itsZ = lerp(z1, z2, t);
                
                if (abs(itsX) <= 1 && abs(itsZ) <= 1)
                {
                    x1 = itsX;
                    y1 = -s;
                    z1 = itsZ;
                    d = y2 - y1;
                }
            }
            
            t = (s - y1) / d;
            
            if (t >= 0 && t <= 1)
            {
                var itsX = lerp(x1, x2, t);
                var itsZ = lerp(z1, z2, t);
                
                if (abs(itsX) <= 1 && abs(itsZ) <= 1)
                {
                    x2 = itsX;
                    y2 = s;
                    z2 = itsZ;
                }
            }
        }
        
        d = z2 - z1;
        
        if (d != 0)
        {
            var s = sign(d);
            var t = (-s - z1) / d;
            
            if (t >= 0 && t <= 1)
            {
                var itsX = lerp(x1, x2, t);
                var itsY = lerp(y1, y2, t);
                
                if (abs(itsX) <= 1 && abs(itsY) <= 1)
                {
                    x1 = itsX;
                    y1 = itsY;
                    z1 = -s;
                    d = z2 - z1;
                }
            }
            
            t = (s - z1) / d;
            
            if (t >= 0 && t <= 1)
            {
                var itsX = lerp(x1, x2, t);
                var itsY = lerp(y1, y2, t);
                
                if (abs(itsX) <= 1 && abs(itsY) <= 1)
                {
                    x2 = itsX;
                    y2 = itsY;
                    z2 = s;
                }
            }
        }
        
        array_set(argument0, 0, (x1 * sx) + mx);
        array_set(argument0, 1, (y1 * sy) + my);
        array_set(argument0, 2, (z1 * sz) + mz);
        array_set(argument0, 3, (x2 * sx) + mx);
        array_set(argument0, 4, (y2 * sy) + my);
        array_set(argument0, 5, (z2 * sz) + mz);
        return true;
    };
    
    static save = function(argument0, argument1)
    {
        var buff = buffer_create(1, buffer_grow, 1);
        writeToBuffer(buff, argument1);
        buffer_resize(buff, buffer_tell(buff));
        buffer_save(buff, argument0);
        buffer_delete(buff);
    };
    
    static load = function(argument0)
    {
        var buff = buffer_load(argument0);
        
        if (buff < 0)
        {
            colmesh_debug_message("colmesh.load: Could not find file " + string(argument0));
            return false;
        }
        
        var success = readFromBuffer(buff);
        buffer_delete(buff);
        return success;
    };
    
    static writeToBuffer = function(argument0, argument1 = false)
    {
        var debugTime = current_time;
        var tempBuff = buffer_create(1, buffer_grow, 1);
        shapeNum = ds_list_size(shapeList);
        var meshMap = ds_map_create();
        var meshNames = [];
        buffer_write(tempBuff, buffer_u32, shapeNum);
        
        for (var i = 0; i < shapeNum; i++)
        {
            with (_getShape(shapeList[| i]))
            {
                if ((group & 1) == 0 && !argument1)
                {
                    buffer_write(tempBuff, buffer_u8, Colmesh_shapes.none);
                }
                else
                {
                    buffer_write(tempBuff, buffer_u8, type);
                    
                    switch (type)
                    {
                        case Colmesh_shapes.defaultmesh:
                            var index = meshMap[? name];
                            
                            if (is_undefined(index))
                            {
                                index = ds_map_size(meshMap);
                                meshMap[? name] = index;
                                array_push(meshNames, name);
                            }
                            
                            buffer_write(tempBuff, buffer_u32, index);
                            
                            for (var j = 0; j < 9; j++)
                                buffer_write(tempBuff, buffer_f32, triangle[j]);
                            
                            break;
                        
                        case Colmesh_shapes.sphere:
                            buffer_write(tempBuff, buffer_u32, group);
                            buffer_write(tempBuff, buffer_f32, x);
                            buffer_write(tempBuff, buffer_f32, y);
                            buffer_write(tempBuff, buffer_f32, z);
                            buffer_write(tempBuff, buffer_f32, R);
                            break;
                        
                        case Colmesh_shapes.capsule:
                            buffer_write(tempBuff, buffer_u32, group);
                            buffer_write(tempBuff, buffer_f32, x);
                            buffer_write(tempBuff, buffer_f32, y);
                            buffer_write(tempBuff, buffer_f32, z);
                            buffer_write(tempBuff, buffer_f32, xup);
                            buffer_write(tempBuff, buffer_f32, yup);
                            buffer_write(tempBuff, buffer_f32, zup);
                            buffer_write(tempBuff, buffer_f32, R);
                            buffer_write(tempBuff, buffer_f32, H);
                            break;
                        
                        case Colmesh_shapes.cylinder:
                            buffer_write(tempBuff, buffer_u32, group);
                            buffer_write(tempBuff, buffer_f32, x);
                            buffer_write(tempBuff, buffer_f32, y);
                            buffer_write(tempBuff, buffer_f32, z);
                            buffer_write(tempBuff, buffer_f32, xup);
                            buffer_write(tempBuff, buffer_f32, yup);
                            buffer_write(tempBuff, buffer_f32, zup);
                            buffer_write(tempBuff, buffer_f32, R);
                            buffer_write(tempBuff, buffer_f32, H);
                            break;
                        
                        case Colmesh_shapes.torus:
                            buffer_write(tempBuff, buffer_u32, group);
                            buffer_write(tempBuff, buffer_f32, x);
                            buffer_write(tempBuff, buffer_f32, y);
                            buffer_write(tempBuff, buffer_f32, z);
                            buffer_write(tempBuff, buffer_f32, xup);
                            buffer_write(tempBuff, buffer_f32, yup);
                            buffer_write(tempBuff, buffer_f32, zup);
                            buffer_write(tempBuff, buffer_f32, R);
                            buffer_write(tempBuff, buffer_f32, r);
                            break;
                        
                        case Colmesh_shapes.cube:
                            buffer_write(tempBuff, buffer_u32, group);
                            buffer_write(tempBuff, buffer_f32, x);
                            buffer_write(tempBuff, buffer_f32, y);
                            buffer_write(tempBuff, buffer_f32, z);
                            buffer_write(tempBuff, buffer_f32, halfW);
                            buffer_write(tempBuff, buffer_f32, halfL);
                            buffer_write(tempBuff, buffer_f32, halfH);
                            break;
                        
                        case Colmesh_shapes.block:
                            buffer_write(tempBuff, buffer_u32, group);
                            buffer_write(tempBuff, buffer_f32, M[0]);
                            buffer_write(tempBuff, buffer_f32, M[1]);
                            buffer_write(tempBuff, buffer_f32, M[2]);
                            buffer_write(tempBuff, buffer_f32, M[4]);
                            buffer_write(tempBuff, buffer_f32, M[5]);
                            buffer_write(tempBuff, buffer_f32, M[6]);
                            buffer_write(tempBuff, buffer_f32, M[8]);
                            buffer_write(tempBuff, buffer_f32, M[9]);
                            buffer_write(tempBuff, buffer_f32, M[10]);
                            buffer_write(tempBuff, buffer_f32, M[12]);
                            buffer_write(tempBuff, buffer_f32, M[13]);
                            buffer_write(tempBuff, buffer_f32, M[14]);
                            break;
                    }
                }
            }
        }
        
        if (spHash >= 0)
        {
            buffer_write(tempBuff, buffer_u32, ds_map_size(spHash));
            buffer_write(tempBuff, buffer_f32, regionSize);
            buffer_write(tempBuff, buffer_f32, originX);
            buffer_write(tempBuff, buffer_f32, originY);
            buffer_write(tempBuff, buffer_f32, originZ);
            var key = ds_map_find_first(spHash);
            
            while (!is_undefined(key))
            {
                var region = spHash[? key];
                num = ds_list_size(region);
                var n = num;
                buffer_write(tempBuff, buffer_u64, key);
                var numPos = buffer_tell(tempBuff);
                buffer_write(tempBuff, buffer_u32, num);
                
                repeat (n)
                {
                    var shapeInd = region[| --n];
                    buffer_write(tempBuff, buffer_u32, ds_list_find_index(shapeList, shapeInd));
                }
                
                buffer_poke(tempBuff, numPos, buffer_u32, num);
                key = ds_map_find_next(spHash, key);
            }
        }
        else
        {
            buffer_write(tempBuff, buffer_u32, 0);
        }
        
        var buffSize = buffer_tell(tempBuff);
        buffer_write(argument0, buffer_string, "ColMesh v4");
        var num = ds_map_size(meshMap);
        buffer_write(argument0, buffer_u32, num);
        
        for (var i = 0; i < num; i++)
        {
            var identifier = meshNames[i];
            buffer_write(argument0, buffer_string, identifier);
            buffer_write(argument0, buffer_u32, global.ColMeshMeshMap[? identifier].group);
        }
        
        buffer_write(argument0, buffer_u64, buffSize);
        buffer_copy(tempBuff, 0, buffSize, argument0, buffer_tell(argument0));
        buffer_seek(argument0, buffer_seek_relative, buffSize);
        colmesh_debug_message("Script colmesh.writeToBuffer: Wrote colmesh to buffer in " + string(current_time - debugTime) + " milliseconds");
        buffer_delete(tempBuff);
    };
    
    static readFromBuffer = function(argument0)
    {
        var debugTime = current_time;
        clear();
        var version = 4;
        var headerText = buffer_read(argument0, buffer_string);
        
        if (headerText != "ColMesh v4")
        {
            show_debug_message("Error in script readFromBuffer: Trying to load deprecated version cache");
            return false;
        }
        
        var num = buffer_read(argument0, buffer_u32);
        var meshNames = array_create(num);
        var debugString = "colmesh.readFromBuffer mesh names: ";
        
        for (var i = 0; i < num; i++)
        {
            var identifier = buffer_read(argument0, buffer_string);
            var group = buffer_read(argument0, buffer_u32);
            var a = new colmesh_mesh(identifier, undefined, undefined, group);
            meshNames[i] = identifier;
            debugString += identifier;
            
            if (i < (num - 1))
                debugString += ", ";
        }
        
        colmesh_debug_message(debugString);
        var buffSize = buffer_read(argument0, buffer_u64);
        var tempBuff = buffer_create(buffSize, buffer_fixed, 1);
        buffer_copy(argument0, buffer_tell(argument0), buffSize, tempBuff, 0);
        buffer_seek(argument0, buffer_seek_relative, buffSize);
        num = buffer_read(tempBuff, buffer_u32);
        
        for (var i = 0; i < num; i++)
        {
            var type = buffer_read(tempBuff, buffer_u8);
            
            switch (type)
            {
                case Colmesh_shapes.defaultmesh:
                    var index = buffer_read(tempBuff, buffer_u32);
                    var parent = global.ColMeshMeshMap[? array_get(meshNames, index)];
                    var V = array_create(9);
                    
                    for (var j = 0; j < 9; j++)
                        V[j] = buffer_read(tempBuff, buffer_f32);
                    
                    addTriangle(V, parent);
                    break;
                
                case Colmesh_shapes.sphere:
                    var group = buffer_read(tempBuff, buffer_u32);
                    var _x = buffer_read(tempBuff, buffer_f32);
                    var _y = buffer_read(tempBuff, buffer_f32);
                    var _z = buffer_read(tempBuff, buffer_f32);
                    var R = buffer_read(tempBuff, buffer_f32);
                    addShape(new colmesh_sphere(_x, _y, _z, R, group));
                    break;
                
                case Colmesh_shapes.capsule:
                    var group = buffer_read(tempBuff, buffer_u32);
                    var _x = buffer_read(tempBuff, buffer_f32);
                    var _y = buffer_read(tempBuff, buffer_f32);
                    var _z = buffer_read(tempBuff, buffer_f32);
                    var xup = buffer_read(tempBuff, buffer_f32);
                    var yup = buffer_read(tempBuff, buffer_f32);
                    var zup = buffer_read(tempBuff, buffer_f32);
                    var R = buffer_read(tempBuff, buffer_f32);
                    var H = buffer_read(tempBuff, buffer_f32);
                    addShape(new colmesh_capsule(_x, _y, _z, xup, yup, zup, R, H, group));
                    break;
                
                case Colmesh_shapes.cylinder:
                    var group = buffer_read(tempBuff, buffer_u32);
                    var _x = buffer_read(tempBuff, buffer_f32);
                    var _y = buffer_read(tempBuff, buffer_f32);
                    var _z = buffer_read(tempBuff, buffer_f32);
                    var xup = buffer_read(tempBuff, buffer_f32);
                    var yup = buffer_read(tempBuff, buffer_f32);
                    var zup = buffer_read(tempBuff, buffer_f32);
                    var R = buffer_read(tempBuff, buffer_f32);
                    var H = buffer_read(tempBuff, buffer_f32);
                    addShape(new colmesh_cylinder(_x, _y, _z, xup, yup, zup, R, H, group));
                    break;
                
                case Colmesh_shapes.torus:
                    var group = buffer_read(tempBuff, buffer_u32);
                    var _x = buffer_read(tempBuff, buffer_f32);
                    var _y = buffer_read(tempBuff, buffer_f32);
                    var _z = buffer_read(tempBuff, buffer_f32);
                    var xup = buffer_read(tempBuff, buffer_f32);
                    var yup = buffer_read(tempBuff, buffer_f32);
                    var zup = buffer_read(tempBuff, buffer_f32);
                    var R = buffer_read(tempBuff, buffer_f32);
                    var r = buffer_read(tempBuff, buffer_f32);
                    addShape(new colmesh_torus(_x, _y, _z, xup, yup, zup, R, r, group));
                    break;
                
                case Colmesh_shapes.cube:
                    var group = buffer_read(tempBuff, buffer_u32);
                    var _x = buffer_read(tempBuff, buffer_f32);
                    var _y = buffer_read(tempBuff, buffer_f32);
                    var _z = buffer_read(tempBuff, buffer_f32);
                    var halfW = buffer_read(tempBuff, buffer_f32);
                    var halfL = buffer_read(tempBuff, buffer_f32);
                    var halfH = buffer_read(tempBuff, buffer_f32);
                    addShape(new colmesh_cube(_x, _y, _z, halfW * 2, halfW * 2, halfH * 2, group));
                    break;
                
                case Colmesh_shapes.block:
                    var group = buffer_read(tempBuff, buffer_u32);
                    var M = array_create(16);
                    M[0] = buffer_read(tempBuff, buffer_f32);
                    M[1] = buffer_read(tempBuff, buffer_f32);
                    M[2] = buffer_read(tempBuff, buffer_f32);
                    M[4] = buffer_read(tempBuff, buffer_f32);
                    M[5] = buffer_read(tempBuff, buffer_f32);
                    M[6] = buffer_read(tempBuff, buffer_f32);
                    M[8] = buffer_read(tempBuff, buffer_f32);
                    M[9] = buffer_read(tempBuff, buffer_f32);
                    M[10] = buffer_read(tempBuff, buffer_f32);
                    M[12] = buffer_read(tempBuff, buffer_f32);
                    M[13] = buffer_read(tempBuff, buffer_f32);
                    M[14] = buffer_read(tempBuff, buffer_f32);
                    M[15] = 1;
                    addShape(new colmesh_block(M, group));
                    break;
                
                case Colmesh_shapes.none:
                    addShape(new colmesh_none());
                    break;
                
                case Colmesh_shapes.dynamicmesh:
                    addShape(new colmesh_none());
                    break;
            }
        }
        
        num = buffer_read(tempBuff, buffer_u32);
        
        if (num >= 0)
        {
            regionSize = buffer_read(tempBuff, buffer_f32);
            originX = buffer_read(tempBuff, buffer_f32);
            originY = buffer_read(tempBuff, buffer_f32);
            originZ = buffer_read(tempBuff, buffer_f32);
            spHash = ds_map_create();
            
            repeat (num)
            {
                var region = ds_list_create();
                var key = buffer_read(tempBuff, buffer_u64);
                
                repeat (buffer_read(tempBuff, buffer_u32))
                {
                    var shape = shapeList[| buffer_read(tempBuff, buffer_u32)];
                    
                    if (is_struct(shape))
                    {
                        if (shape.type == Colmesh_shapes.dynamicmesh || shape.type == Colmesh_shapes.none)
                            continue;
                    }
                    
                    ds_list_add(region, shape);
                }
                
                spHash[? key] = region;
            }
        }
        
        colmesh_debug_message("Script colmesh.readFromBuffer: Read colmesh from buffer in " + string(current_time - debugTime) + " milliseconds");
        buffer_delete(tempBuff);
        return true;
    };
    
    static move3D = function(argument0, argument1, argument2)
    {
        return false;
    };
    
    static _getRegions = function(argument0)
    {
        static ret = array_create(6);
        
        ret[0] = floor((argument0[0] - originX) / regionSize) - 1;
        ret[1] = floor((argument0[1] - originY) / regionSize) - 1;
        ret[2] = floor((argument0[2] - originZ) / regionSize) - 1;
        ret[3] = ceil((argument0[3] - originX) / regionSize);
        ret[4] = ceil((argument0[4] - originY) / regionSize);
        ret[5] = ceil((argument0[5] - originZ) / regionSize);
        return ret;
    };
    
    static getMinMax = function()
    {
        static minMax = array_create(6);
        
        array_copy(minMax, 0, minimum, 0, 3);
        array_copy(minMax, 3, maximum, 0, 3);
        return minMax;
    };
    
    static _intersectsCube = function(argument0, argument1, argument2, argument3)
    {
        if (spHash < 0)
        {
            var i = ds_list_size(shapeList);
            
            repeat (i)
            {
                var shape = _getShape(shapeList[| --i]);
                
                if (shape._intersectsCube(argument0, argument1, argument2, argument3))
                    return true;
            }
            
            return false;
        }
        
        var regions = _getRegions(getMinMax());
        var xNum = regions[3] - regions[0];
        var yNum = regions[4] - regions[1];
        var zNum = regions[5] - regions[2];
        var xx = regions[0];
        
        repeat (xNum)
        {
            xx++;
            var yy = regions[1];
            
            repeat (yNum)
            {
                yy++;
                var zz = regions[2];
                
                repeat (zNum)
                {
                    zz++;
                    var key = colmesh_get_key(xx, yy, zz);
                    var region = spHash[? key];
                    
                    if (is_undefined(region))
                        continue;
                }
            }
        }
    };
    
    static debugDraw = function(argument0, argument1 = -1)
    {
        if (is_undefined(argument0))
            exit;
        
        if (argument0 < 0)
            argument0 = shapeList;
        
        var triVbuff = global.ColMeshDebugShapes[Colmesh_shapes.defaultmesh];
        
        if (triVbuff < 0)
        {
            global.ColMeshDebugShapes[Colmesh_shapes.defaultmesh] = vertex_create_buffer();
            triVbuff = global.ColMeshDebugShapes[Colmesh_shapes.defaultmesh];
        }
        
        if (global.ColMeshRecursionCounter == 0)
            vertex_begin(triVbuff, global.ColMeshFormat);
        
        var sh = shader_current();
        shader_set(sh_colmesh_debug);
        var n = ds_list_size(argument0);
        var W = matrix_get(2);
        
        for (var i = 0; i < n; i++)
        {
            var shape = argument0[| i];
            var t = ds_list_find_index(shapeList, shape);
            var alpha = 1 - ((t < 0) * 0.5);
            var col = make_color_hsv((t * 10) % 255, 255, 255 * alpha);
            
            if (is_array(shape))
            {
                var V = shape;
                var v1x, v1y, v1z, nx, ny, nz, v2x, v2y, v2z, v3x, v3y, v3z;
                
                if (global.ColMeshRecursionCounter > 0)
                {
                    var v = matrix_transform_vertex(W, V[0], V[1], V[2]);
                    v1x = v[0];
                    v1y = v[1];
                    v1z = v[2];
                    v = matrix_transform_vertex(W, V[3], V[4], V[5]);
                    v2x = v[0];
                    v2y = v[1];
                    v2z = v[2];
                    v = matrix_transform_vertex(W, V[6], V[7], V[8]);
                    v3x = v[0];
                    v3y = v[1];
                    v3z = v[2];
                    v = colmesh_matrix_transform_vector(W, V[9], V[10], V[11]);
                    nx = v[0];
                    ny = v[1];
                    nz = v[2];
                }
                else
                {
                    v1x = V[0];
                    v1y = V[1];
                    v1z = V[2];
                    v2x = V[3];
                    v2y = V[4];
                    v2z = V[5];
                    v3x = V[6];
                    v3y = V[7];
                    v3z = V[8];
                    nx = V[9];
                    ny = V[10];
                    nz = V[11];
                }
                
                vertex_position_3d(triVbuff, v1x, v1y, v1z);
                vertex_normal(triVbuff, nx, ny, nz);
                vertex_texcoord(triVbuff, 0, 0);
                vertex_color(triVbuff, col, 1);
                vertex_position_3d(triVbuff, v2x, v2y, v2z);
                vertex_normal(triVbuff, nx, ny, nz);
                vertex_texcoord(triVbuff, 1, 0);
                vertex_color(triVbuff, col, 1);
                vertex_position_3d(triVbuff, v3x, v3y, v3z);
                vertex_normal(triVbuff, nx, ny, nz);
                vertex_texcoord(triVbuff, 0, 1);
                vertex_color(triVbuff, col, 1);
            }
            else
            {
                shader_set_uniform_f(shader_get_uniform(sh_colmesh_debug, "u_color"), color_get_red(col) / 255, color_get_green(col) / 255, color_get_blue(col) / 255, 1);
                global.ColMeshRecursionCounter++;
                shape.debugDraw(argument1);
                global.ColMeshRecursionCounter--;
            }
        }
        
        if (global.ColMeshRecursionCounter == 0)
        {
            matrix_set(2, W);
            shader_set_uniform_f(shader_get_uniform(sh_colmesh_debug, "u_radius"), 0);
            shader_set_uniform_f(shader_get_uniform(sh_colmesh_debug, "u_color"), 1, 1, 1, 1);
            vertex_end(triVbuff);
            vertex_submit(triVbuff, pr_trianglelist, argument1);
            shader_set(sh);
        }
    };
    
    static toString = function()
    {
        var str = "ColMesh with " + string(ds_list_size(shapeList)) + " shapes, and ";
        str += (ds_exists(spHash, ds_type_map) ? string(ds_map_size(spHash)) : "zero");
        str += " regions.";
        return str;
    };
    
    type = Colmesh_shapes.uninitializedmesh;
    spHash = -1;
    originX = 0;
    originY = 0;
    originZ = 0;
    regionSize = 0;
    tempList = ds_list_create();
    shapeNum = 0;
    minimum = [0, 0, 0];
    maximum = [0, 0, 0];
    priority = array_create(8, -1);
    rayMap = array_create(8, -1);
}