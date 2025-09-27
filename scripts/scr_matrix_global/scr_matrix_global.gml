function colmesh_sphere_intersects_cube(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7)
{
    var distSqr = argument3 * argument3;
    var d = (argument0 - argument5) + argument4;
    
    if (d < 0)
    {
        distSqr -= (d * d);
    }
    else
    {
        d = argument0 - argument5 - argument4;
        
        if (d > 0)
            distSqr -= (d * d);
    }
    
    d = (argument1 - argument6) + argument4;
    
    if (d < 0)
    {
        distSqr -= (d * d);
    }
    else
    {
        d = argument1 - argument6 - argument4;
        
        if (d > 0)
            distSqr -= (d * d);
    }
    
    d = (argument2 - argument7) + argument4;
    
    if (d < 0)
    {
        distSqr -= (d * d);
    }
    else
    {
        d = argument2 - argument7 - argument4;
        
        if (d > 0)
            distSqr -= (d * d);
    }
    
    return distSqr > 0;
}

function colmesh_block_intersects_AABB(argument0, argument1, argument2, argument3, argument4, argument5, argument6)
{
    static I = array_create(16);
    
    colmesh_matrix_invert_fast(argument0, I);
    var b = matrix_transform_vertex(I, clamp(argument0[12], argument1, argument4), clamp(argument0[13], argument2, argument5), clamp(argument0[14], argument3, argument6));
    
    if (max(abs(b[0]), abs(b[1]), abs(b[2])) <= 1)
        return true;
    
    var bX = (argument1 + argument4) * 0.5;
    var bY = (argument2 + argument5) * 0.5;
    var bZ = (argument3 + argument6) * 0.5;
    var sX = argument4 - bX;
    var sY = argument5 - bY;
    var sZ = argument6 - bZ;
    b = matrix_transform_vertex(I, bX, bY, bZ);
    var p = matrix_transform_vertex(argument0, clamp(b[0], -1, 1), clamp(b[1], -1, 1), clamp(b[2], -1, 1));
    
    if (max(abs(p[0] - bX) / sX, abs(p[1] - bY) / sY, abs(p[2] - bZ) / sZ) <= 1)
        return true;
    
    return false;
}

function colmesh_capsule_get_AABB(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7)
{
    static AABB = array_create(6);
    
    argument3 *= argument7;
    argument4 *= argument7;
    argument5 *= argument7;
    AABB[0] = (argument0 + min(argument3, 0)) - argument6;
    AABB[1] = (argument1 + min(argument4, 0)) - argument6;
    AABB[2] = (argument2 + min(argument5, 0)) - argument6;
    AABB[3] = argument0 + max(argument3, 0) + argument6;
    AABB[4] = argument1 + max(argument4, 0) + argument6;
    AABB[5] = argument2 + max(argument5, 0) + argument6;
    return AABB;
}

function colmesh_debug_message(argument0)
{
    show_debug_message(argument0);
}

function colmesh_load_obj_to_buffer(argument0)
{
    static read_face = function(argument0, argument1)
    {
        argument1 = string_delete(argument1, 1, string_pos(" ", argument1));
        
        if (string_char_at(argument1, string_length(argument1)) == " ")
            argument1 = string_copy(argument1, 0, string_length(argument1) - 1);
        
        var triNum = string_count(" ", argument1);
        var vertString = array_create(triNum + 1);
        var i;
        
        for (i = 0; i < triNum; i++)
        {
            vertString[i] = string_copy(argument1, 1, string_pos(" ", argument1));
            argument1 = string_delete(argument1, 1, string_pos(" ", argument1));
        }
        
        vertString[i--] = argument1;
        
        while (i--)
        {
            for (var j = 2; j >= 0; j--)
            {
                var vstr = vertString[(i + j) * (j > 0)];
                var v = 0;
                var n = 0;
                var t = 0;
                
                if (string_count("/", vstr) == 2 && string_count("//", vstr) == 0)
                {
                    v = abs(real(string_copy(vstr, 1, string_pos("/", vstr) - 1)));
                    vstr = string_delete(vstr, 1, string_pos("/", vstr));
                    t = abs(real(string_copy(vstr, 1, string_pos("/", vstr) - 1)));
                    n = abs(real(string_delete(vstr, 1, string_pos("/", vstr))));
                }
                else if (string_count("/", vstr) == 1)
                {
                    v = abs(real(string_copy(vstr, 1, string_pos("/", vstr) - 1)));
                    t = abs(real(string_delete(vstr, 1, string_pos("/", vstr))));
                }
                else if (string_count("/", vstr) == 0)
                {
                    v = abs(real(vstr));
                }
                else if (string_count("//", vstr) == 1)
                {
                    vstr = string_replace(vstr, "//", "/");
                    v = abs(real(string_copy(vstr, 1, string_pos("/", vstr) - 1)));
                    n = abs(real(string_delete(vstr, 1, string_pos("/", vstr))));
                }
                
                ds_list_add(argument0, [v - 1, n - 1, t - 1]);
            }
        }
    };
    
    static read_line = function(argument0)
    {
        argument0 = string_delete(argument0, 1, string_pos(" ", argument0));
        var retNum = string_count(" ", argument0) + 1;
        var ret = array_create(retNum);
        
        for (var i = 0; i < retNum; i++)
        {
            var pos = string_pos(" ", argument0);
            
            if (pos == 0)
            {
                pos = string_length(argument0);
                ret[i] = real(string_copy(argument0, 1, pos));
                break;
            }
            
            ret[i] = real(string_copy(argument0, 1, pos));
            argument0 = string_delete(argument0, 1, pos);
        }
        
        return ret;
    };
    
    var file = file_text_open_read(argument0);
    
    if (file == -1)
    {
        colmesh_debug_message("Failed to load model " + string(argument0));
        return -1;
    }
    
    colmesh_debug_message("Script colmesh_load_obj_to_buffer: Loading obj file " + string(argument0));
    var V = ds_list_create();
    var N = ds_list_create();
    var T = ds_list_create();
    var F = ds_list_create();
    
    while (!file_text_eof(file))
    {
        var str = string_replace_all(file_text_read_string(file), "  ", " ");
        
        switch (string_copy(str, 1, string_pos(" ", str) - 1))
        {
            case "v":
                ds_list_add(V, read_line(str));
                break;
            
            case "vn":
                ds_list_add(N, read_line(str));
                break;
            
            case "vt":
                ds_list_add(T, read_line(str));
                break;
            
            case "f":
                read_face(F, str);
                break;
        }
        
        file_text_readln(file);
    }
    
    file_text_close(file);
    var vertNum = ds_list_size(F);
    var mbuff = buffer_create(vertNum * 36, buffer_fixed, 1);
    
    for (var f = 0; f < vertNum; f++)
    {
        var vnt = F[| f];
        var v = V[| array_get(vnt, 0)];
        
        if (!is_array(v))
            v = [0, 0, 0];
        
        buffer_write(mbuff, buffer_f32, v[0]);
        buffer_write(mbuff, buffer_f32, v[2]);
        buffer_write(mbuff, buffer_f32, v[1]);
        var n = N[| array_get(vnt, 1)];
        
        if (!is_array(n))
            n = [0, 0, 1];
        
        buffer_write(mbuff, buffer_f32, n[0]);
        buffer_write(mbuff, buffer_f32, n[2]);
        buffer_write(mbuff, buffer_f32, n[1]);
        var t = T[| array_get(vnt, 2)];
        
        if (!is_array(t))
            t = [0, 0];
        
        buffer_write(mbuff, buffer_f32, t[0]);
        buffer_write(mbuff, buffer_f32, 1 - t[1]);
        buffer_write(mbuff, buffer_u8, 255);
        buffer_write(mbuff, buffer_u8, 255);
        buffer_write(mbuff, buffer_u8, 255);
        buffer_write(mbuff, buffer_u8, 255);
    }
    
    ds_list_destroy(F);
    ds_list_destroy(V);
    ds_list_destroy(N);
    ds_list_destroy(T);
    colmesh_debug_message("Script colmesh_load_obj_to_buffer: Successfully loaded obj " + string(argument0));
    return mbuff;
}

function colmesh_convert_smf(argument0)
{
    var mBuff = argument0.mBuff;
    var num = array_length(mBuff);
    var newBuff = buffer_create(1, buffer_grow, 1);
    var size = 0;
    num = array_length(mBuff);
    var SMFbytesPerVert = 44;
    var targetBytesPerVert = 36;
    
    for (var m = 0; m < num; m++)
    {
        var buff = mBuff[m];
        var buffSize = buffer_get_size(buff);
        var vertNum = buffSize div SMFbytesPerVert;
        
        for (var i = 0; i < vertNum; i++)
            buffer_copy(buff, i * SMFbytesPerVert, targetBytesPerVert, newBuff, size + (i * targetBytesPerVert));
        
        size += ((buffSize * targetBytesPerVert) / SMFbytesPerVert);
    }
    
    buffer_resize(newBuff, size);
    return newBuff;
}

function colmesh_get_key(argument0, argument1, argument2)
{
    return string(argument0) + "," + string(argument1) + "," + string(argument2);
    argument0 = (argument0 >= 0) ? (2 * argument0) : ((-2 * argument0) - 1);
    argument1 = (argument1 >= 0) ? (2 * argument1) : ((-2 * argument1) - 1);
    argument2 = (argument2 >= 0) ? (2 * argument2) : ((-2 * argument2) - 1);
    var m = max(argument0, argument1, argument2);
    var hash = (m * m * m) + (2 * m * argument2) + argument2;
    
    if (m == argument2)
        hash += sqr(max(argument0, argument1));
    
    if (argument1 >= argument0)
        hash += (argument0 + argument1);
    else
        hash += argument1;
    
    return hash;
}

function colmesh__region_capsule_collision(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8)
{
    if (is_undefined(argument0))
        return false;
    
    if (global.ColMeshRecursionCounter >= 8)
        return false;
    
    var i = ds_list_size(argument0);
    
    repeat (i)
    {
        global.ColMeshRecursionCounter++;
        var col = _getShape(argument0[| --i]).capsuleCollision(argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8);
        global.ColMeshRecursionCounter--;
        
        if (col)
            return true;
    }
    
    return false;
}

function colmesh_convert_2d_to_3d(argument0, argument1, argument2)
{
    var V = camera_get_view_mat(argument0);
    var P = camera_get_proj_mat(argument0);
    var mx = (2 * ((argument1 / window_get_width()) - 0.5)) / P[0];
    var my = (2 * ((argument2 / window_get_height()) - 0.5)) / P[5];
    var camX = -((V[12] * V[0]) + (V[13] * V[1]) + (V[14] * V[2]));
    var camY = -((V[12] * V[4]) + (V[13] * V[5]) + (V[14] * V[6]));
    var camZ = -((V[12] * V[8]) + (V[13] * V[9]) + (V[14] * V[10]));
    
    if (P[15] == 0)
        return [(V[2] + (mx * V[0])) - (my * V[1]), (V[6] + (mx * V[4])) - (my * V[5]), (V[10] + (mx * V[8])) - (my * V[9]), camX, camY, camZ];
    else
        return [V[2], V[6], V[10], (camX + (mx * V[0])) - (my * V[1]), (camY + (mx * V[4])) - (my * V[5]), (camZ + (mx * V[8])) - (my * V[9])];
}
