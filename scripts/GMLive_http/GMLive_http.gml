// GMLive.gml (c) YellowAfterlife, 2017+
// PLEASE DO NOT FORGET to remove paid extensions from your project when publishing the source code!
// And if you are using git, you can exclude GMLive by adding
// `scripts/GMLive*` and `extensions/GMLive/` lines to your `.gitignore`.
// Feather disable all

if(live_enabled)
function live_async_http_0(l_map){
	var l_i,l_n,l_s,l_list,l_names,l_srcMap;
	live_is_ready=true;
	live_request_guid=l_map[? "guid"];
	if(l_map[? "version"]==undefined||l_map[? "version"]<106)throw gml_std_haxe_Exception_thrown("Outdated GMLive server detected! Please update the included files from the extension.");
	l_list=l_map[? "shaders"];
	l_n=ds_list_size(l_list);
	for(l_i=0;l_i<l_n;l_i++){
		l_s=l_list[| l_i];
		gml_asset_add(l_s,asset_get_index(l_s));
	}
	for(var l__=0;l__<1;l__++){
		l_list=l_map[? "animCurves"];
		if(l_list==undefined){
			live_log("Server init response is missing an animCurves list. You may need to update the server.",1);
			continue;
		}
		l_n=ds_list_size(l_list);
		for(l_i=0;l_i<l_n;l_i++){
			l_s=l_list[| l_i];
			gml_asset_add(l_s,asset_get_index(l_s));
		}
	}
	l_list=l_map[? "globals"];
	l_n=ds_list_size(l_list);
	if(l_n>0){
		var l_buf=buffer_create(1024,buffer_grow,1);
		buffer_seek(l_buf,buffer_seek_start,0);
		buffer_write(l_buf,buffer_text,"globalvar ");
		buffer_write(l_buf,buffer_text,l_list[| 0]);
		for(l_i=1;l_i<l_n;l_i++){
			buffer_write(l_buf,buffer_text,", ");
			buffer_write(l_buf,buffer_text,l_list[| l_i]);
		}
		buffer_write(l_buf,buffer_string,";");
		buffer_seek(l_buf,buffer_seek_start,0);
		live_live_globals=new gml_source("globalvar",buffer_read(l_buf,buffer_string),"globalvar",true);
		buffer_delete(l_buf);
	} else live_live_globals=undefined;
	l_srcMap=live_live_macros;
	tools__dictionary_dictionary_impl__clear(l_srcMap);
	l_list=l_map[? "macros"];
	l_n=ds_list_size(l_list);
	for(l_i=0;l_i<l_n;l_i+=2){
		l_s=l_list[| l_i];
		var l_s1="macro:"+l_s;
		l_srcMap[$ l_s]=new gml_source(l_s1,"#macro "+l_s+" "+gml_std_Std_stringify(l_list[| l_i+1]),l_s1,true);
	}
	l_srcMap=live_live_enums;
	tools__dictionary_dictionary_impl__clear(l_srcMap);
	l_list=l_map[? "enums"];
	l_names=l_map[? "enumnames"];
	l_n=ds_list_size(l_list);
	for(l_i=0;l_i<l_n;l_i++){
		l_s=l_list[| l_i];
		l_s=l_names[| l_i];
		l_srcMap[$ l_s]=new gml_source("enum "+l_s,l_list[| l_i],"enum "+l_s,true);
	}
	live_log("Ready!",0);
}

if(live_enabled)
function live_async_http_1(l_map){
	var l_list=l_map[? "files"];
	var l_obj;
	var l_n=ds_list_size(l_list);
	var l_name;
	var l_i=-1;
	while(++l_i<l_n){
		var l_fmap=l_list[| l_i];
		var l_ident=l_fmap[? "ident"];
		var l_code=l_fmap[? "code"];
		l_name=l_fmap[? "name"];
		live_update_script(l_name,l_ident,l_code);
	}
	l_list=l_map[? "sprites"];
	if(l_list!=undefined){
		l_n=ds_list_size(l_list);
		l_i=-1;
		while(++l_i<l_n){
			var l_sup=l_list[| l_i];
			l_name=l_sup[? "name"];
			var l_spr=asset_get_index(l_name);
			if(l_spr==-1){
				live_log("Error: can't find sprite "+l_name+" for reload.",2);
				continue;
			}
			var l_sx=l_sup[? "xorig"];
			var l_sy=l_sup[? "yorig"];
			var l_frames=l_sup[? "frames"];
			var l_out=-1;
			var l_tmp=live_temp_path+".png";
			var l_i1=0;
			for(var l__g1=ds_list_size(l_frames);l_i1<l__g1;l_i1++){
				var l_tb=buffer_base64_decode(l_frames[| l_i1]);
				if(l_tb==-1){
					live_log("Error: couldn't decode base64 for "+l_name+".",2);
					continue;
				}
				buffer_save(l_tb,l_tmp);
				buffer_delete(l_tb);
				var l_ts=sprite_add(l_tmp,1,false,false,l_sx,l_sy);
				if(l_ts==-1){
					live_log("Error: couldn't load image "+string(l_i1)+" for "+l_name+".",2);
					continue;
				}
				if(l_i1!=0)sprite_merge(l_out,l_ts); else l_out=l_ts;
			}
			if(l_out!=-1){
				sprite_assign(l_spr,l_out);
				sprite_collision_mask(l_spr,l_sup[? "sepMasks"],l_sup[? "bboxMode"],l_sup[? "bboxLeft"],l_sup[? "bboxTop"],l_sup[? "bboxRight"],l_sup[? "bboxBottom"],l_sup[? "colKind"],l_sup[? "colTolerance"]);
				l_obj=l_sup[? "nineslice"];
				if(l_obj!=undefined&&l_obj!=pointer_null){
					var l_nine=sprite_nineslice_create();
					l_nine.enabled=true;
					l_nine.left=l_obj[? "left"];
					l_nine.top=l_obj[? "top"];
					l_nine.right=l_obj[? "right"];
					l_nine.bottom=l_obj[? "bottom"];
					var l_tm=l_obj[? "tileMode"];
					var l__g2=[];
					var l_i2=0;
					for(var l__g4=ds_list_size(l_tm);l_i2<l__g4;l_i2++){
						array_push(l__g2,l_tm[| l_i2]);
					}
					l_nine.tileMode=l__g2;
					sprite_set_nineslice(l_spr,l_nine);
				}
				sprite_delete(l_out);
				live_log("Reloaded "+l_name+".",0);
				live_sprite_updated(l_spr);
			}
			file_delete(l_tmp);
		}
	}
	l_list=l_map[? "shadersUpd"];
	if(l_list!=undefined){
		l_n=ds_list_size(l_list);
		l_i=-1;
		while(++l_i<l_n){
			var l_sup=l_list[| l_i];
			l_name=l_sup[? "name"];
			var l_sh=asset_get_index(l_name);
			live_shader_updated(l_sh,l_sup[? "vertex"],l_sup[? "fragment"]);
			live_log("Reloaded "+l_name+".",0);
			live_shader_updated(l_sh);
		}
	}
	l_list=l_map[? "rooms"];
	if(l_list!=undefined){
		l_n=ds_list_size(l_list);
		l_i=-1;
		while(++l_i<l_n){
			var l_ru=l_list[| l_i];
			var l_rq=asset_get_index(l_ru[?"name"]);
			live_live_room_data[? l_rq] = l_ru[?"json"];
			live_room_updated(l_rq);
		}
	}
	l_list=l_map[? "pathsUpd"];
	if(l_list!=undefined){
		var l_i=0;
		for(var l__g1=ds_list_size(l_list);l_i<l__g1;l_i++){
			var l_pup=l_list[| l_i];
			l_name=l_pup[? "name"];
			var l_pt=asset_get_index(l_name);
			if(!path_exists(l_pt)){
				live_log("Couldn't find path '"+l_name+"'",1);
				continue;
			}
			path_clear_points(l_pt);
			path_set_closed(l_pt,l_pup[? "closed"]);
			path_set_kind(l_pt,l_pup[? "kind"]);
			path_set_precision(l_pt,l_pup[? "precision"]);
			var l__g_list=l_pup[? "points"];
			var l__g_index=0;
			while(l__g_index<ds_list_size(l__g_list)){
				var l_point=l__g_list[| l__g_index++];
				path_add_point(l_pt,l_point[? "x"],l_point[? "y"],l_point[? "speed"]);
			}
			live_log("Reloaded "+l_name+".",0);
			live_path_updated(l_pt);
		}
	}
	l_list=l_map[? "animCurvesUpd"];
	if(l_list!=undefined){
		var l_i=0;
		for(var l__g1=ds_list_size(l_list);l_i<l__g1;l_i++){
			var l_acu=l_list[| l_i];
			l_name=l_acu[?"name"];
			var l_ac=asset_get_index(l_name);
			if(!animcurve_exists(l_ac)){
				live_log("Couldn't find animcurve \""+l_name+"\"",1);
				continue;
			}
			var l_acStruct=animcurve_get(l_ac);
			var l_acuChannels=l_acu[?"channels"];
			var l_acuType=l_acu[?"type"];
			var l_acChannels=[];
			var l_i1=0;
			for(var l__g3=ds_list_size(l_acuChannels);l_i1<l__g3;l_i1++){
				var l_acuChannel=l_acuChannels[| l_i1];
				var l_acChannel=animcurve_channel_new();
				l_acChannel.name=l_acuChannel[?"name"];
				l_acChannel.type=l_acuType;
				var l_acuData=l_acuChannel[?"data"];
				var l_acPoints=[];
				var l_acuInd=0;
				var l__=0;
				for(var l__g5=(ds_list_size(l_acuData)>>1);l__<l__g5;l__++){
					var l_acPoint=animcurve_point_new();
					l_acPoint.posx=l_acuData[| l_acuInd++];
					l_acPoint.value=l_acuData[| l_acuInd++];
					array_push(l_acPoints,l_acPoint);
				}
				l_acChannel.points=l_acPoints;
				array_push(l_acChannels,l_acChannel);
			}
			l_acStruct.channels=l_acChannels;
			live_log("Reloaded "+l_name+".",0);
			live_animcurve_updated(l_ac);
		}
	}
	l_list=l_map[? "incFilesUpd"];
	if(l_list!=undefined){
		var l_i=0;
		for(var l__g1=ds_list_size(l_list);l_i<l__g1;l_i++){
			var l_sub=l_list[| l_i];
			l_name=l_sub[? "path"];
			var l_ip=live_live_included_files[? l_name];
			if(l_ip==undefined){
				live_log("Couldn't find live included file \""+l_name+"\"",1);
				continue;
			}
			var l_b64=l_sub[? "data"];
			switch(l_ip.kind){
				case 1:l_ip.func(base64_decode(l_b64),l_name);break;
				case 4:
					var l_tmp1=live_temp_path+".csv";
					buffer_save(buffer_base64_decode(l_b64),l_tmp1);
					var l_grid=load_csv(l_tmp1);
					l_ip.func(l_grid,l_name);
					ds_grid_destroy(l_grid);
					file_delete(l_tmp1);
					break;
				case 0:
					var l_buf=buffer_base64_decode(l_b64);
					l_ip.func(l_buf,l_name);
					buffer_delete(l_buf);
					break;
				case 2:
					var l_val;
					try{
						l_val=json_parse(base64_decode(l_b64))
					}catch(l__g2){
						live_log("Couldn't decode JSON for \""+l_name+"\": "+gml_std_Std_stringify(gml_std_haxe_Exception_caught(l__g2).h_unwrap()),1);
						continue;
					}
					l_ip.func(l_val,l_name);
					break;
				case 3:l_ip.func(l_b64,l_name);break;
			}
		}
	}
}

if(live_enabled)
function live_async_http_check(l_e){
	return l_e[? "id"]==live_request_id&&l_e[? "status"]<=0;
}

function live_async_http(l_e){
	if(false)show_debug_message(argument[0]);
	if(live_enabled){
		if(l_e==undefined)l_e=async_load;
		if(!live_async_http_check(l_e))exit;
		live_request_id=undefined;
		if(l_e[? "status"]<0||l_e[? "result"]==undefined)exit;
		var l_json1=l_e[? "result"];
		var l_map=json_decode(l_json1);
		if(l_map==-1||ds_map_exists(l_map,"default")){
			if(string_char_at(l_json1,1)=="{"&&string_char_at(l_json1,string_length(l_json1)-1+1)=="]")l_json1+="}";
			l_map=json_decode(l_json1);
			if(l_map==-1||ds_map_exists(l_map,"default")){
				live_log("Invalid JSON response ("+gml_std_Std_stringify(string_length(l_json1)/1000)+" KB)",2);
				exit;
			}
		}
		if(live_request_guid==undefined)live_async_http_0(l_map);
		live_async_http_1(l_map);
		ds_map_destroy(l_map);
	}
}
