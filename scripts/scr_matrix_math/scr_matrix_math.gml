function colmesh_vector_square(argument0, argument1, argument2)
{
    return dot_product_3d(argument0, argument1, argument2, argument0, argument1, argument2);
}

function colmesh_matrix_transpose(argument0)
{
    return [argument0[0], argument0[4], argument0[8], argument0[12], argument0[1], argument0[5], argument0[9], argument0[13], argument0[2], argument0[6], argument0[10], argument0[14], argument0[3], argument0[7], argument0[11], argument0[15]];
}

function colmesh_matrix_invert_fast(argument0, argument1 = array_create(16))
{
    var m0 = argument0[0];
    var m1 = argument0[1];
    var m2 = argument0[2];
    var m4 = argument0[4];
    var m5 = argument0[5];
    var m6 = argument0[6];
    var m8 = argument0[8];
    var m9 = argument0[9];
    var m10 = argument0[10];
    var m12 = argument0[12];
    var m13 = argument0[13];
    var m14 = argument0[14];
    var i0 = (m5 * m10) - (m9 * m6);
    var i4 = (m8 * m6) - (m4 * m10);
    var i8 = (m4 * m9) - (m8 * m5);
    var det = dot_product_3d(m0, m1, m2, i0, i4, i8);
    
    if (det == 0)
    {
        show_debug_message("Error in function colmesh_matrix_invert_fast: The determinant is zero.");
        return argument0;
    }
    
    var invDet = 1 / det;
    array_set(argument1, 0, invDet * i0);
    array_set(argument1, 1, invDet * ((m9 * m2) - (m1 * m10)));
    array_set(argument1, 2, invDet * ((m1 * m6) - (m5 * m2)));
    array_set(argument1, 3, 0);
    array_set(argument1, 4, invDet * i4);
    array_set(argument1, 5, invDet * ((m0 * m10) - (m8 * m2)));
    array_set(argument1, 6, invDet * ((m4 * m2) - (m0 * m6)));
    array_set(argument1, 7, 0);
    array_set(argument1, 8, invDet * i8);
    array_set(argument1, 9, invDet * ((m8 * m1) - (m0 * m9)));
    array_set(argument1, 10, invDet * ((m0 * m5) - (m4 * m1)));
    array_set(argument1, 11, 0);
    array_set(argument1, 12, -dot_product_3d(m12, m13, m14, argument1[0], argument1[4], argument1[8]));
    array_set(argument1, 13, -dot_product_3d(m12, m13, m14, argument1[1], argument1[5], argument1[9]));
    array_set(argument1, 14, -dot_product_3d(m12, m13, m14, argument1[2], argument1[6], argument1[10]));
    array_set(argument1, 15, dot_product_3d(m8, m9, m10, argument1[2], argument1[6], argument1[10]));
    return argument1;
}

function colmesh_matrix_invert(argument0, argument1 = array_create(16))
{
    var m0 = argument0[0];
    var m1 = argument0[1];
    var m2 = argument0[2];
    var m3 = argument0[3];
    var m4 = argument0[4];
    var m5 = argument0[5];
    var m6 = argument0[6];
    var m7 = argument0[7];
    var m8 = argument0[8];
    var m9 = argument0[9];
    var m10 = argument0[10];
    var m11 = argument0[11];
    var m12 = argument0[12];
    var m13 = argument0[13];
    var m14 = argument0[14];
    var m15 = argument0[15];
    var a = (m5 * m10) - (m9 * m6);
    var d = (m8 * m6) - (m4 * m10);
    var g = (m4 * m9) - (m8 * m5);
    var j = (m6 * m11) - (m7 * m10);
    var m = (m9 * m7) - (m5 * m11);
    var p = (m4 * m11) - (m8 * m7);
    var i0 = dot_product_3d(m13, m14, m15, j, m, a);
    var i4 = dot_product_3d(m12, m14, m15, -j, p, d);
    var i8 = dot_product_3d(m12, m13, m15, -m, -p, g);
    var i12 = dot_product_3d(m12, m13, m14, -a, -d, -g);
    var det = (m0 * i0) + (m1 * i4) + (m2 * i8) + (m3 * i12);
    
    if (det == 0)
    {
        show_debug_message("Error in function colmesh_matrix_invert: The determinant is zero.");
        return argument0;
    }
    
    var b = (m9 * m2) - (m1 * m10);
    var c = (m1 * m6) - (m5 * m2);
    var e = (m0 * m10) - (m8 * m2);
    var f = (m4 * m2) - (m0 * m6);
    var h = (m8 * m1) - (m0 * m9);
    var i = (m0 * m5) - (m4 * m1);
    var k = (m3 * m10) - (m2 * m11);
    var l = (m2 * m7) - (m3 * m6);
    var n = (m1 * m11) - (m9 * m3);
    var o = (m5 * m3) - (m1 * m7);
    var q = (m8 * m3) - (m0 * m11);
    var r = (m0 * m7) - (m4 * m3);
    var invDet = 1 / det;
    array_set(argument1, 0, invDet * i0);
    array_set(argument1, 1, invDet * dot_product_3d(m13, m14, m15, k, n, b));
    array_set(argument1, 2, invDet * dot_product_3d(m13, m14, m15, l, o, c));
    array_set(argument1, 3, invDet * dot_product_3d(m3, m7, m11, -a, -b, -c));
    array_set(argument1, 4, invDet * i4);
    array_set(argument1, 5, invDet * dot_product_3d(m12, m14, m15, -k, q, e));
    array_set(argument1, 6, invDet * dot_product_3d(m12, m14, m15, -l, r, f));
    array_set(argument1, 7, invDet * dot_product_3d(m3, m7, m11, -d, -e, -f));
    array_set(argument1, 8, invDet * i8);
    array_set(argument1, 9, invDet * dot_product_3d(m12, m13, m15, -n, -q, h));
    array_set(argument1, 10, invDet * dot_product_3d(m12, m13, m15, -o, -r, i));
    array_set(argument1, 11, invDet * dot_product_3d(m3, m7, m11, -g, -h, -i));
    array_set(argument1, 12, invDet * i12);
    array_set(argument1, 13, invDet * dot_product_3d(m12, m13, m14, -b, -e, -h));
    array_set(argument1, 14, invDet * dot_product_3d(m12, m13, m14, -c, -f, -i));
    array_set(argument1, 15, invDet * dot_product_3d(m0, m4, m8, a, b, c));
    return argument1;
}

function colmesh_matrix_build(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8)
{
    var M = matrix_build(argument0, argument1, argument2, argument3, argument4, argument5, 1, 1, 1);
    return colmesh_matrix_scale(M, argument6, argument7, argument8);
}

function colmesh_matrix_orthogonalize(argument0)
{
    var l = point_distance_3d(0, 0, 0, argument0[8], argument0[9], argument0[10]);
    
    if (l != 0)
    {
        l = 1 / l;
        array_set(argument0, 8, array_get(argument0, 8) * l);
        array_set(argument0, 9, array_get(argument0, 9) * l);
        array_set(argument0, 10, array_get(argument0, 10) * l);
    }
    else
    {
        argument0[10] = 1;
    }
    
    array_set(argument0, 4, (argument0[9] * argument0[2]) - (argument0[10] * argument0[1]));
    array_set(argument0, 5, (argument0[10] * argument0[0]) - (argument0[8] * argument0[2]));
    array_set(argument0, 6, (argument0[8] * argument0[1]) - (argument0[9] * argument0[0]));
    l = point_distance_3d(0, 0, 0, argument0[4], argument0[5], argument0[6]);
    
    if (l != 0)
    {
        l = 1 / l;
        array_set(argument0, 4, array_get(argument0, 4) * l);
        array_set(argument0, 5, array_get(argument0, 5) * l);
        array_set(argument0, 6, array_get(argument0, 6) * l);
    }
    else
    {
        argument0[5] = 1;
    }
    
    array_set(argument0, 0, (argument0[10] * argument0[5]) - (argument0[9] * argument0[6]));
    array_set(argument0, 1, (argument0[8] * argument0[6]) - (argument0[10] * argument0[4]));
    array_set(argument0, 2, (argument0[9] * argument0[4]) - (argument0[8] * argument0[5]));
    return argument0;
}

function colmesh_matrix_orthogonalize_to(argument0)
{
    var l = sqrt(dot_product_3d(argument0[0], argument0[1], argument0[2], argument0[0], argument0[1], argument0[2]));
    
    if (l != 0)
    {
        l = 1 / l;
        array_set(argument0, 0, array_get(argument0, 0) * l);
        array_set(argument0, 1, array_get(argument0, 1) * l);
        array_set(argument0, 2, array_get(argument0, 2) * l);
    }
    else
    {
        argument0[0] = 1;
    }
    
    array_set(argument0, 4, (argument0[9] * argument0[2]) - (argument0[10] * argument0[1]));
    array_set(argument0, 5, (argument0[10] * argument0[0]) - (argument0[8] * argument0[2]));
    array_set(argument0, 6, (argument0[8] * argument0[1]) - (argument0[9] * argument0[0]));
    l = sqrt(dot_product_3d(argument0[4], argument0[5], argument0[6], argument0[4], argument0[5], argument0[6]));
    
    if (l != 0)
    {
        l = 1 / l;
        array_set(argument0, 4, array_get(argument0, 4) * l);
        array_set(argument0, 5, array_get(argument0, 5) * l);
        array_set(argument0, 6, array_get(argument0, 6) * l);
    }
    else
    {
        argument0[5] = 1;
    }
    
    array_set(argument0, 8, (argument0[1] * argument0[6]) - (argument0[2] * argument0[5]));
    array_set(argument0, 9, (argument0[2] * argument0[4]) - (argument0[0] * argument0[6]));
    array_set(argument0, 10, (argument0[0] * argument0[5]) - (argument0[1] * argument0[4]));
    return argument0;
}

function colmesh_matrix_scale(argument0, argument1, argument2, argument3)
{
    array_set(argument0, 0, array_get(argument0, 0) * argument1);
    array_set(argument0, 1, array_get(argument0, 1) * argument1);
    array_set(argument0, 2, array_get(argument0, 2) * argument1);
    array_set(argument0, 4, array_get(argument0, 4) * argument2);
    array_set(argument0, 5, array_get(argument0, 5) * argument2);
    array_set(argument0, 6, array_get(argument0, 6) * argument2);
    array_set(argument0, 8, array_get(argument0, 8) * argument3);
    array_set(argument0, 9, array_get(argument0, 9) * argument3);
    array_set(argument0, 10, array_get(argument0, 10) * argument3);
    return argument0;
}

function colmesh_matrix_build_from_vector(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9 = [abs(argument3) < abs(argument4), 1, 1, 0, 0, 0, 0, 0, argument3, argument4, argument5, 0, argument0, argument1, argument2, 1])
{
    array_set(argument9, 0, abs(argument3) < abs(argument4));
    array_set(argument9, 1, 1);
    array_set(argument9, 2, 1);
    array_set(argument9, 3, 0);
    array_set(argument9, 4, 0);
    array_set(argument9, 5, 0);
    array_set(argument9, 6, 0);
    array_set(argument9, 7, 0);
    array_set(argument9, 8, argument3);
    array_set(argument9, 9, argument4);
    array_set(argument9, 10, argument5);
    array_set(argument9, 11, 0);
    array_set(argument9, 12, argument0);
    array_set(argument9, 13, argument1);
    array_set(argument9, 14, argument2);
    array_set(argument9, 15, 1);
    colmesh_matrix_orthogonalize(argument9);
    return colmesh_matrix_scale(argument9, argument6, argument7, argument8);
}

function colmesh_matrix_transform_vertex(argument0, argument1, argument2, argument3)
{
    static ret = array_create(3);
    
    array_set(ret, 0, argument0[12] + dot_product_3d(argument1, argument2, argument3, argument0[0], argument0[4], argument0[8]));
    array_set(ret, 1, argument0[13] + dot_product_3d(argument1, argument2, argument3, argument0[1], argument0[5], argument0[9]));
    array_set(ret, 2, argument0[14] + dot_product_3d(argument1, argument2, argument3, argument0[2], argument0[6], argument0[10]));
    return ret;
}

function colmesh_matrix_transform_vector(argument0, argument1, argument2, argument3)
{
    var ret = matrix_transform_vertex(argument0, argument1, argument2, argument3);
    ret[0] -= argument0[12];
    ret[1] -= argument0[13];
    ret[2] -= argument0[14];
    return ret;
}

function colmesh_cast_ray_sphere(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10 = false)
{
    static ret = array_create(3);
    
    var dx = argument0 - argument4;
    var dy = argument1 - argument5;
    var dz = argument2 - argument6;
    var vx = argument7 - argument4;
    var vy = argument8 - argument5;
    var vz = argument9 - argument6;
    var v = dot_product_3d(vx, vy, vz, vx, vy, vz);
    var d = dot_product_3d(dx, dy, dz, dx, dy, dz);
    var t = dot_product_3d(vx, vy, vz, dx, dy, dz);
    var u = (t * t) + (v * ((argument3 * argument3) - d));
    
    if (u < 0)
        return -1;
    
    u = sqrt(max(u, 0));
    
    if (t < u)
    {
        if (!argument10)
            return -1;
        
        t += u;
        
        if (t < 0)
            return -1;
    }
    else
    {
        t -= u;
        
        if (t > v)
            return -1;
    }
    
    return t / v;
    t /= v;
    ret[0] = argument4 + (vx * t);
    ret[1] = argument5 + (vy * t);
    ret[2] = argument6 + (vz * t);
    return ret;
}

function colmesh_cast_ray_plane(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10, argument11)
{
    static ret = array_create(6);
    
    var vx = argument9 - argument6;
    var vy = argument10 - argument7;
    var vz = argument11 - argument8;
    var dn = dot_product_3d(vx, vy, vz, argument3, argument4, argument5);
    
    if (dn == 0)
        return [argument9, argument10, argument11, 0, 0, 0, false];
    
    var dp = dot_product_3d(argument6 - argument0, argument7 - argument1, argument8 - argument2, argument3, argument4, argument5);
    var t = -dp / dn;
    var s = sign(dp);
    ret[0] = argument6 + (t * vx);
    ret[1] = argument7 + (t * vy);
    ret[2] = argument8 + (t * vz);
    ret[3] = s * argument3;
    ret[4] = s * argument4;
    ret[5] = s * argument5;
    ret[6] = true;
    return ret;
}
