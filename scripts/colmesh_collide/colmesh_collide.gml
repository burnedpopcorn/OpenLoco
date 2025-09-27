function colmesh_raycast_result(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7) constructor
{
    static executeRayFunc = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7)
    {
        global.ColMeshCallingObject = other;
        var l = 0;
        
        if (is_array(ray))
            l = point_distance_3d(ray[0], ray[1], ray[2], x, y, z);
        
        var hitMap = ds_map_create();
        var exNum = 0;
        var i = array_length(intersections);
        
        repeat (i)
        {
            var intersection = intersections[--i];
            
            if (!is_struct(intersection[6]))
                continue;
            
            if ((intersection[6].group & 4) == 0)
                continue;
            
            if (!is_undefined(hitMap[? intersection]))
                continue;
            
            hitMap[? intersection] = true;
            
            if (point_distance_3d(intersection[0], intersection[1], intersection[2], x, y, z) > l)
                continue;
            
            intersection[6].rayFunc(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7);
        }
        
        ds_map_destroy(hitMap);
    };
    
    ray = -1;
    x = argument0;
    y = argument1;
    z = argument2;
    nx = argument3;
    ny = argument4;
    nz = argument5;
    hit = argument6;
    struct = argument7;
    intersections = [];
    t = 1;
}

function colmesh_colliders(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8) constructor
{
    static reset = function()
    {
        maxdp = -1;
        ground = false;
        collision = false;
        collisions = [];
        transformQueue = [];
        slope = (slopeAngle <= 0) ? 1 : dcos(slopeAngle);
    };
    
    static getDeltaMatrix = function()
    {
        var num = array_length(transformQueue);
        var i = 0;
        
        if (num > 1)
        {
            var M = transformQueue[i++];
            var pI = transformQueue[i++];
            var m = matrix_multiply(pI, M);
            
            repeat ((num / 2) - 1)
            {
                M = transformQueue[i++];
                pI = transformQueue[i++];
                m = matrix_multiply(matrix_multiply(pI, m), M);
            }
            
            return m;
        }
        
        return false;
    };
    
    static executeColFunc = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7)
    {
        if (global.ColMeshRecursionCounter == 0)
            global.ColMeshCallingObject = other;
        
        var executedStructs = [];
        var exNum = 0;
        var i = array_length(collisions);
        
        repeat (i)
        {
            var struct = collisions[--i];
            
            if ((struct.group & 2) == 0)
                continue;
            
            var j = array_length(executedStructs) - 1;
            
            repeat (j + 1)
            {
                if (struct == executedStructs[j--])
                    break;
            }
            
            if (j >= 0)
                continue;
            
            array_push(executedStructs, struct);
            struct.colFunc(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7);
        }
    };
    
    x = argument0;
    y = argument1;
    z = argument2;
    xup = argument3;
    yup = argument4;
    zup = argument5;
    nx = 0;
    ny = 0;
    nz = 1;
    slopeAngle = argument6;
    slope = 0;
    precision = argument7;
    mask = argument8;
    reset();
}

function colmesh_collider_capsule(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8 = 40, argument9 = 0, argument10 = 1) : colmesh_colliders(argument0, argument1, argument2, argument3, argument4, argument5, argument8, argument9, argument10) constructor
{
    static checkForCollision = function(argument0)
    {
        var AABB = colmesh_capsule_get_AABB(x, y, z, xup, yup, zup, (precision == 0) ? radius : (radius * 1.2), height);
        return checkForCollisionRegion(argument0, argument0.getRegion(AABB));
    };
    
    static checkForCollisionRegion = function(argument0, argument1)
    {
        var i = ds_list_size(argument1);
        
        repeat (i)
        {
            var col = _getShape(argument1[| --i]).capsuleCollision(x, y, z, xup, yup, zup, radius, height);
            
            if (col)
                return true;
        }
        
        return false;
    };
    
    static avoid = function(argument0, argument1 = mask)
    {
        var AABB = colmesh_capsule_get_AABB(x, y, z, xup, yup, zup, (precision == 0) ? radius : (radius * 1.2), height);
        return avoidRegion(argument0, argument0.getRegion(AABB), argument1);
    };
    
    static avoidRegion = function(argument0, argument1, argument2 = mask)
    {
        global.ColMeshCol = self;
        
        if (global.ColMeshRecursionCounter == 0)
            reset();
        
        if (is_undefined(argument1) || global.ColMeshRecursionCounter >= 8)
            return false;
        
        var p = [x, y, z];
        var P = argument0.priority[global.ColMeshRecursionCounter];
        
        if (P < 0 && precision > 0)
        {
            P = ds_priority_create();
            argument0.priority[global.ColMeshRecursionCounter] = P;
        }
        
        var i = ds_list_size(argument1);
        
        repeat (i)
        {
            var shapeInd = argument1[| --i];
            var shape = argument0._getShape(shapeInd);
            
            if ((argument2 & shape.group) == 0)
                continue;
            
            if ((shape.group & 1) == 0)
            {
                if (shape.capsuleCollision(x, y, z, xup, yup, zup, radius, height))
                    array_push(collisions, shape);
            }
            else
            {
                if (height != 0)
                    p = shape._capsuleGetRef(x, y, z, xup, yup, zup, height);
                
                if (precision == 0)
                {
                    if (shape._displaceSphere(self, p[0], p[1], p[2], radius))
                        array_push(collisions, shape);
                }
                else
                {
                    var pri = shape._getPriority(p[0], p[1], p[2], radius * 1.2);
                    
                    if (pri >= 0)
                        ds_priority_add(P, shapeInd, pri);
                }
            }
        }
        
        if (precision == 0)
            return collision;
        
        var colNum = ds_priority_size(P);
        var colOrder = array_create(colNum);
        i = colNum;
        
        repeat (colNum)
            colOrder[--i] = ds_priority_delete_min(P);
        
        var rep = 0;
        
        repeat (precision)
        {
            i = colNum;
            var remainingCollisions = 0;
            
            repeat (colNum)
            {
                var shape = argument0._getShape(colOrder[--i]);
                
                if (height != 0)
                    p = shape._capsuleGetRef(x, y, z, xup, yup, zup, height);
                
                if (shape._displaceSphere(self, p[0], p[1], p[2], radius))
                {
                    remainingCollisions++;
                    
                    if (rep == 0)
                        array_push(collisions, shape);
                }
            }
            
            if (remainingCollisions <= 1)
                break;
            
            rep++;
        }
        
        return collision;
    };
    
    static displace = function(argument0, argument1, argument2)
    {
        var d = point_distance_3d(argument0, argument1, argument2, 0, 0, 0);
        
        if (d == 0)
            return false;
        
        var dp = dot_product_3d(argument0, argument1, argument2, xup, yup, zup) / d;
        
        if (dp > maxdp)
        {
            nx = argument0 / d;
            ny = argument1 / d;
            nz = argument2 / d;
            maxdp = dp;
        }
        
        if (dp >= slope)
        {
            d /= dp;
            x += (xup * d);
            y += (yup * d);
            z += (zup * d);
            ground = true;
            slope = 1;
        }
        else
        {
            x += argument0;
            y += argument1;
            z += argument2;
        }
        
        collision = true;
        return true;
    };
    
    static transform = function(argument0, argument1)
    {
        var p = matrix_transform_vertex(argument0, x, y, z);
        x = p[0];
        y = p[1];
        z = p[2];
        var u = matrix_transform_vertex(argument0, xup * argument1, yup * argument1, zup * argument1);
        xup = u[0] - argument0[12];
        yup = u[1] - argument0[13];
        zup = u[2] - argument0[14];
        var n = matrix_transform_vertex(argument0, nx * argument1, ny * argument1, nz * argument1);
        nx = n[0] - argument0[12];
        ny = n[1] - argument0[13];
        nz = n[2] - argument0[14];
        radius /= argument1;
        height /= argument1;
    };
    
    radius = argument6;
    height = argument7;
}
