function load_model(_file, _vertex_info)
{
    model = vertex_create_buffer();
    vertex_begin(model, _vertex_info.vertex_format);
    var file = file_text_open_read(_file);
    var version = file_text_read_real(file);
    
    if (version != 100)
    {
        show_message("Wrong version of the model file!");
        vertex_delete_buffer(model);
        file_text_close(file);
        return -1;
    }
    
    var n = file_text_read_real(file);
    file_text_readln(file);
    var line = array_create(10, 0);
    
    for (var i = 0; i < n; i++)
    {
        for (var j = 0; j < 11; j++)
            line[j] = file_text_read_real(file);
        
        var type = line[0];
        
        switch (type)
        {
            case 0:
                break;
            
            case 1:
                break;
            
            case 2:
                var xx = line[1];
                var yy = line[2];
                var zz = line[3];
                vertex_add_point(model, xx, yy, zz, 0, 0, 0, c_white, 1, 0, 0);
                break;
            
            case 3:
                var xx = line[1];
                var yy = line[2];
                var zz = line[3];
                var color = line[4];
                var alpha = line[5];
                vertex_add_point(model, xx, yy, zz, 0, 0, 0, color, alpha, 0, 0);
                break;
            
            case 4:
                var xx = line[1];
                var yy = line[2];
                var zz = line[3];
                var xtex = line[4];
                var ytex = line[5];
                vertex_add_point(model, xx, yy, zz, 0, 0, 0, c_white, 1, xtex, ytex);
                break;
            
            case 5:
                var xx = line[1];
                var yy = line[2];
                var zz = line[3];
                var xtex = line[4];
                var ytex = line[5];
                var color = line[6];
                var alpha = line[7];
                vertex_add_point(model, xx, yy, zz, 0, 0, 0, color, alpha, xtex, ytex);
                break;
            
            case 6:
                var xx = line[1];
                var yy = line[2];
                var zz = line[3];
                var nx = line[4];
                var ny = line[5];
                var nz = line[6];
                vertex_add_point(model, xx, yy, zz, nx, ny, nz, c_white, 1, 0, 0);
                break;
            
            case 7:
                var xx = line[1];
                var yy = line[2];
                var zz = line[3];
                var nx = line[4];
                var ny = line[5];
                var nz = line[6];
                var color = line[7];
                var alpha = line[8];
                vertex_add_point(model, xx, yy, zz, nx, ny, nz, color, alpha, 0, 0);
                break;
            
            case 8:
                var xx = line[1];
                var yy = line[2];
                var zz = line[3];
                var nx = line[4];
                var ny = line[5];
                var nz = line[6];
                var xtex = line[7];
                var ytex = line[8];
                vertex_add_point(model, xx, yy, zz, nx, ny, nz, xtex, ytex, 0, 0);
                break;
            
            case 9:
                var xx = line[1];
                var yy = line[2];
                var zz = line[3];
                var nx = line[4];
                var ny = line[5];
                var nz = line[6];
                var xtex = line[7];
                var ytex = line[8];
                var color = line[9];
                var alpha = line[10];
                vertex_add_point(model, xx, yy, zz, nx, ny, nz, color, alpha, xtex, ytex);
                break;
            
            case 10:
                break;
            
            case 11:
                break;
            
            case 12:
                break;
            
            case 13:
                break;
            
            case 14:
                break;
            
            case 15:
                break;
        }
    }
    
    file_text_close(file);
    vertex_end(model);
    return model;
}

function load_obj(argument0, argument1, argument2)
{
    var filename = argument0;
    var mtlname = argument1;
    var obj_file = file_text_open_read(filename);
    var mtl_file = file_text_open_read(mtlname);
    var mtl_name = "None";
    var active_mtl = "None";
    var mtl_alpha = ds_map_create();
    var mtl_color = ds_map_create();
    ds_map_add(mtl_alpha, "None", 1);
    ds_map_add(mtl_color, "None", c_white);
    
    while (!file_text_eof(mtl_file))
    {
        var line = file_text_read_string(mtl_file);
        file_text_readln(mtl_file);
        var index = 0;
        var terms;
        terms[0] = "";
        terms[string_count(line, " ")] = "";
        
        for (var i = 1; i <= string_length(line); i++)
        {
            if (string_char_at(line, i) == " ")
            {
                index++;
                terms[index] = "";
            }
            else
                terms[index] = terms[index] + string_char_at(line, i);
        }
        
        switch (terms[0])
        {
            case "newmtl":
                mtl_name = terms[1];
                break;
            
            case "Kd":
                var red = real(terms[1]) * 255;
                var green = real(terms[2]) * 255;
                var blue = real(terms[3]) * 255;
                var color = make_color_rgb(red, green, blue);
                mtl_color[? mtl_name] = color;
                break;
            
            case "d":
                var alpha = real(terms[1]);
                mtl_alpha[? mtl_name] = alpha;
                break;
            
            default:
                break;
        }
    }
    
    var model = vertex_create_buffer();
    vertex_begin(model, argument2.vertex_format);
    var vertex_x = ds_list_create();
    var vertex_y = ds_list_create();
    var vertex_z = ds_list_create();
    var vertex_nx = ds_list_create();
    var vertex_ny = ds_list_create();
    var vertex_nz = ds_list_create();
    var vertex_xtex = ds_list_create();
    var vertex_ytex = ds_list_create();
    
    while (!file_text_eof(obj_file))
    {
        var line = file_text_read_string(obj_file);
        file_text_readln(obj_file);
        var index = 0;
        var terms = array_create(string_count(line, " ") + 1, "");
        
        for (var i = 1; i <= string_length(line); i++)
        {
            if (string_char_at(line, i) == " ")
            {
                index++;
                terms[index] = "";
            }
            else
                terms[index] += string_char_at(line, i);
        }
        
        switch (terms[0])
        {
            case "v":
                ds_list_add(vertex_x, real(terms[1]));
                ds_list_add(vertex_y, real(terms[2]));
                ds_list_add(vertex_z, real(terms[3]));
                break;
            
            case "vt":
                ds_list_add(vertex_xtex, real(terms[1]));
                ds_list_add(vertex_ytex, real(terms[2]));
                break;
            
            case "vn":
                ds_list_add(vertex_nx, real(terms[1]));
                ds_list_add(vertex_ny, real(terms[2]));
                ds_list_add(vertex_nz, real(terms[3]));
                break;
            
            case "f":
                for (var n = 1; n <= 3; n++)
                {
                    index = 0;
                    var data = array_create(string_count(terms[n], "/") + 1, "");
                    
                    for (var i = 1; i <= string_length(terms[n]); i++)
                    {
                        if (string_char_at(terms[n], i) == "/")
                        {
                            index++;
                            data[index] = "";
                        }
                        else
                            data[index] += string_char_at(terms[n], i);
                    }
                    
                    var xx = vertex_x[| real(data[0]) - 1];
                    var yy = vertex_y[| real(data[0]) - 1];
                    var zz = vertex_z[| real(data[0]) - 1];
                    var xtex = vertex_xtex[| real(data[1]) - 1];
                    var ytex = vertex_ytex[| real(data[1]) - 1];
                    var nx = vertex_nx[| real(data[2]) - 1];
                    var ny = vertex_ny[| real(data[2]) - 1];
                    var nz = vertex_nz[| real(data[2]) - 1];
                    var color = c_white;
                    var alpha = 1;
                    
                    if (ds_map_exists(mtl_color, active_mtl))
                        color = mtl_color[? active_mtl];
                    
                    if (ds_map_exists(mtl_alpha, active_mtl))
                        alpha = mtl_alpha[? active_mtl];
                    
                    var t = yy;
                    yy = zz;
                    zz = t;
                    vertex_position_3d(model, xx, yy, zz);
                    vertex_normal(model, nx, ny, nz);
                    vertex_color(model, color, alpha);
                    vertex_texcoord(model, xtex, ytex);
                }
                
                break;
            
            case "usemtl":
                active_mtl = terms[1];
                break;
            
            default:
                break;
        }
    }
    
    vertex_end(model);
    ds_list_destroy(vertex_x);
    ds_list_destroy(vertex_y);
    ds_list_destroy(vertex_z);
    ds_list_destroy(vertex_nx);
    ds_list_destroy(vertex_ny);
    ds_list_destroy(vertex_nz);
    ds_list_destroy(vertex_xtex);
    ds_list_destroy(vertex_ytex);
    ds_map_destroy(mtl_alpha);
    ds_map_destroy(mtl_color);
    file_text_close(obj_file);
    file_text_close(mtl_file);
    return model;
}
