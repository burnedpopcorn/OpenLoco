function colmesh_shapes(argument0) constructor
{
    static setSolid = function(argument0)
    {
        if (argument0)
            group |= 1;
        else
            group &= -2;
    };
    
    static setTrigger = function(argument0, argument1, argument2)
    {
        setSolid(argument0);
        
        if (!is_undefined(argument1))
        {
            group |= 2;
            colFunc = argument1;
        }
        else
        {
            group &= -3;
        }
        
        if (!is_undefined(argument2))
        {
            group |= 4;
            rayFunc = argument2;
        }
        else
        {
            group &= -5;
        }
    };
    
    static capsuleCollision = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7)
    {
        if (argument7 != 0)
        {
            var p = _capsuleGetRef(argument0, argument1, argument2, argument3, argument4, argument5, argument7);
            return _getPriority(p[0], p[1], p[2], argument6) >= 0;
        }
        
        return _getPriority(argument0, argument1, argument2, argument6) >= 0;
    };
    
    static move3D = function(argument0, argument1, argument2, argument3)
    {
        static oldReg = array_create(6);
        
        array_copy(oldReg, 0, argument0._getRegions(getMinMax()), 0, 6);
        
        if (type == Colmesh_shapes.block)
        {
            M[12] = argument1;
            M[13] = argument2;
            M[14] = argument3;
        }
        else if (type == Colmesh_shapes.dynamicmesh)
        {
            M[12] = argument1;
            M[13] = argument2;
            M[14] = argument3;
            moving = false;
        }
        else
        {
            x = argument1;
            y = argument2;
            z = argument3;
        }
        
        var newReg = argument0._getRegions(getMinMax());
        
        if (!array_equals(oldReg, newReg))
        {
            argument0.removeShapeFromSubdiv(self, oldReg);
            argument0.addShapeToSubdiv(self, newReg, false);
        }
    };
    
    static getMinMax = function()
    {
        static minMax = array_create(6);
        
        return minMax;
    };
    
    static checkAABB = function(argument0, argument1, argument2, argument3, argument4, argument5)
    {
        return false;
    };
    
    static _capsuleGetRef = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6)
    {
        static ret = array_create(3);
        
        return ret;
    };
    
    static _castRay = function(argument0)
    {
        return [0, 0, 0, 0, 0, 1, self, 1];
    };
    
    static _displaceSphere = function(argument0, argument1, argument2, argument3, argument4)
    {
        return false;
    };
    
    static _getPriority = function(argument0, argument1, argument2, argument3)
    {
        return 1;
    };
    
    static _getClosestPoint = function(argument0, argument1, argument2)
    {
        static ret = array_create(3);
        
        return ret;
    };
    
    static _intersectsCube = function(argument0, argument1, argument2, argument3)
    {
        return false;
    };
    
    static debugDraw = function(argument0, argument1)
    {
    };
    
    static toString = function()
    {
        return "ColMesh shape: None. Group: " + string(group);
    };
    
    type = Colmesh_shapes.none;
    group = argument0 ?? 1;
}

function colmesh_mesh(argument0 = "mesh" + string(ds_map_size(global.ColMeshMeshMap)), argument1 = undefined, argument2 = undefined, argument3 = 1) : colmesh_shapes(argument3) constructor
{
    static freeze = function()
    {
        triangles = [];
        ds_list_destroy(shapeList);
    };
    
    static getMinMax = function()
    {
        static minMax = array_create(6);
        
        minMax[0] = min(triangle[0], triangle[3], triangle[6]);
        minMax[1] = min(triangle[1], triangle[4], triangle[7]);
        minMax[2] = min(triangle[2], triangle[5], triangle[8]);
        minMax[3] = max(triangle[0], triangle[3], triangle[6]);
        minMax[4] = max(triangle[1], triangle[4], triangle[7]);
        minMax[5] = max(triangle[2], triangle[5], triangle[8]);
        return minMax;
    };
    
    static checkAABB = function(argument0, argument1, argument2, argument3, argument4, argument5)
    {
        if (min(triangle[0], triangle[3], triangle[6]) < argument3 && min(triangle[1], triangle[4], triangle[7]) < argument4 && min(triangle[2], triangle[5], triangle[8]) < argument5 && max(triangle[0], triangle[3], triangle[6]) > argument0 && max(triangle[1], triangle[4], triangle[7]) > argument1 && max(triangle[2], triangle[5], triangle[8]) > argument2)
            return true;
        
        return false;
    };
    
    static _capsuleGetRef = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6)
    {
        static ret = array_create(3);
        
        var nx = triangle[9];
        var ny = triangle[10];
        var nz = triangle[11];
        var v1x = triangle[0];
        var v1y = triangle[1];
        var v1z = triangle[2];
        var d = dot_product_3d(argument3, argument4, argument5, nx, ny, nz);
        
        if (d != 0)
        {
            var traces = dot_product_3d(v1x - argument0, v1y - argument1, v1z - argument2, nx, ny, nz) / d;
            var traceX = argument0 + (argument3 * traces);
            var traceY = argument1 + (argument4 * traces);
            var traceZ = argument2 + (argument5 * traces);
            var p = _getClosestPoint(traceX, traceY, traceZ);
            d = dot_product_3d(p[0] - argument0, p[1] - argument1, p[2] - argument2, argument3, argument4, argument5);
        }
        else
        {
            d = dot_product_3d(argument0 - v1x, argument1 - v1y, argument2 - v1z, argument3, argument4, argument5);
        }
        
        d = clamp(d, 0, argument6);
        array_set(ret, 0, argument0 + (argument3 * d));
        array_set(ret, 1, argument1 + (argument4 * d));
        array_set(ret, 2, argument2 + (argument5 * d));
        return ret;
    };
    
    static _castRay = function(argument0, argument1 = 1)
    {
        var ox = argument0[0];
        var oy = argument0[1];
        var oz = argument0[2];
        var dx = argument0[3] - ox;
        var dy = argument0[4] - oy;
        var dz = argument0[5] - oz;
        var nx = triangle[9];
        var ny = triangle[10];
        var nz = triangle[11];
        var h = dot_product_3d(dx, dy, dz, nx, ny, nz);
        
        if (h == 0)
            return false;
        
        var v1x = triangle[0];
        var v1y = triangle[1];
        var v1z = triangle[2];
        h = dot_product_3d(v1x - ox, v1y - oy, v1z - oz, nx, ny, nz) / h;
        
        if (h < 0 || h > 1)
            return false;
        
        var itsX = ox + (dx * h);
        var itsY = oy + (dy * h);
        var itsZ = oz + (dz * h);
        var v2x = triangle[3];
        var v2y = triangle[4];
        var v2z = triangle[5];
        var ax = itsX - v1x;
        var ay = itsY - v1y;
        var az = itsZ - v1z;
        var bx = v2x - v1x;
        var by = v2y - v1y;
        var bz = v2z - v1z;
        var cx = (az * by) - (ay * bz);
        var cy = (ax * bz) - (az * bx);
        var cz = (ay * bx) - (ax * by);
        var dp = dot_product_3d(cx, cy, cz, nx, ny, nz);
        
        if (dp < 0)
            return false;
        
        if (dp == 0)
        {
            var t = dot_product_3d(ax, ay, az, bx, by, bz);
            
            if (t < 0 || t > dot_product_3d(bx, by, bz, bx, by, bz))
                return false;
        }
        
        var v3x = triangle[6];
        var v3y = triangle[7];
        var v3z = triangle[8];
        ax = itsX - v2x;
        ay = itsY - v2y;
        az = itsZ - v2z;
        bx = v3x - v2x;
        by = v3y - v2y;
        bz = v3z - v2z;
        cx = (az * by) - (ay * bz);
        cy = (ax * bz) - (az * bx);
        cz = (ay * bx) - (ax * by);
        dp = dot_product_3d(cx, cy, cz, nx, ny, nz);
        
        if (dp < 0)
            return false;
        
        if (dp == 0)
        {
            var t = dot_product_3d(ax, ay, az, bx, by, bz);
            
            if (t < 0 || t > dot_product_3d(bx, by, bz, bx, by, bz))
                return false;
        }
        
        ax = itsX - v3x;
        ay = itsY - v3y;
        az = itsZ - v3z;
        bx = v1x - v3x;
        by = v1y - v3y;
        bz = v1z - v3z;
        cx = (az * by) - (ay * bz);
        cy = (ax * bz) - (az * bx);
        cz = (ay * bx) - (ax * by);
        dp = dot_product_3d(cx, cy, cz, nx, ny, nz);
        
        if (dp < 0)
            return false;
        
        if (dp == 0)
        {
            var t = dot_product_3d(ax, ay, az, bx, by, bz);
            
            if (t < 0 || t > dot_product_3d(bx, by, bz, bx, by, bz))
                return false;
        }
        
        var s = sign(h);
        return [itsX, itsY, itsZ, nx * s, ny * s, nz * s, triangle, h];
    };
    
    static _displaceSphere = function(argument0, argument1, argument2, argument3, argument4)
    {
        var nx = triangle[9];
        var ny = triangle[10];
        var nz = triangle[11];
        var v1x = triangle[0];
        var v1y = triangle[1];
        var v1z = triangle[2];
        var t0 = argument1 - v1x;
        var t1 = argument2 - v1y;
        var t2 = argument3 - v1z;
        var D = dot_product_3d(t0, t1, t2, nx, ny, nz);
        
        if (abs(D) > argument4)
            return false;
        
        var v2x = triangle[3];
        var v2y = triangle[4];
        var v2z = triangle[5];
        var u0 = v2x - v1x;
        var u1 = v2y - v1y;
        var u2 = v2z - v1z;
        var dp = dot_product_3d((t2 * u1) - (t1 * u2), (t0 * u2) - (t2 * u0), (t1 * u0) - (t0 * u1), nx, ny, nz);
        
        if (dp < 0)
        {
            var a = clamp(dot_product_3d(u0, u1, u2, t0, t1, t2) / dot_product_3d(u0, u1, u2, u0, u1, u2), 0, 1);
            var _nx = t0 - (u0 * a);
            var _ny = t1 - (u1 * a);
            var _nz = t2 - (u2 * a);
            var d = point_distance_3d(0, 0, 0, _nx, _ny, _nz);
            
            if (d == 0 || d >= argument4)
                return false;
            
            d = (argument4 - d) / d;
            return argument0.displace(_nx * d, _ny * d, _nz * d);
        }
        else
        {
            var v3x = triangle[6];
            var v3y = triangle[7];
            var v3z = triangle[8];
            t0 = argument1 - v2x;
            t1 = argument2 - v2y;
            t2 = argument3 - v2z;
            u0 = v3x - v2x;
            u1 = v3y - v2y;
            u2 = v3z - v2z;
            dp = dot_product_3d((t2 * u1) - (t1 * u2), (t0 * u2) - (t2 * u0), (t1 * u0) - (t0 * u1), nx, ny, nz);
            
            if (dp < 0)
            {
                var a = clamp(dot_product_3d(u0, u1, u2, t0, t1, t2) / dot_product_3d(u0, u1, u2, u0, u1, u2), 0, 1);
                var _nx = t0 - (u0 * a);
                var _ny = t1 - (u1 * a);
                var _nz = t2 - (u2 * a);
                var d = point_distance_3d(0, 0, 0, _nx, _ny, _nz);
                
                if (d == 0 || d >= argument4)
                    return false;
                
                d = (argument4 - d) / d;
                return argument0.displace(_nx * d, _ny * d, _nz * d);
            }
            else
            {
                t0 = argument1 - v3x;
                t1 = argument2 - v3y;
                t2 = argument3 - v3z;
                u0 = v1x - v3x;
                u1 = v1y - v3y;
                u2 = v1z - v3z;
                dp = dot_product_3d((t2 * u1) - (t1 * u2), (t0 * u2) - (t2 * u0), (t1 * u0) - (t0 * u1), nx, ny, nz);
                
                if (dp < 0)
                {
                    var a = clamp(dot_product_3d(u0, u1, u2, t0, t1, t2) / dot_product_3d(u0, u1, u2, u0, u1, u2), 0, 1);
                    var _nx = t0 - (u0 * a);
                    var _ny = t1 - (u1 * a);
                    var _nz = t2 - (u2 * a);
                    var d = point_distance_3d(0, 0, 0, _nx, _ny, _nz);
                    
                    if (d == 0 || d >= argument4)
                        return false;
                    
                    d = (argument4 - d) / d;
                    return argument0.displace(_nx * d, _ny * d, _nz * d);
                }
            }
        }
        
        var s = sign(D) * (argument4 - abs(D));
        return argument0.displace(nx * s, ny * s, nz * s);
    };
    
    static _getPriority = function(argument0, argument1, argument2, argument3)
    {
        var nx = triangle[9];
        var ny = triangle[10];
        var nz = triangle[11];
        var v1x = triangle[0];
        var v1y = triangle[1];
        var v1z = triangle[2];
        var t0 = argument0 - v1x;
        var t1 = argument1 - v1y;
        var t2 = argument2 - v1z;
        var D = dot_product_3d(t0, t1, t2, nx, ny, nz);
        
        if (abs(D) > argument3)
            return -1;
        
        var v2x = triangle[3];
        var v2y = triangle[4];
        var v2z = triangle[5];
        var u0 = v2x - v1x;
        var u1 = v2y - v1y;
        var u2 = v2z - v1z;
        
        if (dot_product_3d((t2 * u1) - (t1 * u2), (t0 * u2) - (t2 * u0), (t1 * u0) - (t0 * u1), nx, ny, nz) < 0)
        {
            var a = clamp(dot_product_3d(u0, u1, u2, t0, t1, t2) / dot_product_3d(u0, u1, u2, u0, u1, u2), 0, 1);
            return colmesh_vector_square((u0 * a) - t0, (u1 * a) - t1, (u2 * a) - t2);
        }
        else
        {
            var v3x = triangle[6];
            var v3y = triangle[7];
            var v3z = triangle[8];
            t0 = argument0 - v2x;
            t1 = argument1 - v2y;
            t2 = argument2 - v2z;
            u0 = v3x - v2x;
            u1 = v3y - v2y;
            u2 = v3z - v2z;
            
            if (dot_product_3d((t2 * u1) - (t1 * u2), (t0 * u2) - (t2 * u0), (t1 * u0) - (t0 * u1), nx, ny, nz) < 0)
            {
                var a = clamp(dot_product_3d(u0, u1, u2, t0, t1, t2) / dot_product_3d(u0, u1, u2, u0, u1, u2), 0, 1);
                return colmesh_vector_square((u0 * a) - t0, (u1 * a) - t1, (u2 * a) - t2);
            }
            else
            {
                t0 = argument0 - v3x;
                t1 = argument1 - v3y;
                t2 = argument2 - v3z;
                u0 = v1x - v3x;
                u1 = v1y - v3y;
                u2 = v1z - v3z;
                
                if (dot_product_3d((t2 * u1) - (t1 * u2), (t0 * u2) - (t2 * u0), (t1 * u0) - (t0 * u1), nx, ny, nz) < 0)
                {
                    var a = clamp(dot_product_3d(u0, u1, u2, t0, t1, t2) / dot_product_3d(u0, u1, u2, u0, u1, u2), 0, 1);
                    return colmesh_vector_square((u0 * a) - t0, (u1 * a) - t1, (u2 * a) - t2);
                }
            }
        }
        
        return abs(D);
    };
    
    static _getClosestPoint = function(argument0, argument1, argument2)
    {
        static ret = array_create(3);
        
        var nx = triangle[9];
        var ny = triangle[10];
        var nz = triangle[11];
        var v1x = triangle[0];
        var v1y = triangle[1];
        var v1z = triangle[2];
        var v2x = triangle[3];
        var v2y = triangle[4];
        var v2z = triangle[5];
        var t0 = argument0 - v1x;
        var t1 = argument1 - v1y;
        var t2 = argument2 - v1z;
        var u0 = v2x - v1x;
        var u1 = v2y - v1y;
        var u2 = v2z - v1z;
        
        if (dot_product_3d((t2 * u1) - (t1 * u2), (t0 * u2) - (t2 * u0), (t1 * u0) - (t0 * u1), nx, ny, nz) < 0)
        {
            var a = clamp(dot_product_3d(u0, u1, u2, t0, t1, t2) / dot_product_3d(u0, u1, u2, u0, u1, u2), 0, 1);
            array_set(ret, 0, v1x + (u0 * a));
            array_set(ret, 1, v1y + (u1 * a));
            array_set(ret, 2, v1z + (u2 * a));
            return ret;
        }
        else
        {
            var v3x = triangle[6];
            var v3y = triangle[7];
            var v3z = triangle[8];
            t0 = argument0 - v2x;
            t1 = argument1 - v2y;
            t2 = argument2 - v2z;
            u0 = v3x - v2x;
            u1 = v3y - v2y;
            u2 = v3z - v2z;
            
            if (dot_product_3d((t2 * u1) - (t1 * u2), (t0 * u2) - (t2 * u0), (t1 * u0) - (t0 * u1), nx, ny, nz) < 0)
            {
                var a = clamp(dot_product_3d(u0, u1, u2, t0, t1, t2) / dot_product_3d(u0, u1, u2, u0, u1, u2), 0, 1);
                array_set(ret, 0, v2x + (u0 * a));
                array_set(ret, 1, v2y + (u1 * a));
                array_set(ret, 2, v2z + (u2 * a));
                return ret;
            }
            else
            {
                t0 = argument0 - v3x;
                t1 = argument1 - v3y;
                t2 = argument2 - v3z;
                u0 = v1x - v3x;
                u1 = v1y - v3y;
                u2 = v1z - v3z;
                
                if (dot_product_3d((t2 * u1) - (t1 * u2), (t0 * u2) - (t2 * u0), (t1 * u0) - (t0 * u1), nx, ny, nz) < 0)
                {
                    var a = clamp(dot_product_3d(u0, u1, u2, t0, t1, t2) / dot_product_3d(u0, u1, u2, u0, u1, u2), 0, 1);
                    array_set(ret, 0, v3x + (u0 * a));
                    array_set(ret, 1, v3y + (u1 * a));
                    array_set(ret, 2, v3z + (u2 * a));
                    return ret;
                }
            }
        }
        
        var D = dot_product_3d(t0, t1, t2, nx, ny, nz);
        array_set(ret, 0, argument0 - (nx * D));
        array_set(ret, 1, argument1 - (ny * D));
        array_set(ret, 2, argument2 - (nz * D));
        return ret;
    };
    
    static _intersectsCube = function(argument0, argument1, argument2, argument3)
    {
        var v1x = triangle[0];
        var v2x = triangle[3];
        var v3x = triangle[6];
        var d1x = v1x - argument1;
        var d2x = v2x - argument1;
        var d3x = v3x - argument1;
        
        if (min(d1x, d2x, d3x) > argument0 || max(d1x, d2x, d3x) < -argument0)
            return false;
        
        var v1y = triangle[1];
        var v2y = triangle[4];
        var v3y = triangle[7];
        var d1y = v1y - argument2;
        var d2y = v2y - argument2;
        var d3y = v3y - argument2;
        
        if (min(d1y, d2y, d3y) > argument0 || max(d1y, d2y, d3y) < -argument0)
            return false;
        
        var v1z = triangle[2];
        var v2z = triangle[5];
        var v3z = triangle[8];
        var d1z = v1z - argument3;
        var d2z = v2z - argument3;
        var d3z = v3z - argument3;
        
        if (min(d1z, d2z, d3z) > argument0 || max(d1z, d2z, d3z) < -argument0)
            return false;
        
        var nx = triangle[9];
        var ny = triangle[10];
        var nz = triangle[11];
        var minx, maxx;
        
        if (nx > 0)
        {
            minx = -argument0;
            maxx = argument0;
        }
        else
        {
            minx = argument0;
            maxx = -argument0;
        }
        
        var miny, maxy;
        
        if (ny > 0)
        {
            miny = -argument0;
            maxy = argument0;
        }
        else
        {
            miny = argument0;
            maxy = -argument0;
        }
        
        var minz, maxz;
        
        if (nz > 0)
        {
            minz = -argument0;
            maxz = argument0;
        }
        else
        {
            minz = argument0;
            maxz = -argument0;
        }
        
        var d = dot_product_3d(d1x, d1y, d1z, nx, ny, nz);
        
        if (dot_product_3d(minx, miny, minz, nx, ny, nz) > d)
            return false;
        
        if (dot_product_3d(maxx, maxy, maxz, nx, ny, nz) < d)
            return false;
        
        var ex = d2x - d1x;
        var ey = d2y - d1y;
        var ez = d2z - d1z;
        var fex = abs(ex) * argument0;
        var fey = abs(ey) * argument0;
        var fez = abs(ez) * argument0;
        var p0 = (ez * d1y) - (ey * d1z);
        var p2 = (ez * d3y) - (ey * d3z);
        var rad = fez + fey;
        
        if (min(p0, p2) > rad || max(p0, p2) < -rad)
            return false;
        
        p0 = (-ez * d1x) + (ex * d1z);
        p2 = (-ez * d3x) + (ex * d3z);
        rad = fez + fex;
        
        if (min(p0, p2) > rad || max(p0, p2) < -rad)
            return false;
        
        var p1 = (ey * d2x) - (ex * d2y);
        p2 = (ey * d3x) - (ex * d3y);
        rad = fey + fex;
        
        if (min(p1, p2) > rad || max(p1, p2) < -rad)
            return false;
        
        ex = d3x - d2x;
        ey = d3y - d2y;
        ez = d3z - d2z;
        fex = abs(ex) * argument0;
        fey = abs(ey) * argument0;
        fez = abs(ez) * argument0;
        p0 = (ez * d1y) - (ey * d1z);
        p2 = (ez * d3y) - (ey * d3z);
        rad = fez + fey;
        
        if (min(p0, p2) > rad || max(p0, p2) < -rad)
            return false;
        
        p0 = (-ez * d1x) + (ex * d1z);
        p2 = (-ez * d3x) + (ex * d3z);
        rad = fez + fex;
        
        if (min(p0, p2) > rad || max(p0, p2) < -rad)
            return false;
        
        p0 = (ey * d1x) - (ex * d1y);
        p1 = (ey * d2x) - (ex * d2y);
        rad = fey + fex;
        
        if (min(p0, p1) > rad || max(p0, p1) < -rad)
            return false;
        
        ex = d1x - d3x;
        ey = d1y - d3y;
        ez = d1z - d3z;
        fex = abs(ex) * argument0;
        fey = abs(ey) * argument0;
        fez = abs(ez) * argument0;
        p0 = (ez * d1y) - (ey * d1z);
        p1 = (ez * d2y) - (ey * d2z);
        rad = fez + fey;
        
        if (min(p0, p1) > rad || max(p0, p1) < -rad)
            return false;
        
        p0 = (-ez * d1x) + (ex * d1z);
        p1 = (-ez * d2x) + (ex * d2z);
        rad = fez + fex;
        
        if (min(p0, p1) > rad || max(p0, p1) < -rad)
            return false;
        
        p1 = (ey * d2x) - (ex * d2y);
        p2 = (ey * d3x) - (ex * d3y);
        rad = fey + fex;
        
        if (min(p1, p2) > rad || max(p1, p2) < -rad)
            return false;
        
        return true;
    };
    
    static toString = function()
    {
        return "ColMesh shape: Mesh. Group: " + string(group) + ". Triangles: " + string(array_length(triangles)) + ". SubMeshes: " + string(submeshes);
    };
    
    name = argument0;
    type = Colmesh_shapes.defaultmesh;
    solid = true;
    triangle = -1;
    shapeList = ds_list_create();
    triangles = [];
    matrix = -1;
    submeshes = 0;
    global.ColMeshMeshMap[? argument0] = self;
    
    if (!is_undefined(argument1))
    {
        var load = false;
        
        if (is_string(argument1))
        {
            load = true;
            argument1 = colmesh_load_obj_to_buffer(argument1);
        }
        
        if (is_array(argument1))
        {
            load = true;
            var _mesh = buffer_create(1, buffer_fixed, 1);
            var num = array_length(argument1);
            var totalSize = 0;
            
            for (var i = 0; i < num; i++)
            {
                var buffSize = buffer_get_size(argument1[i]);
                var buffPos = totalSize;
                totalSize += buffSize;
                buffer_resize(argument1, totalSize);
                buffer_copy(argument1[i], 0, buffSize, argument1, buffPos);
            }
            
            argument1 = _mesh;
        }
        
        if (argument1 >= 0)
        {
            var bytesPerTri = 108;
            var triNum = buffer_get_size(argument1) div bytesPerTri;
            triangles = array_create(triNum);
            
            for (var i = 0; i < triNum; i++)
            {
                var tri = array_create(9);
                
                for (var j = 0; j < 3; j++)
                {
                    for (var k = 0; k < 3; k++)
                        tri[(j * 3) + k] = buffer_peek(argument1, (i * bytesPerTri) + (j * 36) + (k * 4), buffer_f32);
                }
                
                if (is_array(argument2))
                {
                    var V = array_create(9);
                    array_copy(V, 0, matrix_transform_vertex(argument2, tri[0], tri[1], tri[2]), 0, 3);
                    array_copy(V, 3, matrix_transform_vertex(argument2, tri[3], tri[4], tri[5]), 0, 3);
                    array_copy(V, 6, matrix_transform_vertex(argument2, tri[6], tri[7], tri[8]), 0, 3);
                    tri = V;
                }
                
                triangles[i] = tri;
            }
            
            if (load)
                buffer_delete(argument1);
        }
        else
        {
            show_debug_message("Error in function colmesh_mesh: Could not add given mesh " + string(argument1) + " to colmesh!");
        }
    }
}

function colmesh_sphere(argument0, argument1, argument2, argument3, argument4 = 1) : colmesh_shapes(argument4) constructor
{
    static getMinMax = function()
    {
        static minMax = array_create(6);
        
        minMax[0] = x - R;
        minMax[1] = y - R;
        minMax[2] = z - R;
        minMax[3] = x + R;
        minMax[4] = y + R;
        minMax[5] = z + R;
        return minMax;
    };
    
    static checkAABB = function(argument0, argument1, argument2, argument3, argument4, argument5)
    {
        if ((x - R) < argument3 && (y - R) < argument4 && (z - R) < argument5 && (x + R) > argument0 && (y + R) > argument1 && (z + R) > argument2)
            return true;
        
        return false;
    };
    
    static _capsuleGetRef = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6)
    {
        static ret = array_create(3);
        
        var d = clamp(dot_product_3d(x - argument0, y - argument1, z - argument2, argument3, argument4, argument5), 0, argument6);
        array_set(ret, 0, argument0 + (argument3 * d));
        array_set(ret, 1, argument1 + (argument4 * d));
        array_set(ret, 2, argument2 + (argument5 * d));
        return ret;
    };
    
    static _castRay = function(argument0, argument1 = 1)
    {
        var t = colmesh_cast_ray_sphere(x, y, z, R, argument0[0], argument0[1], argument0[2], argument0[3], argument0[4], argument0[5]);
        
        if (t < 0 || t > 1)
            return false;
        
        var itsX = lerp(argument0[0], argument0[3], t);
        var itsY = lerp(argument0[1], argument0[4], t);
        var itsZ = lerp(argument0[2], argument0[5], t);
        var n = point_distance_3d(x, y, z, itsX, itsY, itsZ);
        return [itsX, itsY, itsZ, (itsX - x) / n, (itsY - y) / n, (itsZ - z) / n, self, t];
    };
    
    static _getClosestPoint = function(argument0, argument1, argument2)
    {
        static ret = array_create(3);
        
        var dx = argument0 - x;
        var dy = argument1 - y;
        var dz = argument2 - z;
        var d = point_distance_3d(dx, dy, dz, 0, 0, 0);
        
        if (d > 0)
        {
            var _d = R / d;
            array_set(ret, 0, x + (dx * _d));
            array_set(ret, 1, y + (dy * _d));
            array_set(ret, 2, z + (dz * _d));
            return ret;
        }
        
        array_set(ret, 0, x + R);
        array_set(ret, 1, y);
        array_set(ret, 2, z);
        return ret;
    };
    
    static _displaceSphere = function(argument0, argument1, argument2, argument3, argument4)
    {
        var dx = argument1 - x;
        var dy = argument2 - y;
        var dz = argument3 - z;
        var d = point_distance_3d(dx, dy, dz, 0, 0, 0);
        var r = R + argument4;
        
        if (d == 0 || d >= r)
            return false;
        
        d = (r - d) / d;
        return argument0.displace(dx * d, dy * d, dz * d);
    };
    
    static _getPriority = function(argument0, argument1, argument2, argument3)
    {
        var dx = argument0 - x;
        var dy = argument1 - y;
        var dz = argument2 - z;
        var d = point_distance_3d(dx, dy, dz, 0, 0, 0);
        
        if (d > (R + argument3))
            return -1;
        
        return sqr(max(d - R, 0));
    };
    
    static _intersectsCube = function(argument0, argument1, argument2, argument3)
    {
        return colmesh_sphere_intersects_cube(x, y, z, R, argument0, argument1, argument2, argument3);
    };
    
    static debugDraw = function(argument0 = -1)
    {
        static vbuff = global.ColMeshDebugShapes[Colmesh_shapes.sphere];
        static M = [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
        
        if (vbuff < 0)
        {
            global.ColMeshDebugShapes[Colmesh_shapes.sphere] = colmesh_create_sphere(20, 16, 1, 1);
            vbuff = global.ColMeshDebugShapes[Colmesh_shapes.sphere];
        }
        
        M[12] = x;
        M[13] = y;
        M[14] = z;
        var W = matrix_get(2);
        var scale = point_distance_3d(0, 0, 0, W[0], W[1], W[2]);
        shader_set_uniform_f(shader_get_uniform(shader_current(), "u_radius"), R * scale);
        matrix_set(2, matrix_multiply(M, W));
        vertex_submit(vbuff, pr_trianglelist, argument0);
        matrix_set(2, W);
    };
    
    static toString = function()
    {
        return "ColMesh shape: Sphere. Group: " + string(group) + ". X,Y,Z,R: " + string([x, y, z, R]);
    };
    
    type = Colmesh_shapes.sphere;
    x = argument0;
    y = argument1;
    z = argument2;
    R = argument3;
}

function colmesh_capsule(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8 = 1) : colmesh_shapes(argument8) constructor
{
    static getMinMax = function()
    {
        static minMax = array_create(6);
        
        minMax[0] = (x - R) + (H * min(0, xup));
        minMax[1] = (y - R) + (H * min(0, yup));
        minMax[2] = (z - R) + (H * min(0, zup));
        minMax[3] = x + R + (H * max(0, xup));
        minMax[4] = y + R + (H * max(0, yup));
        minMax[5] = z + R + (H * max(0, zup));
        return minMax;
    };
    
    static checkAABB = function(argument0, argument1, argument2, argument3, argument4, argument5)
    {
        if (((x - R) + (H * min(0, xup))) < argument3 && ((y - R) + (H * min(0, yup))) < argument4 && ((z - R) + (H * min(0, zup))) < argument5 && (x + R + (H * max(0, xup))) > argument0 && (y + R + (H * max(0, yup))) > argument1 && (z + R + (H * max(0, zup))) > argument2)
            return true;
        
        return false;
    };
    
    static _capsuleGetRef = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6)
    {
        static ret = array_create(3);
        
        var upDp = dot_product_3d(argument3, argument4, argument5, xup, yup, zup);
        
        if (upDp == 1)
        {
            t = dot_product_3d(x - argument0, y - argument1, z - argument2, argument3, argument4, argument5);
            t = clamp(t, 0, argument6);
            ret[0] = argument0 + (argument3 * t);
            ret[1] = argument1 + (argument4 * t);
            ret[2] = argument2 + (argument5 * t);
            return ret;
        }
        
        var dx = argument0 - x;
        var dy = argument1 - y;
        var dz = argument2 - z;
        var w1 = dot_product_3d(dx, dy, dz, xup, yup, zup);
        var w2 = dot_product_3d(dx, dy, dz, argument3, argument4, argument5);
        var s = clamp((w1 - (w2 * upDp)) / (1 - (upDp * upDp)), 0, H);
        var t = dot_product_3d((xup * s) - dx, (yup * s) - dy, (zup * s) - dz, argument3, argument4, argument5);
        t = clamp(t, 0, argument6);
        ret[0] = argument0 + (argument3 * t);
        ret[1] = argument1 + (argument4 * t);
        ret[2] = argument2 + (argument5 * t);
        return ret;
    };
    
    static _castRay = function(argument0, argument1 = 1)
    {
        var ox = argument0[0];
        var oy = argument0[1];
        var oz = argument0[2];
        var ex = argument0[3];
        var ey = argument0[4];
        var ez = argument0[5];
        var o = matrix_transform_vertex(I, ox, oy, oz);
        var e = matrix_transform_vertex(I, ex, ey, ez);
        var lox = o[0];
        var loy = o[1];
        var ldx = e[0] - lox;
        var ldy = e[1] - loy;
        var a = (ldx * ldx) + (ldy * ldy);
        var b = (ldx * lox) + (ldy * loy);
        var c = ((lox * lox) + (loy * loy)) - 1;
        var k = (b * b) - (a * c);
        var tx, ty, tz;
        
        if (sign(k) >= 0)
        {
            t = -(b + sqrt(k)) / a;
            
            if (t > 0 && t <= 1)
            {
                itsX = lerp(ox, ex, t);
                itsY = lerp(oy, ey, t);
                itsZ = lerp(oz, ez, t);
                var d = dot_product_3d(itsX - x, itsY - y, itsZ - z, xup, yup, zup);
                
                if (d > 0 && d < H)
                {
                    tx = x + (xup * d);
                    ty = y + (yup * d);
                    tz = z + (zup * d);
                    n = point_distance_3d(itsX, itsY, itsZ, tx, ty, tz);
                    
                    if (n == 0)
                        return false;
                    
                    return [itsX, itsY, itsZ, (itsX - tx) / n, (itsY - ty) / n, (itsZ - tz) / n, self, t];
                }
            }
        }
        
        var t1 = colmesh_cast_ray_sphere(x, y, z, R, ox, oy, oz, ex, ey, ez);
        var t2 = colmesh_cast_ray_sphere(x + (xup * H), y + (yup * H), z + (zup * H), R, ox, oy, oz, ex, ey, ez);
        var t = min((t1 < 0) ? 1 : t1, (t2 < 0) ? 1 : t2);
        
        if (t == 1)
            return false;
        
        if (t == t1)
        {
            tx = x;
            ty = y;
            tz = z;
        }
        else
        {
            tx = x + (xup * H);
            ty = y + (yup * H);
            tz = z + (zup * H);
        }
        
        var itsX = lerp(ox, ex, t);
        var itsY = lerp(oy, ey, t);
        var itsZ = lerp(oz, ez, t);
        var n = point_distance_3d(itsX, itsY, itsZ, tx, ty, tz);
        
        if (n == 0)
            return false;
        
        return [itsX, itsY, itsZ, (itsX - tx) / n, (itsY - ty) / n, (itsZ - tz) / n, self, t];
    };
    
    static _getClosestPoint = function(argument0, argument1, argument2)
    {
        static ret = array_create(3);
        
        var d = dot_product_3d(argument0 - x, argument1 - y, argument2 - z, xup, yup, zup);
        d = clamp(d, 0, H);
        var tx = x + (xup * d);
        var ty = y + (yup * d);
        var tz = z + (zup * d);
        var dx = argument0 - tx;
        var dy = argument1 - ty;
        var dz = argument2 - tz;
        d = point_distance_3d(0, 0, 0, dx, dy, dz);
        
        if (d > 0)
        {
            var r = R / d;
            array_set(ret, 0, tx + (dx * r));
            array_set(ret, 1, ty + (dy * r));
            array_set(ret, 2, tz + (dz * r));
            return ret;
        }
        
        array_set(ret, 0, tx + R);
        array_set(ret, 1, ty);
        array_set(ret, 2, tz);
        return ret;
    };
    
    static _displaceSphere = function(argument0, argument1, argument2, argument3, argument4)
    {
        var D = dot_product_3d(argument1 - x, argument2 - y, argument3 - z, xup, yup, zup);
        D = clamp(D, 0, H);
        var tx = x + (xup * D);
        var ty = y + (yup * D);
        var tz = z + (zup * D);
        var dx = argument1 - tx;
        var dy = argument2 - ty;
        var dz = argument3 - tz;
        var d = point_distance_3d(dx, dy, dz, 0, 0, 0);
        var r = R + argument4;
        
        if (d == 0 || d >= r)
            return false;
        
        d = (r - d) / d;
        return argument0.displace(dx * d, dy * d, dz * d);
    };
    
    static _getPriority = function(argument0, argument1, argument2, argument3)
    {
        var D = dot_product_3d(argument0 - x, argument1 - y, argument2 - z, xup, yup, zup);
        D = clamp(D, 0, H);
        var tx = x + (xup * D);
        var ty = y + (yup * D);
        var tz = z + (zup * D);
        var d = point_distance_3d(argument0 - tx, argument1 - ty, argument2 - tz, 0, 0, 0);
        
        if (d > (R + argument3))
            return -1;
        
        return sqr(max(d - R, 0));
    };
    
    static _intersectsCube = function(argument0, argument1, argument2, argument3)
    {
        var bx = argument1;
        var by = argument2;
        var bz = argument3;
        var tx, ty, tz;
        
        repeat (2)
        {
            var d = dot_product_3d(bx - x, by - y, bz - z, xup, yup, zup);
            d = clamp(d, 0, H);
            tx = x + (xup * d);
            ty = y + (yup * d);
            tz = z + (zup * d);
            bx = clamp(tx, argument1 - argument0, argument1 + argument0);
            by = clamp(ty, argument2 - argument0, argument2 + argument0);
            bz = clamp(tz, argument3 - argument0, argument3 + argument0);
        }
        
        return colmesh_sphere_intersects_cube(tx, ty, tz, R * 1.2, argument0, argument1, argument2, argument3);
    };
    
    static debugDraw = function(argument0 = -1)
    {
        static vbuff = global.ColMeshDebugShapes[Colmesh_shapes.capsule];
        static M = array_create(16);
        
        if (vbuff < 0)
        {
            global.ColMeshDebugShapes[Colmesh_shapes.capsule] = colmesh_create_capsule(20, 20, 1, 1);
            vbuff = global.ColMeshDebugShapes[Colmesh_shapes.capsule];
        }
        
        colmesh_matrix_build_from_vector(x, y, z, xup, yup, zup, 1, 1, H, M);
        var sh = shader_current();
        var W = matrix_get(2);
        var scale = point_distance_3d(0, 0, 0, W[0], W[1], W[2]);
        shader_set_uniform_f(shader_get_uniform(shader_current(), "u_radius"), R * scale);
        matrix_set(2, matrix_multiply(M, W));
        vertex_submit(vbuff, pr_trianglelist, argument0);
        matrix_set(2, W);
    };
    
    static toString = function()
    {
        return "ColMesh shape: Capsule. Group: " + string(group) + ". X,Y,Z,R,H: " + string([x, y, z, R, H]) + ". xup,yup,zup: " + string([xup, yup, zup]);
    };
    
    type = Colmesh_shapes.capsule;
    x = argument0;
    y = argument1;
    z = argument2;
    var l = point_distance_3d(argument3, argument4, argument5, 0, 0, 0);
    xup = argument3 / l;
    yup = argument4 / l;
    zup = argument5 / l;
    R = argument6;
    H = argument7;
    var M = colmesh_matrix_build_from_vector(argument0, argument1, argument2, argument3, argument4, argument5, R, R, H);
    I = colmesh_matrix_invert_fast(M, M);
}

function colmesh_cylinder(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8 = 1) : colmesh_shapes(argument8) constructor
{
    static getMinMax = function()
    {
        static minMax = array_create(6);
        
        minMax[0] = (x - R) + (H * min(0, xup));
        minMax[1] = (y - R) + (H * min(0, yup));
        minMax[2] = (z - R) + (H * min(0, zup));
        minMax[3] = x + R + (H * max(0, xup));
        minMax[4] = y + R + (H * max(0, yup));
        minMax[5] = z + R + (H * max(0, zup));
        return minMax;
    };
    
    static checkAABB = function(argument0, argument1, argument2, argument3, argument4, argument5)
    {
        if (((x - R) + (H * min(0, xup))) < argument3 && ((y - R) + (H * min(0, yup))) < argument4 && ((z - R) + (H * min(0, zup))) < argument5 && (x + R + (H * max(0, xup))) > argument0 && (y + R + (H * max(0, yup))) > argument1 && (z + R + (H * max(0, zup))) > argument2)
            return true;
        
        return false;
    };
    
    static _capsuleGetRef = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6)
    {
        static ret = array_create(3);
        
        var upDp = dot_product_3d(argument3, argument4, argument5, xup, yup, zup);
        
        if (upDp == 1)
        {
            t = clamp((argument3 * (x - argument0)) + (argument4 * (y - argument1)) + (argument5 * (z - argument2)), 0, argument6);
            ret[0] = argument0 + (argument3 * t);
            ret[1] = argument1 + (argument4 * t);
            ret[2] = argument2 + (argument5 * t);
            return ret;
        }
        
        var dx = argument0 - x;
        var dy = argument1 - y;
        var dz = argument2 - z;
        var w1 = dot_product_3d(dx, dy, dz, xup, yup, zup);
        var w2 = dot_product_3d(dx, dy, dz, argument3, argument4, argument5);
        var s = (w1 - (w2 * upDp)) / (1 - (upDp * upDp));
        
        if (s > 0 && s < H)
        {
            t = dot_product_3d((xup * s) - dx, (yup * s) - dy, (zup * s) - dz, argument3, argument4, argument5);
            t = clamp(t, 0, argument6);
            ret[0] = argument0 + (argument3 * t);
            ret[1] = argument1 + (argument4 * t);
            ret[2] = argument2 + (argument5 * t);
            return ret;
        }
        
        s = clamp(s, 0, H);
        var traceX = x + (xup * s);
        var traceY = y + (yup * s);
        var traceZ = z + (zup * s);
        var d = dot_product_3d(argument3, argument4, argument5, xup, yup, zup);
        
        if (d != 0)
        {
            var traces = dot_product_3d(traceX - argument0, traceY - argument1, traceZ - argument2, xup, yup, zup) / d;
            traceX = argument0 + (argument3 * traces);
            traceY = argument1 + (argument4 * traces);
            traceZ = argument2 + (argument5 * traces);
            var p = _getClosestPoint(traceX, traceY, traceZ);
            d = dot_product_3d(p[0] - argument0, p[1] - argument1, p[2] - argument2, argument3, argument4, argument5);
        }
        else
        {
            d = dot_product_3d(traceX - argument0, traceY - argument1, traceZ - argument2, argument3, argument4, argument5);
        }
        
        var t = clamp(d, 0, argument6);
        ret[0] = argument0 + (argument3 * t);
        ret[1] = argument1 + (argument4 * t);
        ret[2] = argument2 + (argument5 * t);
        return ret;
    };
    
    static _castRay = function(argument0, argument1 = 1)
    {
        var ox = argument0[0];
        var oy = argument0[1];
        var oz = argument0[2];
        var ex = argument0[3];
        var ey = argument0[4];
        var ez = argument0[5];
        var o = matrix_transform_vertex(I, ox, oy, oz);
        var e = matrix_transform_vertex(I, ex, ey, ez);
        var lox = o[0];
        var loy = o[1];
        var ldx = e[0] - lox;
        var ldy = e[1] - loy;
        var a = (ldx * ldx) + (ldy * ldy);
        var b = (ldx * lox) + (ldy * loy);
        var c = ((lox * lox) + (loy * loy)) - 1;
        var k = (b * b) - (a * c);
        
        if (k < 0)
            return false;
        
        k = sqrt(k);
        var t = -(b + k) / a;
        
        if (t > 1)
            return false;
        
        var inside = false;
        
        if (t < 0)
        {
            t = -(b - k) / a;
            inside = true;
            
            if (t < 0)
                return false;
        }
        
        var itsX = lerp(ox, ex, t);
        var itsY = lerp(oy, ey, t);
        var itsZ = lerp(oz, ez, t);
        var d = dot_product_3d(itsX - x, itsY - y, itsZ - z, xup, yup, zup);
        
        if (d < 0 || d > H || inside)
        {
            d = dot_product_3d(ox - x, oy - y, oz - z, xup, yup, zup);
            d = clamp(d, 0, H);
            tx = x + (xup * d);
            ty = y + (yup * d);
            tz = z + (zup * d);
            var dp = dot_product_3d(argument0[3] - argument0[0], argument0[4] - argument0[1], argument0[5] - argument0[2], xup, yup, zup);
            var s = -sign(dp);
            
            if (s == ((2 * (d == 0)) - 1))
                return false;
            
            t = dot_product_3d(tx - ox, ty - oy, tz - oz, xup, yup, zup) / dp;
            
            if (t < 0 || t > 1)
                return false;
            
            itsX = lerp(ox, ex, t);
            itsY = lerp(oy, ey, t);
            itsZ = lerp(oz, ez, t);
            
            if (point_distance_3d(itsX, itsY, itsZ, tx, ty, tz) > R)
                return false;
            
            return [itsX, itsY, itsZ, xup * s, yup * s, zup * s, self, t];
        }
        
        var tx = x + (xup * d);
        var ty = y + (yup * d);
        var tz = z + (zup * d);
        var n = point_distance_3d(itsX, itsY, itsZ, tx, ty, tz);
        
        if (n == 0)
            return false;
        
        return [itsX, itsY, itsZ, (itsX - tx) / n, (itsY - ty) / n, (itsZ - tz) / n, self, t];
    };
    
    static _getClosestPoint = function(argument0, argument1, argument2)
    {
        static ret = array_create(3);
        
        var dx = argument0 - x;
        var dy = argument1 - y;
        var dz = argument2 - z;
        var d = dot_product_3d(argument0 - x, argument1 - y, argument2 - z, xup, yup, zup);
        d = clamp(d, 0, H);
        var tx = x + (xup * d);
        var ty = y + (yup * d);
        var tz = z + (zup * d);
        dx = argument0 - tx;
        dy = argument1 - ty;
        dz = argument2 - tz;
        var dp = dot_product_3d(dx, dy, dz, xup, yup, zup);
        dx -= (xup * dp);
        dy -= (yup * dp);
        dz -= (zup * dp);
        d = point_distance_3d(dx, dy, dz, 0, 0, 0);
        
        if (d > 0)
        {
            if (d > R)
            {
                var r = R / d;
                dx *= r;
                dy *= r;
                dz *= r;
            }
            
            array_set(ret, 0, tx + dx);
            array_set(ret, 1, ty + dy);
            array_set(ret, 2, tz + dz);
            return ret;
        }
        
        array_set(ret, 0, tx + R);
        array_set(ret, 1, ty);
        array_set(ret, 2, tz);
        return ret;
    };
    
    static _displaceSphere = function(argument0, argument1, argument2, argument3, argument4)
    {
        var D = dot_product_3d(argument1 - x, argument2 - y, argument3 - z, xup, yup, zup);
        D = clamp(D, 0, H);
        var tx = x + (xup * D);
        var ty = y + (yup * D);
        var tz = z + (zup * D);
        var dx = argument1 - tx;
        var dy = argument2 - ty;
        var dz = argument3 - tz;
        var r = R + argument4;
        
        if (D <= 0 || D >= H)
        {
            var dp = dot_product_3d(dx, dy, dz, xup, yup, zup);
            dx -= (xup * dp);
            dy -= (yup * dp);
            dz -= (zup * dp);
            d = dot_product_3d(dx, dy, dz, dx, dy, dz);
            
            if (d > (R * R))
            {
                var _d = R / sqrt(d);
                dx *= _d;
                dy *= _d;
                dz *= _d;
            }
            
            dx = argument1 - tx - dx;
            dy = argument2 - ty - dy;
            dz = argument3 - tz - dz;
            r = argument4;
        }
        
        var d = point_distance_3d(dx, dy, dz, 0, 0, 0);
        
        if (d == 0 || d >= r)
            return false;
        
        d = (r - d) / d;
        return argument0.displace(dx * d, dy * d, dz * d);
    };
    
    static _getPriority = function(argument0, argument1, argument2, argument3)
    {
        var D = dot_product_3d(argument0 - x, argument1 - y, argument2 - z, xup, yup, zup);
        D = clamp(D, 0, H);
        var tx = x + (xup * D);
        var ty = y + (yup * D);
        var tz = z + (zup * D);
        var dx = argument0 - tx;
        var dy = argument1 - ty;
        var dz = argument2 - tz;
        
        if (D <= 0 || D >= H)
        {
            var dp = dot_product_3d(dx, dy, dz, xup, yup, zup);
            dx -= (xup * dp);
            dy -= (yup * dp);
            dz -= (zup * dp);
            d = point_distance_3d(dx, dy, dz, 0, 0, 0);
            
            if (d > R)
            {
                var _d = R / d;
                dx *= _d;
                dy *= _d;
                dz *= _d;
            }
            
            dx = argument0 - tx - dx;
            dy = argument1 - ty - dy;
            dz = argument2 - tz - dz;
            d = dot_product_3d(dx, dy, dz, dx, dy, dz);
            
            if (d > (argument3 * argument3))
                return -1;
            
            return d;
        }
        
        var d = max(point_distance_3d(dx, dy, dz, 0, 0, 0) - R, 0);
        
        if (d > argument3)
            return -1;
        
        return d * d;
    };
    
    static _intersectsCube = function(argument0, argument1, argument2, argument3)
    {
        var p = _getClosestPoint(argument1, argument2, argument3);
        var dx = p[0] - argument1;
        var dy = p[1] - argument2;
        var dz = p[2] - argument3;
        
        if (abs(dx) > argument0 || abs(dy) > argument0 || abs(dz) > argument0)
            return false;
        
        return true;
    };
    
    static debugDraw = function(argument0 = -1)
    {
        static vbuff = global.ColMeshDebugShapes[Colmesh_shapes.cylinder];
        static M = array_create(16);
        
        if (vbuff < 0)
        {
            global.ColMeshDebugShapes[Colmesh_shapes.cylinder] = colmesh_create_cylinder(20, 1, 1);
            vbuff = global.ColMeshDebugShapes[Colmesh_shapes.cylinder];
        }
        
        colmesh_matrix_build_from_vector(x, y, z, xup, yup, zup, R, R, H, M);
        var sh = shader_current();
        var W = matrix_get(2);
        shader_set_uniform_f(shader_get_uniform(shader_current(), "u_radius"), 0);
        matrix_set(2, matrix_multiply(M, W));
        vertex_submit(vbuff, pr_trianglelist, argument0);
        matrix_set(2, W);
    };
    
    static toString = function()
    {
        return "ColMesh shape: Cylinder. Group: " + string(group) + ". X,Y,Z,R,H: " + string([x, y, z, R, H]) + ". xup,yup,zup: " + string([xup, yup, zup]);
    };
    
    type = Colmesh_shapes.cylinder;
    x = argument0;
    y = argument1;
    z = argument2;
    var l = point_distance_3d(argument3, argument4, argument5, 0, 0, 0);
    xup = argument3 / l;
    yup = argument4 / l;
    zup = argument5 / l;
    R = argument6;
    H = argument7;
    var M = colmesh_matrix_build_from_vector(argument0, argument1, argument2, argument3, argument4, argument5, R, R, H);
    I = colmesh_matrix_invert_fast(M, M);
}

function colmesh_unfinished_cone(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8 = 1) : colmesh_shapes(argument8) constructor
{
    static getMinMax = function()
    {
        static minMax = array_create(6);
        
        minMax[0] = (x - R) + (H * min(0, xup));
        minMax[1] = (y - R) + (H * min(0, yup));
        minMax[2] = (z - R) + (H * min(0, zup));
        minMax[3] = x + R + (H * max(0, xup));
        minMax[4] = y + R + (H * max(0, yup));
        minMax[5] = z + R + (H * max(0, zup));
        return minMax;
    };
    
    static checkAABB = function(argument0, argument1, argument2, argument3, argument4, argument5)
    {
        var minMax = getMinMax();
        
        if (minMax[0] < argument3 && minMax[1] < argument4 && minMax[2] < argument5 && minMax[3] > argument0 && minMax[4] > argument1 && minMax[5] > argument2)
            return true;
        
        return false;
    };
    
    static _capsuleGetRef = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6)
    {
        static ret = array_create(3);
        
        var upDp = (argument3 * xup) + (argument4 * yup) + (argument5 * zup);
        
        if (upDp == 1)
        {
            t = clamp((argument3 * (x - argument0)) + (argument4 * (y - argument1)) + (argument5 * (z - argument2)), 0, argument6);
            ret[0] = argument0 + (argument3 * t);
            ret[1] = argument1 + (argument4 * t);
            ret[2] = argument2 + (argument5 * t);
            return ret;
        }
        
        var w1 = ((argument0 - x) * xup) + ((argument1 - y) * yup) + ((argument2 - z) * zup);
        var w2 = ((argument0 - x) * argument3) + ((argument1 - y) * argument4) + ((argument2 - z) * argument5);
        var s = (w1 - (w2 * upDp)) / (1 - (upDp * upDp));
        
        if (s > 0 && s < H)
        {
            t = clamp((argument3 * ((x + (xup * s)) - argument0)) + (argument4 * ((y + (yup * s)) - argument1)) + (argument5 * ((z + (zup * s)) - argument2)), 0, argument6);
            ret[0] = argument0 + (argument3 * t);
            ret[1] = argument1 + (argument4 * t);
            ret[2] = argument2 + (argument5 * t);
            return ret;
        }
        
        s = clamp(s, 0, H);
        var traceX = x + (xup * s);
        var traceY = y + (yup * s);
        var traceZ = z + (zup * s);
        var d = (argument3 * xup) + (argument4 * yup) + (argument5 * zup);
        
        if (d != 0)
        {
            var traces = (((traceX - argument0) * xup) + ((traceY - argument1) * yup) + ((traceZ - argument2) * zup)) / d;
            traceX = argument0 + (argument3 * traces);
            traceY = argument1 + (argument4 * traces);
            traceZ = argument2 + (argument5 * traces);
            var p = _getClosestPoint(traceX, traceY, traceZ);
            d = ((p[0] - argument0) * argument3) + ((p[1] - argument1) * argument4) + ((p[2] - argument2) * argument5);
        }
        else
        {
            d = ((traceX - argument0) * argument3) + ((traceY - argument1) * argument4) + ((traceZ - argument2) * argument5);
        }
        
        var t = clamp(d, 0, argument6);
        ret[0] = argument0 + (argument3 * t);
        ret[1] = argument1 + (argument4 * t);
        ret[2] = argument2 + (argument5 * t);
        return ret;
    };
    
    static _castRay = function(argument0, argument1 = 1)
    {
        var ox = argument0[0];
        var oy = argument0[1];
        var oz = argument0[2];
        var ex = argument0[3];
        var ey = argument0[4];
        var ez = argument0[5];
        var dx = ex - ox;
        var dy = ey - oy;
        var dz = ez - oz;
        var lox = (inv0 * (ox - x)) + (inv4 * (oy - y)) + (inv8 * (oz - z));
        var loy = (inv1 * (ox - x)) + (inv5 * (oy - y)) + (inv9 * (oz - z));
        var ldx = (inv0 * dx) + (inv4 * dy) + (inv8 * dz);
        var ldy = (inv1 * dx) + (inv5 * dy) + (inv9 * dz);
        var a = (ldx * ldx) + (ldy * ldy);
        var b = -((ldx * lox) + (ldy * loy));
        var c = ((lox * lox) + (loy * loy)) - 1;
        var k = (b * b) - (a * c);
        
        if (k <= 0)
            return false;
        
        k = sqrt(k);
        var t = (b - k) / a;
        
        if (t > 1)
            return false;
        
        var inside = false;
        
        if (t < 0)
        {
            t = (b + k) / a;
            inside = true;
            
            if (t < 0)
                return false;
        }
        
        var itsX = ox + (dx * t);
        var itsY = oy + (dy * t);
        var itsZ = oz + (dz * t);
        var d = ((itsX - x) * xup) + ((itsY - y) * yup) + ((itsZ - z) * zup);
        
        if (d < 0 || d > H || inside)
        {
            d = clamp(((ox - x) * xup) + ((oy - y) * yup) + ((oz - z) * zup), 0, H);
            tx = x + (xup * d);
            ty = y + (yup * d);
            tz = z + (zup * d);
            var dp = (dx * xup) + (dy * yup) + (dz * zup);
            var s = -sign(dp);
            
            if (s == ((2 * (d == 0)) - 1))
                return false;
            
            t = -(((ox - tx) * xup) + ((oy - ty) * yup) + ((oz - tz) * zup)) / dp;
            
            if (t < 0 || t > 1)
                return false;
            
            itsX = ox + (dx * t);
            itsY = oy + (dy * t);
            itsZ = oz + (dz * t);
            
            if (point_distance_3d(itsX, itsY, itsZ, tx, ty, tz) > R)
                return false;
            
            return [itsX, itsY, itsZ, xup * s, yup * s, zup * s, self, t];
        }
        
        var tx = x + (xup * d);
        var ty = y + (yup * d);
        var tz = z + (zup * d);
        var nx = itsX - tx;
        var ny = itsY - ty;
        var nz = itsZ - tz;
        var n = point_distance_3d(itsX, itsY, itsZ, tx, ty, tz);
        
        if (n == 0)
            return false;
        
        return [itsX, itsY, itsZ, (itsX - tx) / n, (itsY - ty) / n, (itsZ - tz) / n, self, t];
    };
    
    static _getClosestPoint = function(argument0, argument1, argument2)
    {
        static ret = array_create(3);
        
        var dx = argument0 - x;
        var dy = argument1 - y;
        var dz = argument2 - z;
        var d = clamp((dx * xup) + (dy * yup) + (dz * zup), 0, H);
        var tx = x + (xup * d);
        var ty = y + (yup * d);
        var tz = z + (zup * d);
        dx = argument0 - tx;
        dy = argument1 - ty;
        dz = argument2 - tz;
        var dp = (dx * xup) + (dy * yup) + (dz * zup);
        dx -= (xup * dp);
        dy -= (yup * dp);
        dz -= (zup * dp);
        d = (dx * dx) + (dy * dy) + (dz * dz);
        
        if (d > 0)
        {
            if (d > (R * R))
            {
                var r = R / sqrt(d);
                dx *= r;
                dy *= r;
                dz *= r;
            }
            
            array_set(ret, 0, tx + dx);
            array_set(ret, 1, ty + dy);
            array_set(ret, 2, tz + dz);
            return ret;
        }
        
        array_set(ret, 0, tx + R);
        array_set(ret, 1, ty);
        array_set(ret, 2, tz);
        return ret;
    };
    
    static _displaceSphere = function(argument0, argument1, argument2, argument3, argument4)
    {
        var D = clamp(((argument1 - x) * xup) + ((argument2 - y) * yup) + ((argument3 - z) * zup), 0, H);
        var tx = x + (xup * D);
        var ty = y + (yup * D);
        var tz = z + (zup * D);
        var dx = argument1 - tx;
        var dy = argument2 - ty;
        var dz = argument3 - tz;
        var _r = R + argument4;
        
        if (D <= 0 || D >= H)
        {
            var dp = (dx * xup) + (dy * yup) + (dz * zup);
            dx -= (xup * dp);
            dy -= (yup * dp);
            dz -= (zup * dp);
            d = (dx * dx) + (dy * dy) + (dz * dz);
            
            if (d > (R * R))
            {
                var _d = R / sqrt(d);
                dx *= _d;
                dy *= _d;
                dz *= _d;
            }
            
            dx = argument1 - tx - dx;
            dy = argument2 - ty - dy;
            dz = argument3 - tz - dz;
            _r = argument4;
        }
        
        var d = point_distance_3d(dx, dy, dz, 0, 0, 0);
        
        if (d == 0 || d >= _r)
            return false;
        
        d = (_r - d) / d;
        return argument0.displace(dx * d, dy * d, dz * d);
    };
    
    static _getPriority = function(argument0, argument1, argument2, argument3)
    {
        var D = clamp(((argument0 - x) * xup) + ((argument1 - y) * yup) + ((argument2 - z) * zup), 0, H);
        var tx = x + (xup * D);
        var ty = y + (yup * D);
        var tz = z + (zup * D);
        var dx = argument0 - tx;
        var dy = argument1 - ty;
        var dz = argument2 - tz;
        
        if (D <= 0 || D >= H)
        {
            var dp = (dx * xup) + (dy * yup) + (dz * zup);
            dx -= (xup * dp);
            dy -= (yup * dp);
            dz -= (zup * dp);
            d = point_distance_3d(dx, dy, dz, 0, 0, 0);
            
            if (d > R)
            {
                var _d = R / d;
                dx *= _d;
                dy *= _d;
                dz *= _d;
            }
            
            dx = argument0 - tx - dx;
            dy = argument1 - ty - dy;
            dz = argument2 - tz - dz;
            d = point_distance_3d(dx, dy, dz, 0, 0, 0);
            
            if (d > argument3)
                return -1;
            
            return d * d;
        }
        
        var d = max(point_distance_3d(dx, dy, dz, 0, 0, 0) - R, 0);
        
        if (d > argument3)
            return -1;
        
        return d * d;
    };
    
    static _intersectsCube = function(argument0, argument1, argument2, argument3)
    {
        var p = _getClosestPoint(argument1, argument2, argument3);
        var dx = p[0] - argument1;
        var dy = p[1] - argument2;
        var dz = p[2] - argument3;
        
        if (abs(dx) > argument0 || abs(dy) > argument0 || abs(dz) > argument0)
            return false;
        
        return true;
    };
    
    type = Colmesh_shapes.cone;
    x = argument0;
    y = argument1;
    z = argument2;
    var l = point_distance_3d(0, 0, 0, argument3, argument4, argument5);
    xup = argument3 / l;
    yup = argument4 / l;
    zup = argument5 / l;
    R = argument6;
    H = argument7;
}

function colmesh_torus(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8 = 1) : colmesh_shapes(argument8) constructor
{
    static getMinMax = function()
    {
        static minMax = array_create(6);
        
        var xs = r + (R * invXup);
        var ys = r + (R * invYup);
        var zs = r + (R * invZup);
        minMax[0] = x - xs;
        minMax[1] = y - ys;
        minMax[2] = z - zs;
        minMax[3] = x + xs;
        minMax[4] = y + ys;
        minMax[5] = z + zs;
        return minMax;
    };
    
    static checkAABB = function(argument0, argument1, argument2, argument3, argument4, argument5)
    {
        var rr = R + r;
        
        if ((x - rr) < argument3 && (y - rr) < argument4 && (z - rr) < argument5 && (x + rr) > argument0 && (y + rr) > argument1 && (z + rr) > argument2)
            return true;
        
        return false;
    };
    
    static _capsuleGetRef = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6)
    {
        static ret = array_create(3);
        
        var d = dot_product_3d(argument3, argument4, argument5, xup, yup, zup);
        
        if (d != 0)
        {
            d = dot_product_3d(x - argument0, y - argument1, z - argument2, xup, yup, zup) / d;
            
            repeat (2)
            {
                var p = _getRingCoord(argument0 + (argument3 * d), argument1 + (argument4 * d), argument2 + (argument5 * d));
                d = dot_product_3d(p[0] - argument0, p[1] - argument1, p[2] - argument2, argument3, argument4, argument5);
                d = clamp(d, 0, argument6);
            }
        }
        else
        {
            d = dot_product_3d(x - argument0, y - argument1, z - argument2, argument3, argument4, argument5);
            d = clamp(d, 0, argument6);
        }
        
        ret[0] = argument0 + (argument3 * d);
        ret[1] = argument1 + (argument4 * d);
        ret[2] = argument2 + (argument5 * d);
        return ret;
    };
    
    static _getRingCoord = function(argument0, argument1, argument2)
    {
        static ret = array_create(3);
        
        var dx = argument0 - x;
        var dy = argument1 - y;
        var dz = argument2 - z;
        var dp = dot_product_3d(dx, dy, dz, xup, yup, zup);
        dx -= (xup * dp);
        dy -= (yup * dp);
        dz -= (zup * dp);
        var l = point_distance_3d(dx, dy, dz, 0, 0, 0);
        
        if (l > 0)
        {
            var _d = R / l;
            ret[0] = x + (dx * _d);
            ret[1] = y + (dy * _d);
            ret[2] = z + (dz * _d);
            return ret;
        }
        
        ret[0] = x;
        ret[1] = y;
        ret[2] = z;
        return ret;
    };
    
    static _castRay = function(argument0, argument1 = 1)
    {
        var repetitions = 15;
        var o = matrix_transform_vertex(I, argument0[0], argument0[1], argument0[2]);
        var e = matrix_transform_vertex(I, argument0[3], argument0[4], argument0[5]);
        var lox = o[0];
        var loy = o[1];
        var loz = o[2];
        var ldx = e[0] - lox;
        var ldy = e[1] - loy;
        var ldz = e[2] - loz;
        var l = point_distance_3d(0, 0, 0, ldx, ldy, ldz);
        ldx /= l;
        ldy /= l;
        ldz /= l;
        var p = 0;
        var n = 0;
        var d = 0;
        var radiusRatio = r / R;
        
        repeat (repetitions)
        {
            p = n;
            n = point_distance(0, 0, point_distance(0, 0, lox, loy) - 1, loz) - radiusRatio;
            d += n;
            
            if ((p > 0 && n > R) || d > l)
                return false;
            
            lox += (ldx * n);
            loy += (ldy * n);
            loz += (ldz * n);
        }
        
        if (n > p)
            return false;
        
        d /= l;
        var itsX = lerp(argument0[0], argument0[3], d);
        var itsY = lerp(argument0[1], argument0[4], d);
        var itsZ = lerp(argument0[2], argument0[5], d);
        p = _getRingCoord(itsX, itsY, itsZ);
        n = point_distance_3d(itsX, itsY, itsZ, p[0], p[1], p[2]);
        return [itsX, itsY, itsZ, (itsX - p[0]) / n, (itsY - p[1]) / n, (itsZ - p[2]) / n, self, d];
    };
    
    static _getClosestPoint = function(argument0, argument1, argument2)
    {
        static ret = array_create(3);
        
        var p = _getRingCoord(argument0, argument1, argument2);
        var dx = argument0 - p[0];
        var dy = argument1 - p[1];
        var dz = argument2 - p[2];
        var d = point_distance_3d(dx, dy, dz, 0, 0, 0);
        
        if (d > 0)
        {
            dx /= d;
            dy /= d;
            dz /= d;
            array_set(ret, 0, p[0] + (dx * r));
            array_set(ret, 1, p[1] + (dy * r));
            array_set(ret, 2, p[2] + (dz * r));
            return ret;
        }
        
        array_set(ret, 0, argument0);
        array_set(ret, 1, argument1);
        array_set(ret, 2, argument2);
        return ret;
    };
    
    static _displaceSphere = function(argument0, argument1, argument2, argument3, argument4)
    {
        var p = _getRingCoord(argument1, argument2, argument3);
        var dx = argument1 - p[0];
        var dy = argument2 - p[1];
        var dz = argument3 - p[2];
        var _r = r + argument4;
        var d = point_distance_3d(dx, dy, dz, 0, 0, 0);
        
        if (d == 0 || d >= _r)
            return false;
        
        d = (_r - d) / d;
        return argument0.displace(dx * d, dy * d, dz * d);
    };
    
    static _getPriority = function(argument0, argument1, argument2, argument3)
    {
        var p = _getRingCoord(argument0, argument1, argument2);
        var dx = argument0 - p[0];
        var dy = argument1 - p[1];
        var dz = argument2 - p[2];
        var d = max(point_distance_3d(dx, dy, dz, 0, 0, 0) - r, 0);
        
        if (d > argument3)
            return -1;
        
        return d * d;
    };
    
    static _intersectsCube = function(argument0, argument1, argument2, argument3)
    {
        var p = _getClosestPoint(argument1, argument2, argument3);
        var dx = p[0] - argument1;
        var dy = p[1] - argument2;
        var dz = p[2] - argument3;
        
        if (abs(dx) > argument0 || abs(dy) > argument0 || abs(dz) > argument0)
            return false;
        
        return true;
    };
    
    static debugDraw = function(argument0 = -1)
    {
        static vbuff = global.ColMeshDebugShapes[Colmesh_shapes.torus];
        static M = array_create(16);
        
        if (vbuff < 0)
        {
            global.ColMeshDebugShapes[Colmesh_shapes.torus] = colmesh_create_torus(32, 20, 1, 1);
            vbuff = global.ColMeshDebugShapes[Colmesh_shapes.torus];
        }
        
        colmesh_matrix_build_from_vector(x, y, z, xup, yup, zup, R, R, R, M);
        var sh = shader_current();
        var W = matrix_get(2);
        var scale = point_distance_3d(0, 0, 0, W[0], W[1], W[2]);
        shader_set_uniform_f(shader_get_uniform(shader_current(), "u_radius"), r * scale);
        matrix_set(2, matrix_multiply(M, W));
        vertex_submit(vbuff, pr_trianglelist, argument0);
        matrix_set(2, W);
    };
    
    static toString = function()
    {
        return "ColMesh shape: Torus. Group: " + string(group) + ". X,Y,Z,R,r: " + string([x, y, z, R, r]) + ". xup,yup,zup: " + string([xup, yup, zup]);
    };
    
    type = Colmesh_shapes.torus;
    x = argument0;
    y = argument1;
    z = argument2;
    var l = point_distance_3d(argument3, argument4, argument5, 0, 0, 0);
    xup = argument3 / l;
    yup = argument4 / l;
    zup = argument5 / l;
    invXup = sqrt(1 - (argument3 * argument3));
    invYup = sqrt(1 - (argument4 * argument4));
    invZup = sqrt(1 - (argument5 * argument5));
    R = argument6;
    r = argument7;
    var M = colmesh_matrix_build_from_vector(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument6, argument6);
    I = colmesh_matrix_invert_fast(M, M);
}

function colmesh_disk(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8 = 1) : colmesh_shapes(argument8) constructor
{
    static getMinMax = function()
    {
        static minMax = array_create(6);
        
        var xs = r + (R * invXup);
        var ys = r + (R * invYup);
        var zs = r + (R * invZup);
        minMax[0] = x - xs;
        minMax[1] = y - ys;
        minMax[2] = z - zs;
        minMax[3] = x + xs;
        minMax[4] = y + ys;
        minMax[5] = z + zs;
        return minMax;
    };
    
    static checkAABB = function(argument0, argument1, argument2, argument3, argument4, argument5)
    {
        var rr = R + r;
        
        if ((x - rr) < argument3 && (y - rr) < argument4 && (z - rr) < argument5 && (x + rr) > argument0 && (y + rr) > argument1 && (z + rr) > argument2)
            return true;
        
        return false;
    };
    
    static _capsuleGetRef = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6)
    {
        static ret = array_create(3);
        
        var d = dot_product_3d(argument3, argument4, argument5, xup, yup, zup);
        
        if (d != 0)
        {
            d = dot_product_3d(x - argument0, y - argument1, z - argument2, xup, yup, zup) / d;
            var p = _getDiskCoord(argument0 + (argument3 * d), argument1 + (argument4 * d), argument2 + (argument5 * d));
            d = dot_product_3d(p[0] - argument0, p[1] - argument1, p[2] - argument2, argument3, argument4, argument5);
        }
        else
        {
            d = dot_product_3d(x - argument0, y - argument1, z - argument2, argument3, argument4, argument5);
        }
        
        d = clamp(d, 0, argument6);
        ret[0] = argument0 + (argument3 * d);
        ret[1] = argument1 + (argument4 * d);
        ret[2] = argument2 + (argument5 * d);
        return ret;
    };
    
    static _getDiskCoord = function(argument0, argument1, argument2)
    {
        static ret = array_create(3);
        
        var dx = argument0 - x;
        var dy = argument1 - y;
        var dz = argument2 - z;
        var dp = dot_product_3d(dx, dy, dz, xup, yup, zup);
        dx -= (xup * dp);
        dy -= (yup * dp);
        dz -= (zup * dp);
        var l = point_distance_3d(0, 0, 0, dx, dy, dz);
        
        if (l <= R)
        {
            ret[0] = x + dx;
            ret[1] = y + dy;
            ret[2] = z + dz;
            return ret;
        }
        
        var _d = R / l;
        ret[0] = x + (dx * _d);
        ret[1] = y + (dy * _d);
        ret[2] = z + (dz * _d);
        return ret;
    };
    
    static _castRay = function(argument0, argument1 = 1)
    {
        var repetitions = 15;
        var o = matrix_transform_vertex(I, argument0[0], argument0[1], argument0[2]);
        var e = matrix_transform_vertex(I, argument0[3], argument0[4], argument0[5]);
        var lox = o[0];
        var loy = o[1];
        var loz = o[2];
        var ldx = e[0] - lox;
        var ldy = e[1] - loy;
        var ldz = e[2] - loz;
        var l = point_distance_3d(0, 0, 0, ldx, ldy, ldz);
        ldx /= l;
        ldy /= l;
        ldz /= l;
        var p = 0;
        var n = 0;
        var d = 0;
        var radiusRatio = r / R;
        
        repeat (repetitions)
        {
            p = n;
            n = point_distance(0, 0, max(0, point_distance(0, 0, lox, loy) - 1), loz) - radiusRatio;
            d += n;
            
            if ((p > 0 && n > R) || d > l)
                return false;
            
            lox += (ldx * n);
            loy += (ldy * n);
            loz += (ldz * n);
        }
        
        if (n > p)
            return false;
        
        d /= l;
        var itsX = lerp(argument0[0], argument0[3], d);
        var itsY = lerp(argument0[1], argument0[4], d);
        var itsZ = lerp(argument0[2], argument0[5], d);
        p = _getDiskCoord(itsX, itsY, itsZ);
        n = point_distance_3d(itsX, itsY, itsZ, p[0], p[1], p[2]);
        
        if (n == 0)
            return false;
        
        return [itsX, itsY, itsZ, (itsX - p[0]) / n, (itsY - p[1]) / n, (itsZ - p[2]) / n, self, d];
    };
    
    static _getClosestPoint = function(argument0, argument1, argument2)
    {
        static ret = array_create(3);
        
        var p = _getDiskCoord(argument0, argument1, argument2);
        var dx = argument0 - p[0];
        var dy = argument1 - p[1];
        var dz = argument2 - p[2];
        var d = point_distance_3d(dx, dy, dz, 0, 0, 0);
        
        if (d > 0)
        {
            var _r = r / d;
            array_set(ret, 0, p[0] + (dx * _r));
            array_set(ret, 1, p[1] + (dy * _r));
            array_set(ret, 2, p[2] + (dz * _r));
            return ret;
        }
        
        array_set(ret, 0, argument0);
        array_set(ret, 1, argument1);
        array_set(ret, 2, argument2);
        return ret;
    };
    
    static _displaceSphere = function(argument0, argument1, argument2, argument3, argument4)
    {
        var p = _getDiskCoord(argument1, argument2, argument3);
        var dx = argument1 - p[0];
        var dy = argument2 - p[1];
        var dz = argument3 - p[2];
        var _r = r + argument4;
        var d = point_distance_3d(dx, dy, dz, 0, 0, 0);
        
        if (d == 0 || d >= _r)
            return false;
        
        d = (_r - d) / d;
        return argument0.displace(dx * d, dy * d, dz * d);
    };
    
    static _getPriority = function(argument0, argument1, argument2, argument3)
    {
        var p = _getDiskCoord(argument0, argument1, argument2);
        var dx = argument0 - p[0];
        var dy = argument1 - p[1];
        var dz = argument2 - p[2];
        var d = max(point_distance_3d(dx, dy, dz, 0, 0, 0) - r, 0);
        
        if (d > argument3)
            return -1;
        
        return d * d;
    };
    
    static _intersectsCube = function(argument0, argument1, argument2, argument3)
    {
        var p = _getClosestPoint(argument1, argument2, argument3);
        var dx = p[0] - argument1;
        var dy = p[1] - argument2;
        var dz = p[2] - argument3;
        
        if (abs(dx) > argument0 || abs(dy) > argument0 || abs(dz) > argument0)
            return false;
        
        return true;
    };
    
    static debugDraw = function(argument0 = -1)
    {
        static vbuff = global.ColMeshDebugShapes[Colmesh_shapes.disk];
        static M = array_create(16);
        
        if (vbuff < 0)
        {
            global.ColMeshDebugShapes[Colmesh_shapes.disk] = colmesh_create_disk(32, 20, 1, 1);
            vbuff = global.ColMeshDebugShapes[Colmesh_shapes.disk];
        }
        
        colmesh_matrix_build_from_vector(x, y, z, xup, yup, zup, R, R, R, M);
        var sh = shader_current();
        var W = matrix_get(2);
        var scale = point_distance_3d(0, 0, 0, W[0], W[1], W[2]);
        shader_set_uniform_f(shader_get_uniform(shader_current(), "u_radius"), r * scale);
        matrix_set(2, matrix_multiply(M, W));
        vertex_submit(vbuff, pr_trianglelist, argument0);
        matrix_set(2, W);
    };
    
    static toString = function()
    {
        return "ColMesh shape: Disk. Group: " + string(group) + ". X,Y,Z,R,r: " + string([x, y, z, R, r]) + ". xup,yup,zup: " + string([xup, yup, zup]);
    };
    
    type = Colmesh_shapes.disk;
    x = argument0;
    y = argument1;
    z = argument2;
    var l = point_distance_3d(argument3, argument4, argument5, 0, 0, 0);
    xup = argument3 / l;
    yup = argument4 / l;
    zup = argument5 / l;
    invXup = sqrt(1 - (argument3 * argument3));
    invYup = sqrt(1 - (argument4 * argument4));
    invZup = sqrt(1 - (argument5 * argument5));
    R = argument6;
    r = argument7;
    var M = colmesh_matrix_build_from_vector(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument6, argument6);
    I = colmesh_matrix_invert_fast(M, M);
}

function colmesh_cube(argument0, argument1, argument2, argument3, argument4, argument5, argument6 = 1) : colmesh_shapes(argument6) constructor
{
    static getMinMax = function()
    {
        static minMax = array_create(6);
        
        minMax[0] = x - halfX;
        minMax[1] = y - halfY;
        minMax[2] = z - halfZ;
        minMax[3] = x + halfX;
        minMax[4] = y + halfY;
        minMax[5] = z + halfZ;
        return minMax;
    };
    
    static checkAABB = function(argument0, argument1, argument2, argument3, argument4, argument5)
    {
        if ((x - halfX) < argument3 && (y - halfY) < argument4 && (z - halfZ) < argument5 && (x + halfX) > argument0 && (y + halfY) > argument1 && (z + halfZ) > argument2)
            return true;
        
        return false;
    };
    
    static _capsuleGetRef = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6)
    {
        static ret = array_create(3);
        
        var xx = argument0 - x;
        var yy = argument1 - y;
        var zz = argument2 - z;
        var px = x + (clamp(xx / halfX, -1, 1) * halfX);
        var py = y + (clamp(yy / halfY, -1, 1) * halfY);
        var pz = z + (clamp(zz / halfZ, -1, 1) * halfZ);
        var d = dot_product_3d(px - argument0, py - argument1, pz - argument2, argument3, argument4, argument5);
        d = clamp(d, 0, argument6);
        var rx1 = argument0 + (argument3 * d);
        var ry1 = argument1 + (argument4 * d);
        var rz1 = argument2 + (argument5 * d);
        var d1 = colmesh_vector_square(rx1 - px, ry1 - py, rz1 - pz);
        xx += (argument3 * argument6);
        yy += (argument4 * argument6);
        zz += (argument5 * argument6);
        px = x + (clamp(xx / halfX, -1, 1) * halfX);
        py = y + (clamp(yy / halfY, -1, 1) * halfY);
        pz = z + (clamp(zz / halfZ, -1, 1) * halfZ);
        d = dot_product_3d(px - argument0, py - argument1, pz - argument2, argument3, argument4, argument5);
        d = clamp(d, 0, argument6);
        var rx2 = argument0 + (argument3 * d);
        var ry2 = argument1 + (argument4 * d);
        var rz2 = argument2 + (argument5 * d);
        var d2 = colmesh_vector_square(rx2 - px, ry2 - py, rz2 - pz);
        
        if (d2 < d1)
        {
            ret[0] = rx2;
            ret[1] = ry2;
            ret[2] = rz2;
            return ret;
        }
        
        ret[0] = rx1;
        ret[1] = ry1;
        ret[2] = rz1;
        return ret;
    };
    
    static _castRay = function(argument0, argument1 = 1)
    {
        var tmin = 1;
        var x1 = (argument0[0] - x) / halfX;
        var y1 = (argument0[1] - y) / halfY;
        var z1 = (argument0[2] - z) / halfZ;
        var x2 = (argument0[3] - x) / halfX;
        var y2 = (argument0[4] - y) / halfY;
        var z2 = (argument0[5] - z) / halfZ;
        var intersection = false;
        var insideBlock = true;
        var nx, ny, nz;
        
        if (x2 != x1 && abs(x1) > 1)
        {
            insideBlock = false;
            var s = sign(x1 - x2);
            var t = (s - x1) / (x2 - x1);
            
            if (t >= 0 && t <= 1)
            {
                var itsY = lerp(y1, y2, t);
                var itsZ = lerp(z1, z2, t);
                
                if (abs(itsY) <= 1 && abs(itsZ) <= 1)
                {
                    x2 = s;
                    y2 = itsY;
                    z2 = itsZ;
                    nx = sign(x1);
                    ny = 0;
                    nz = 0;
                    intersection = true;
                    tmin *= t;
                }
            }
        }
        
        if (y2 != y1 && abs(y1) > 1)
        {
            insideBlock = false;
            var s = sign(y1 - y2);
            var t = (s - y1) / (y2 - y1);
            
            if (t >= 0 && t <= 1)
            {
                var itsX = lerp(x1, x2, t);
                var itsZ = lerp(z1, z2, t);
                
                if (abs(itsX) <= 1 && abs(itsZ) <= 1)
                {
                    x2 = itsX;
                    y2 = s;
                    z2 = itsZ;
                    nx = 0;
                    ny = sign(y1);
                    nz = 0;
                    intersection = true;
                    tmin *= t;
                }
            }
        }
        
        if (z2 != z1 && abs(z1) > 1)
        {
            insideBlock = false;
            var s = sign(z1 - z2);
            var t = (s - z1) / (z2 - z1);
            
            if (t >= 0 && t <= 1)
            {
                var itsX = lerp(x1, x2, t);
                var itsY = lerp(y1, y2, t);
                
                if (abs(itsX) <= 1 && abs(itsY) <= 1)
                {
                    x2 = itsX;
                    y2 = itsY;
                    z2 = s;
                    nx = 0;
                    ny = 0;
                    nz = sign(z1);
                    intersection = true;
                    tmin *= t;
                }
            }
        }
        
        if (insideBlock || !intersection)
            return false;
        
        return [x + (x2 * halfX), y + (y2 * halfY), z + (z2 * halfZ), nx, ny, nz, self, tmin];
    };
    
    static _getClosestPoint = function(argument0, argument1, argument2)
    {
        static ret = array_create(3);
        
        var bx = (argument0 - x) / halfX;
        var by = (argument1 - y) / halfY;
        var bz = (argument2 - z) / halfZ;
        var b = max(abs(bx), abs(by), abs(bz));
        
        if (b <= 1)
        {
            if (b == abs(bx))
                bx = sign(bx);
            else if (b == abs(by))
                by = sign(by);
            else
                bz = sign(bz);
            
            array_set(ret, 0, x + (bx * halfX));
            array_set(ret, 1, y + (by * halfY));
            array_set(ret, 2, z + (bz * halfZ));
            array_set(ret, 6, 0);
        }
        else
        {
            bx = clamp(bx, -1, 1);
            by = clamp(by, -1, 1);
            bz = clamp(bz, -1, 1);
            array_set(ret, 0, x + (bx * halfX));
            array_set(ret, 1, y + (by * halfY));
            array_set(ret, 2, z + (bz * halfZ));
        }
        
        return ret;
    };
    
    static _displaceSphere = function(argument0, argument1, argument2, argument3, argument4)
    {
        var bx = (argument1 - x) / halfX;
        var by = (argument2 - y) / halfY;
        var bz = (argument3 - z) / halfZ;
        var b = max(abs(bx), abs(by), abs(bz));
        var nx = 0;
        var ny = 0;
        var nz = 0;
        
        if (b <= 1)
        {
            if (b == abs(bx))
            {
                bx = sign(bx);
                nx = bx;
            }
            else if (b == abs(by))
            {
                by = sign(by);
                ny = by;
            }
            else
            {
                bz = sign(bz);
                nz = bz;
            }
            
            px = x + (bx * halfX);
            py = y + (by * halfY);
            pz = z + (bz * halfZ);
            dx = argument1 - px;
            dy = argument2 - py;
            dz = argument3 - pz;
            d = argument4 - dot_product_3d(dx, dy, dz, nx, ny, nz);
            return argument0.displace(nx * d, ny * d, nz * d);
        }
        
        var px = x + (clamp(bx, -1, 1) * halfX);
        var py = y + (clamp(by, -1, 1) * halfY);
        var pz = z + (clamp(bz, -1, 1) * halfZ);
        var dx = argument1 - px;
        var dy = argument2 - py;
        var dz = argument3 - pz;
        var d = point_distance_3d(dx, dy, dz, 0, 0, 0);
        
        if (d == 0 || d >= argument4)
            return false;
        
        d = (argument4 - d) / d;
        return argument0.displace(dx * d, dy * d, dz * d);
    };
    
    static _getPriority = function(argument0, argument1, argument2, argument3)
    {
        var bx = (argument0 - x) / halfX;
        var by = (argument1 - y) / halfY;
        var bz = (argument2 - z) / halfZ;
        
        if (max(abs(bx), abs(by), abs(bz)) <= 1)
            return 0;
        
        var px = x + (clamp(bx, -1, 1) * halfX);
        var py = y + (clamp(by, -1, 1) * halfY);
        var pz = z + (clamp(bz, -1, 1) * halfZ);
        var dx = argument0 - px;
        var dy = argument1 - py;
        var dz = argument2 - pz;
        var d = dot_product_3d(dx, dy, dz, dx, dy, dz);
        
        if (d > (argument3 * argument3))
            return -1;
        
        return d;
    };
    
    static _intersectsCube = function(argument0, argument1, argument2, argument3)
    {
        if (abs(argument1 - x) > (argument0 + halfX))
            return false;
        
        if (abs(argument2 - y) > (argument0 + halfY))
            return false;
        
        if (abs(argument3 - z) > (argument0 + halfZ))
            return false;
        
        return true;
    };
    
    static debugDraw = function(argument0 = -1)
    {
        static vbuff = global.ColMeshDebugShapes[Colmesh_shapes.cube];
        static M = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];
        
        if (vbuff < 0)
        {
            global.ColMeshDebugShapes[Colmesh_shapes.cube] = colmesh_create_block(1, 1);
            vbuff = global.ColMeshDebugShapes[Colmesh_shapes.cube];
        }
        
        M[0] = halfX;
        M[5] = halfY;
        M[10] = halfZ;
        M[12] = x;
        M[13] = y;
        M[14] = z;
        var sh = shader_current();
        var W = matrix_get(2);
        shader_set_uniform_f(shader_get_uniform(shader_current(), "u_radius"), 0);
        matrix_set(2, matrix_multiply(M, W));
        vertex_submit(vbuff, pr_trianglelist, argument0);
        matrix_set(2, W);
    };
    
    static toString = function()
    {
        return "ColMesh shape: Cube. Group: " + string(group) + ". X,Y,Z,halfx,halfy,halfz: " + string([x, y, z, halfX, halfY, halfZ]);
    };
    
    type = Colmesh_shapes.cube;
    x = argument0;
    y = argument1;
    z = argument2;
    halfX = argument3 / 2;
    halfY = argument4 / 2;
    halfZ = argument5 / 2;
}

function colmesh_block(argument0, argument1 = 1) : colmesh_shapes(argument1) constructor
{
    static getMinMax = function()
    {
        static minMax = array_create(6);
        
        var dx = abs(M[0]) + abs(M[4]) + abs(M[8]);
        var dy = abs(M[1]) + abs(M[5]) + abs(M[9]);
        var dz = abs(M[2]) + abs(M[6]) + abs(M[10]);
        minMax[0] = M[12] - dx;
        minMax[1] = M[13] - dy;
        minMax[2] = M[14] - dz;
        minMax[3] = M[12] + dx;
        minMax[4] = M[13] + dy;
        minMax[5] = M[14] + dz;
        return minMax;
    };
    
    static checkAABB = function(argument0, argument1, argument2, argument3, argument4, argument5)
    {
        var dx = abs(M[0]) + abs(M[4]) + abs(M[8]);
        var dy = abs(M[1]) + abs(M[5]) + abs(M[9]);
        var dz = abs(M[2]) + abs(M[6]) + abs(M[10]);
        
        if ((M[12] - dx) < argument3 && (M[13] - dy) < argument4 && (M[14] - dz) < argument5 && (M[12] + dx) > argument0 && (M[13] + dy) > argument1 && (M[14] + dz) > argument2)
            return true;
        
        return false;
    };
    
    static _capsuleGetRef = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6)
    {
        static ret = array_create(3);
        
        var b = matrix_transform_vertex(I, argument0, argument1, argument2);
        var p = matrix_transform_vertex(M, clamp(b[0], -1, 1), clamp(b[1], -1, 1), clamp(b[2], -1, 1));
        var d = dot_product_3d(p[0] - argument0, p[1] - argument1, p[2] - argument2, argument3, argument4, argument5);
        d = clamp(d, 0, argument6);
        var rx1 = argument0 + (argument3 * d);
        var ry1 = argument1 + (argument4 * d);
        var rz1 = argument2 + (argument5 * d);
        var d1 = colmesh_vector_square(rx1 - p[0], ry1 - p[1], rz1 - p[2]);
        b = matrix_transform_vertex(I, argument0 + (argument3 * argument6), argument1 + (argument4 * argument6), argument2 + (argument5 * argument6));
        p = matrix_transform_vertex(M, clamp(b[0], -1, 1), clamp(b[1], -1, 1), clamp(b[2], -1, 1));
        d = dot_product_3d(p[0] - argument0, p[1] - argument1, p[2] - argument2, argument3, argument4, argument5);
        d = clamp(d, 0, argument6);
        var rx2 = argument0 + (argument3 * d);
        var ry2 = argument1 + (argument4 * d);
        var rz2 = argument2 + (argument5 * d);
        var d2 = colmesh_vector_square(rx2 - p[0], ry2 - p[1], rz2 - p[2]);
        
        if (d2 < d1)
        {
            ret[0] = rx2;
            ret[1] = ry2;
            ret[2] = rz2;
            return ret;
        }
        
        ret[0] = rx1;
        ret[1] = ry1;
        ret[2] = rz1;
        return ret;
    };
    
    static _castRay = function(argument0, argument1 = 1)
    {
        var o = matrix_transform_vertex(I, argument0[0], argument0[1], argument0[2]);
        var e = matrix_transform_vertex(I, argument0[3], argument0[4], argument0[5]);
        var x1 = o[0];
        var y1 = o[1];
        var z1 = o[2];
        var x2 = e[0];
        var y2 = e[1];
        var z2 = e[2];
        var tmin = 1;
        var nx = 0;
        var ny = 0;
        var nz = 1;
        var intersection = false;
        var insideBlock = true;
        
        if (x2 != x1 && abs(x1) > 1)
        {
            insideBlock = false;
            var s = sign(x1 - x2);
            var t = (s - x1) / (x2 - x1);
            
            if (t >= 0 && t <= 1)
            {
                var itsY = lerp(y1, y2, t);
                var itsZ = lerp(z1, z2, t);
                
                if (abs(itsY) <= 1 && abs(itsZ) <= 1)
                {
                    x2 = s;
                    y2 = itsY;
                    z2 = itsZ;
                    s = sign(x1) * lx;
                    nx = M[0] * s;
                    ny = M[1] * s;
                    nz = M[2] * s;
                    intersection = true;
                    tmin *= t;
                }
            }
        }
        
        if (y2 != y1 && abs(y1) > 1)
        {
            insideBlock = false;
            var s = sign(y1 - y2);
            var t = (s - y1) / (y2 - y1);
            
            if (t >= 0 && t <= 1)
            {
                var itsX = lerp(x1, x2, t);
                var itsZ = lerp(z1, z2, t);
                
                if (abs(itsX) <= 1 && abs(itsZ) <= 1)
                {
                    x2 = itsX;
                    y2 = s;
                    z2 = itsZ;
                    s = sign(y1) * ly;
                    nx = M[4] * s;
                    ny = M[5] * s;
                    nz = M[6] * s;
                    intersection = true;
                    tmin *= t;
                }
            }
        }
        
        if (z2 != z1 && abs(z1) > 1)
        {
            insideBlock = false;
            var s = sign(z1 - z2);
            var t = (s - z1) / (z2 - z1);
            
            if (t >= 0 && t <= 1)
            {
                var itsX = lerp(x1, x2, t);
                var itsY = lerp(y1, y2, t);
                
                if (abs(itsX) <= 1 && abs(itsY) <= 1)
                {
                    x2 = itsX;
                    y2 = itsY;
                    z2 = s;
                    s = sign(z1) * lz;
                    nx = M[8] * s;
                    ny = M[0] * s;
                    nz = M[10] * s;
                    intersection = true;
                    tmin *= t;
                }
            }
        }
        
        if (insideBlock || !intersection)
            return false;
        
        var p = matrix_transform_vertex(M, x2, y2, z2);
        return [p[0], p[1], p[2], nx, ny, nz, self, tmin];
    };
    
    static _getClosestPoint = function(argument0, argument1, argument2)
    {
        var p = matrix_transform_vertex(I, argument0, argument1, argument2);
        var bx = p[0];
        var by = p[1];
        var bz = p[2];
        var b = max(abs(bx), abs(by), abs(bz));
        
        if (b <= 1)
        {
            if (b == abs(bx))
                bx = sign(bx);
            else if (b == abs(by))
                by = sign(by);
            else
                bz = sign(bz);
            
            return matrix_transform_vertex(M, bx, by, bz);
        }
        
        return matrix_transform_vertex(M, clamp(bx, -1, 1), clamp(by, -1, 1), clamp(bz, -1, 1));
    };
    
    static _displaceSphere = function(argument0, argument1, argument2, argument3, argument4)
    {
        var p = matrix_transform_vertex(I, argument1, argument2, argument3);
        var bx = p[0];
        var by = p[1];
        var bz = p[2];
        var b = max(abs(bx), abs(by), abs(bz));
        
        if (b <= 1)
        {
            var nx, ny, nz;
            
            if (b == abs(bx))
            {
                nx = M[0] * lx;
                ny = M[1] * lx;
                nz = M[2] * lx;
            }
            else if (b == abs(by))
            {
                by = sign(by);
                nx = M[4] * ly;
                ny = M[5] * ly;
                nz = M[6] * ly;
            }
            else
            {
                bz = sign(bz);
                nx = M[8] * lz;
                ny = M[9] * lz;
                nz = M[10] * lz;
            }
            
            p = matrix_transform_vertex(M, bx, by, bz);
            d = argument4 - dot_product_3d(argument1 - p[0], argument2 - p[1], argument3 - p[2], nx, ny, nz);
            return argument0.displace(nx * d, ny * d, nz * d);
        }
        
        p = matrix_transform_vertex(M, clamp(bx, -1, 1), clamp(by, -1, 1), clamp(bz, -1, 1));
        var dx = argument1 - p[0];
        var dy = argument2 - p[1];
        dy = argument2 - p[1];
        var dz = argument3 - p[2];
        var d = point_distance_3d(dx, dy, dz, 0, 0, 0);
        
        if (d == 0 || d > argument4)
            return false;
        
        d = (argument4 - d) / d;
        return argument0.displace(dx * d, dy * d, dz * d);
    };
    
    static _getPriority = function(argument0, argument1, argument2, argument3)
    {
        var b = matrix_transform_vertex(I, argument0, argument1, argument2);
        
        if (max(abs(b[0]), abs(b[1]), abs(b[2])) <= 1)
            return 0;
        
        var p = matrix_transform_vertex(M, clamp(b[0], -1, 1), clamp(b[1], -1, 1), clamp(b[2], -1, 1));
        var d = point_distance_3d(argument0, argument1, argument2, p[0], p[1], p[2]);
        
        if (d > argument3)
            return -1;
        
        return d * d;
    };
    
    static _intersectsCube = function(argument0, argument1, argument2, argument3)
    {
        var b = matrix_transform_vertex(I, argument1 + clamp(M[12] - argument1, -argument0, argument0), argument2 + clamp(M[13] - argument2, -argument0, argument0), argument3 + clamp(M[14] - argument3, -argument0, argument0));
        
        if (max(abs(b[0]), abs(b[1]), abs(b[2])) < 1)
            return true;
        
        b = matrix_transform_vertex(I, argument1, argument2, argument3);
        var p = matrix_transform_vertex(M, clamp(b[0], -1, 1), clamp(b[1], -1, 1), clamp(b[2], -1, 1));
        
        if (max(abs(p[0] - argument1), abs(p[1] - argument2), abs(p[2] - argument3)) < argument0)
            return true;
        
        return false;
    };
    
    static debugDraw = function(argument0 = -1)
    {
        static vbuff = global.ColMeshDebugShapes[Colmesh_shapes.block];
        
        if (vbuff < 0)
        {
            global.ColMeshDebugShapes[Colmesh_shapes.block] = colmesh_create_block(1, 1);
            vbuff = global.ColMeshDebugShapes[Colmesh_shapes.block];
        }
        
        var sh = shader_current();
        shader_set_uniform_f(shader_get_uniform(shader_current(), "u_radius"), 0);
        var W = matrix_get(2);
        matrix_set(2, matrix_multiply(M, W));
        vertex_submit(vbuff, pr_trianglelist, argument0);
        matrix_set(2, W);
    };
    
    static toString = function()
    {
        return "ColMesh shape: Block. Group: " + string(group) + ". Matrix: " + string(M);
    };
    
    type = Colmesh_shapes.block;
    lx = 1 / point_distance_3d(0, 0, 0, argument0[0], argument0[1], argument0[2]);
    ly = 1 / point_distance_3d(0, 0, 0, argument0[4], argument0[5], argument0[6]);
    lz = 1 / point_distance_3d(0, 0, 0, argument0[8], argument0[9], argument0[10]);
    var m = array_create(16);
    array_copy(m, 0, argument0, 0, 16);
    colmesh_matrix_orthogonalize(m);
    M = colmesh_matrix_scale(m, 1 / lx, 1 / ly, 1 / lz);
    I = colmesh_matrix_invert_fast(argument0);
}

function colmesh_dynamic(argument0, argument1, argument2 = 1) : colmesh_shapes(argument2) constructor
{
    static toString = function()
    {
        return "ColMesh shape: Dynamic. Group: " + string(group) + ". Matrix: " + string(M) + ". \n\tSubmesh: [" + string(shape) + "]";
    };
    
    static capsuleCollision = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7)
    {
        if (global.ColMeshRecursionCounter >= 8)
            return false;
        
        var p = matrix_transform_vertex(I, argument0, argument1, argument2);
        var u = colmesh_matrix_transform_vector(I, argument3 * scale, argument4 * scale, argument5 * scale);
        global.ColMeshRecursionCounter++;
        var col = shape.capsuleCollision(p[0], p[1], p[2], u[0], u[1], u[2], argument6 / scale, argument7 / scale);
        global.ColMeshRecursionCounter--;
        return col;
    };
    
    static checkAABB = function(argument0, argument1, argument2, argument3, argument4, argument5)
    {
        if (shape.type == Colmesh_shapes.uninitializedmesh)
        {
            mm = shape.getMinMax();
            var block = matrix_multiply(matrix_build((mm[0] + mm[3]) * 0.5, (mm[1] + mm[4]) * 0.5, (mm[2] + mm[5]) * 0.5, 0, 0, 0, (mm[3] - mm[0]) * 0.5, (mm[4] - mm[1]) * 0.5, (mm[5] - mm[2]) * 0.5), M);
            return colmesh_block_intersects_AABB(block, argument0, argument1, argument2, argument3, argument4, argument5);
        }
        
        var mm = getMinMax();
        
        if (mm[0] < argument3 && mm[1] < argument4 && mm[2] < argument5 && mm[3] > argument0 && mm[4] > argument1 && mm[5] > argument2)
            return true;
        
        return false;
    };
    
    static setMatrix = function(argument0, argument1 = true)
    {
        static oldReg = array_create(6);
        
        var mm = getMinMax();
        moving = argument1;
        array_copy(M, 0, argument0, 0, 16);
        var sqrScale = dot_product_3d(M[0], M[1], M[2], M[0], M[1], M[2]);
        var sideDp = dot_product_3d(M[0], M[1], M[2], M[4], M[5], M[6]) / sqrScale;
        M[4] -= M[0] * sideDp;
        M[5] -= M[1] * sideDp;
        M[6] -= M[2] * sideDp;
        var l = point_distance_3d(0, 0, 0, M[4], M[5], M[6]);
        
        if (l <= 0)
            return false;
        
        scale = sqrt(sqrScale);
        l = scale / l;
        M[4] *= l;
        M[5] *= l;
        M[6] *= l;
        var m8 = M[8];
        var m9 = M[9];
        var m10 = M[10];
        M[8] = ((M[1] * M[6]) - (M[2] * M[5])) / scale;
        M[9] = ((M[2] * M[4]) - (M[0] * M[6])) / scale;
        M[10] = ((M[0] * M[5]) - (M[1] * M[4])) / scale;
        var s = sign(dot_product_3d(M[8], M[9], M[10], m8, m9, m10));
        M[8] *= s;
        M[9] *= s;
        M[10] *= s;
        M[3] = 0;
        M[7] = 0;
        M[11] = 0;
        M[15] = 1;
        
        if (moving)
            array_copy(pI, 0, I, 0, 16);
        
        colmesh_matrix_invert_fast(M, I);
        
        if (is_struct(colMesh))
        {
            array_copy(oldReg, 0, colMesh._getRegions(mm), 0, 6);
            mm = getMinMax(true);
            colMesh._expandBoundaries(mm);
            var newReg = colMesh._getRegions(mm);
            
            if (!array_equals(oldReg, newReg))
            {
                colMesh.removeShapeFromSubdiv(self, oldReg);
                colMesh.addShapeToSubdiv(self, newReg, !moving);
            }
        }
    };
    
    static move3D = function(argument0, argument1, argument2, argument3)
    {
        static temp = matrix_build_identity();
        
        array_copy(temp, 0, M, 0, 16);
        temp[12] = argument1;
        temp[13] = argument2;
        temp[14] = argument3;
        setMatrix(temp, true);
    };
    
    static getMinMax = function(argument0 = true)
    {
        static prevLocalMinMax = array_create(6);
        
        var mm = shape.getMinMax();
        
        if (argument0 || !array_equals(mm, prevLocalMinMax))
        {
            array_copy(prevLocalMinMax, 0, mm, 0, 6);
            mm = shape.getMinMax();
            var xs = (mm[3] - mm[0]) * 0.5;
            var ys = (mm[4] - mm[1]) * 0.5;
            var zs = (mm[5] - mm[2]) * 0.5;
            var mx = (mm[0] + mm[3]) * 0.5;
            var my = (mm[1] + mm[4]) * 0.5;
            var mz = (mm[2] + mm[5]) * 0.5;
            var t = matrix_transform_vertex(M, mx, my, mz);
            var dx = abs(M[0] * xs) + abs(M[4] * ys) + abs(M[8] * zs);
            var dy = abs(M[1] * xs) + abs(M[5] * ys) + abs(M[9] * zs);
            var dz = abs(M[2] * xs) + abs(M[6] * ys) + abs(M[10] * zs);
            minMax[0] = t[0] - dx;
            minMax[1] = t[1] - dy;
            minMax[2] = t[2] - dz;
            minMax[3] = t[0] + dx;
            minMax[4] = t[1] + dy;
            minMax[5] = t[2] + dz;
        }
        
        return minMax;
    };
    
    static _castRay = function(argument0, argument1 = 1)
    {
        static _ray = array_create(6);
        
        array_copy(_ray, 0, matrix_transform_vertex(I, argument0[0], argument0[1], argument0[2]), 0, 3);
        array_copy(_ray, 3, matrix_transform_vertex(I, argument0[3], argument0[4], argument0[5]), 0, 3);
        
        if (shape.type == Colmesh_shapes.uninitializedmesh)
        {
            if (global.ColMeshRecursionCounter >= 8)
                return true;
            
            global.ColMeshRecursionCounter++;
            rayResult = shape.castRay(_ray[0], _ray[1], _ray[2], _ray[3], _ray[4], _ray[5], argument1);
            global.ColMeshRecursionCounter--;
            
            if (!rayResult.hit)
                return true;
            
            var p = matrix_transform_vertex(M, rayResult.x, rayResult.y, rayResult.z);
            var n = colmesh_matrix_transform_vector(M, rayResult.nx, rayResult.ny, rayResult.nz);
            var dx = argument0[3] - argument0[0];
            var dy = argument0[4] - argument0[1];
            var dz = argument0[5] - argument0[2];
            var t = dot_product_3d(p[0] - argument0[0], p[1] - argument0[1], p[2] - argument0[2], dx, dy, dz) / dot_product_3d(dx, dy, dz, dx, dy, dz);
            return [p[0], p[1], p[2], n[0], n[1], n[2], rayResult.struct, t];
        }
        else
        {
            intersection = shape._castRay(_ray, argument1);
            
            if (!is_array(intersection))
                return false;
            
            var p = matrix_transform_vertex(M, intersection[0], intersection[1], intersection[2]);
            var n = colmesh_matrix_transform_vector(M, intersection[3] / scale, intersection[4] / scale, intersection[5] / scale);
            return [p[0], p[1], p[2], n[0], n[1], n[2], shape, intersection[7]];
        }
    };
    
    static _getClosestPoint = function(argument0, argument1, argument2)
    {
        if (shape.type == Colmesh_shapes.uninitializedmesh)
        {
            p = matrix_transform_vertex(I, argument0, argument1, argument2);
            var bx = p[0];
            var by = p[1];
            var bz = p[2];
            var b = max(abs(bx), abs(by), abs(bz));
            
            if (b <= 1)
            {
                if (b == abs(bx))
                    bx = sign(bx);
                else if (b == abs(by))
                    by = sign(by);
                else
                    bz = sign(bz);
                
                p = matrix_transform_vertex(M, bx, by, bz);
            }
            else
            {
                bx = clamp(bx, -1, 1);
                by = clamp(by, -1, 1);
                bz = clamp(bz, -1, 1);
                p = matrix_transform_vertex(M, bx, by, bz);
            }
            
            return p;
        }
        
        var p = matrix_transform_vertex(I, argument0, argument1, argument2);
        var n = shape._getClosestPoint(p[0], p[1], p[2]);
        return matrix_transform_vertex(M, n[0], n[1], n[2]);
    };
    
    static _capsuleGetRef = function(argument0, argument1, argument2, argument3, argument4, argument5, argument6)
    {
        static ret = array_create(3);
        
        if (shape.type == Colmesh_shapes.uninitializedmesh)
        {
            ret[0] = argument0;
            ret[1] = argument1;
            ret[2] = argument2;
            return ret;
        }
        
        var p = matrix_transform_vertex(I, argument0, argument1, argument2);
        var u = colmesh_matrix_transform_vector(I, argument3 * scale, argument4 * scale, argument5 * scale);
        var r = shape._capsuleGetRef(p[0], p[1], p[2], u[0], u[1], u[2], argument6 / scale);
        return matrix_transform_vertex(M, r[0], r[1], r[2]);
    };
    
    static _intersectsCube = function(argument0, argument1, argument2, argument3)
    {
        if (shape.type == Colmesh_shapes.uninitializedmesh)
        {
            mm = shape.getMinMax();
            var b = matrix_transform_vertex(I, argument1, argument2, argument3);
            var s = argument0 * scale;
            var AABB = [b[0] - s, b[1] - s, b[2] - s, b[0] + s, b[1] + s, b[2] + s];
            AABB[0] = max(AABB[0], mm[0]);
            AABB[1] = max(AABB[1], mm[1]);
            AABB[2] = max(AABB[2], mm[2]);
            AABB[3] = min(AABB[3], mm[3]);
            AABB[4] = min(AABB[4], mm[4]);
            AABB[5] = min(AABB[5], mm[5]);
            AABB[0] = floor(AABB[0] / shape.regionSize);
            AABB[1] = floor(AABB[1] / shape.regionSize);
            AABB[2] = floor(AABB[2] / shape.regionSize);
            AABB[3] = floor(AABB[3] / shape.regionSize);
            AABB[4] = floor(AABB[4] / shape.regionSize);
            AABB[5] = floor(AABB[5] / shape.regionSize);
            var xNum = (AABB[3] - AABB[0]) + 1;
            var yNum = (AABB[4] - AABB[1]) + 1;
            var zNum = (AABB[5] - AABB[2]) + 1;
            var xx = 0;
            
            repeat (xNum)
            {
                var _x = (xx++ + 0.5) * shape.regionSize;
                var yy = 0;
                
                repeat (yNum)
                {
                    var _y = (yy++ + 0.5) * shape.regionSize;
                    var zz = 0;
                    
                    repeat (zNum)
                    {
                        var _z = (zz++ + 0.5) * shape.regionSize;
                        var key = colmesh_get_key(_x, _y, _z);
                        
                        if (!is_undefined(shape.spHash[? key]))
                            return true;
                    }
                }
            }
        }
        
        var mm = minMax;
        return mm[0] < (argument1 + argument0) && mm[1] < (argument2 + argument0) && mm[2] < (argument3 + argument0) && mm[3] > (argument1 - argument0) && mm[4] > (argument2 - argument0) && mm[5] > (argument3 - argument0);
    };
    
    static _displaceSphere = function(argument0, argument1, argument2, argument3, argument4)
    {
        var tempR = argument0.radius;
        var tempH = argument0.height;
        var slope = argument0.slope;
        argument0.transform(I, scale);
        var col = false;
        
        if (shape.type == Colmesh_shapes.uninitializedmesh)
        {
            if (global.ColMeshRecursionCounter < 8)
            {
                global.ColMeshRecursionCounter++;
                col = argument0.avoid(shape);
                global.ColMeshRecursionCounter--;
            }
        }
        else
        {
            var p = matrix_transform_vertex(I, argument1, argument2, argument3);
            col = shape._displaceSphere(argument0, p[0], p[1], p[2], argument0.radius);
        }
        
        if (col && slope < 1)
        {
            if (moving)
            {
                array_push(argument0.transformQueue, M);
                array_push(argument0.transformQueue, pI);
            }
            else if (array_length(argument0.transformQueue) > 0)
            {
                array_push(argument0.transformQueue, M);
                array_push(argument0.transformQueue, I);
            }
        }
        
        argument0.transform(M, 1 / scale);
        argument0.radius = tempR;
        argument0.height = tempH;
        return col;
    };
    
    static _getPriority = function(argument0, argument1, argument2, argument3)
    {
        if (shape.type == Colmesh_shapes.uninitializedmesh)
            return 0;
        
        var p = matrix_transform_vertex(I, argument0, argument1, argument2);
        var pri = shape._getPriority(p[0], p[1], p[2], argument3 / scale);
        return pri * scale * scale;
    };
    
    static debugDraw = function(argument0)
    {
        var W = matrix_get(2);
        matrix_set(2, matrix_multiply(M, W));
        
        if (shape.type == Colmesh_shapes.uninitializedmesh)
        {
            if (global.ColMeshRecursionCounter < 8)
            {
                global.ColMeshRecursionCounter++;
                shape.debugDraw(-1, argument0);
                global.ColMeshRecursionCounter--;
            }
        }
        else
        {
            shape.debugDraw(argument0);
        }
        
        matrix_set(2, W);
    };
    
    type = Colmesh_shapes.dynamicmesh;
    shape = argument0;
    colMesh = -1;
    M = matrix_build_identity();
    I = matrix_build_identity();
    pI = matrix_build_identity();
    scale = 1;
    moving = false;
    minMax = array_create(6);
    setMatrix(argument1, false);
}

function colmesh_none() constructor
{
    static capsuleCollision = function()
    {
        return false;
    };
    
    static _displace = function()
    {
    };
    
    static getMinMax = function()
    {
        return array_create(6);
    };
    
    static _capsuleGetRef = function()
    {
        static ret = array_create(3);
        
        return ret;
    };
    
    static _castRay = function()
    {
        return array_create(8);
    };
    
    static _displaceSphere = function()
    {
        return false;
    };
    
    static _getPriority = function()
    {
        return -1;
    };
    
    static _getClosestPoint = function()
    {
        static ret = array_create(3);
        
        return ret;
    };
    
    static _intersectsCube = function()
    {
        return false;
    };
    
    type = Colmesh_shapes.none;
}
