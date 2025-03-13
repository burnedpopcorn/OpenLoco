/// @param webhook_opid
function discord_webhook_execute(argument0) {
	/*
		Execute the webhook
		
		returns: Nothing
	*/	

	var _webhook = discord_webhooks[? argument0]
	var _array = _dcw_prepare(_webhook[? "content"], _webhook[? "username"])
	var content = _array[0]
	var username = _array[1]
	var avatar_url = _webhook[? "avatar_url"]
	var url = _webhook[? "url"]
	var _embed = ""

	
	if(_webhook[? "embed_use"]){
		var 
		embed_author_name = _webhook[? "embed_author_name"], 
		embed_image_url = _webhook[? "embed_image_url"], 
		embed_footer_text = _webhook[? "embed_footer_text"], 
		embed_thumbnail_url = _webhook[? "embed_thumbnail_url"], 
		embed_video_url = _webhook[? "embed_video_url"], 
		embed_provider_name = _webhook[? "embed_provider_name"];
	
		_embed = ds_map_create()
		_embed[? "title"] = _webhook[? "embed_title"]
		_embed[? "description"] = _webhook[? "embed_description"]
		if(_webhook[? "embed_url"]!="0") _embed[? "url"] = _webhook[? "embed_url"]
		if(_webhook[? "embed_color"]!=-1) _embed[? "color"] = _webhook[? "embed_color"]
		if(embed_author_name!=""){
			var _author = ds_map_create()
			var embed_author_url = _webhook[? "embed_author_url"];
			var embed_author_iconUrl = _webhook[? "embed_author_iconUrl"];
			_author[? "name"] = embed_author_name
			if(embed_author_url!="") _author[? "url"] = embed_author_url
			if(embed_author_iconUrl!="") _author[? "icon_url"] = embed_author_iconUrl
			ds_map_add_map(_embed, "author", _author)
		}
		if(embed_image_url!=""){
			var _image = ds_map_create()
			var embed_image_width = _webhook[? "embed_image_width"];
			var embed_image_height = _webhook[? "embed_image_height"];
			_image[? "url"] = embed_image_url
			if(embed_image_width!=0) _image[? "width"] = embed_image_width
			if(embed_image_height!=0) _image[? "height"] = embed_image_height
			ds_map_add_map(_embed, "image", _image)
		}
		if(embed_footer_text!=""){
			var _footer = ds_map_create()
			var embed_footer_iconUrl = _webhook[? "embed_footer_iconUrl"];
			_footer[? "text"] = embed_footer_text
			if(embed_footer_iconUrl!="") _footer[? "icon_url"] = embed_footer_iconUrl
			ds_map_add_map(_embed, "footer", _footer)
		}
		if(embed_thumbnail_url!=""){
			var _thumbnail = ds_map_create()	
			var embed_thumbnail_width = _webhook[? "embed_thumbnail_width"];
			var embed_thumbnail_height = _webhook[? "embed_thumbnail_height"];
			_thumbnail[? "url"] = embed_thumbnail_url
			if(embed_thumbnail_width!=0) _thumbnail[? "width"] = embed_thumbnail_width
			if(embed_thumbnail_height!=0) _thumbnail[? "height"] = embed_thumbnail_height
			ds_map_add_map(_embed, "thumbnail", _thumbnail)
		}
		if(embed_video_url!=""){
			var _video = ds_map_create()	
			var embed_video_width = _webhook[? "embed_video_width"];
			var embed_video_height = _webhook[? "embed_video_height"];
			_video[? "url"] = embed_video_url
			if(embed_video_width!=0) _video[? "width"] = embed_video_width
			if(embed_video_height!=0) _video[? "height"] = embed_video_height
			ds_map_add_map(_embed, "video", _video)
		}
		if(embed_provider_name!=""){
			var _provider = ds_map_create()
			var embed_provider_url = _webhook[? "embed_provider_url"];
			_provider[? "name"] = embed_provider_name
			if(embed_provider_url!="") _provider[? "url"] = embed_provider_url
			ds_map_add_map(_embed, "provider", _provider)
		}
		_embed = json_encode(_embed)
	}
	
	content = _dcw_parseData(content)
	username = _dcw_parseData(username)
	avatar_url = _dcw_parseData(avatar_url)
	
	var _data = "{\"content\": \""+content+"\", \"username\": \""+username+"\", \"avatar_url\": \""+avatar_url+"\", \"embeds\": ["+_embed+"]}"
	webhook_headers[? "Content-Length"] = string_length(_data);	

	http_request(url, "POST", webhook_headers, _data);
	
	_dcw_log("Sending data: " + string(_data))
	_dcw_log("Sending to url: " + url)



}
