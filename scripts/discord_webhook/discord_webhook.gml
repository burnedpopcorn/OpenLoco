/// @param url_id
/// @param url_token
/// return: webhook_opid
function discord_webhook(argument0, argument1) {

	if not variable_global_exists("discord_webhooks"){
		globalvar discord_webhooks;
		discord_webhooks = ds_map_create()
	}
	if not variable_global_exists("discord_headers"){
		globalvar webhook_headers;
		webhook_headers = ds_map_create()
		webhook_headers[? "Content-Type"] = "application/json";
		webhook_headers[? "Host"] = "canary.discordapp.com";
		webhook_headers[? "Content-Length"] = 255;	
	}



	var url_id = string(argument0);
	var url_token = string(argument1);
	var url_full =  _dcw_createURL(url_id, url_token)
	var webhook_opid = string(ds_map_size(discord_webhooks)+1)

	var _webhook_data = ds_map_create()
	_webhook_data[? "url_id"] = url_id
	_webhook_data[? "url_token"] = url_token
	_webhook_data[? "url"] = url_full
	_webhook_data[? "content"] = dcw_noone
	_webhook_data[? "username"] = "UserName"
	_webhook_data[? "avatar_url"] = ""
	_webhook_data[? "embed_use"] = false
	_webhook_data[? "embed_title"] = "Title"
	_webhook_data[? "embed_description"] = "Description"
	_webhook_data[? "embed_url"] = "0"
	_webhook_data[? "embed_color"] = -1
	_webhook_data[? "embed_author_name"] = ""
	_webhook_data[? "embed_author_url"] = ""
	_webhook_data[? "embed_author_iconUrl"] = ""
	_webhook_data[? "embed_image_url"] = ""
	_webhook_data[? "embed_image_width"] = 0
	_webhook_data[? "embed_image_height"] = 0
	_webhook_data[? "embed_footer_text"] = ""
	_webhook_data[? "embed_footer_iconUrl"] = ""
	_webhook_data[? "embed_thumbnail_url"] = ""
	_webhook_data[? "embed_thumbnail_width"] = 0
	_webhook_data[? "embed_thumbnail_height"] = 0
	_webhook_data[? "embed_video_url"] = ""
	_webhook_data[? "embed_video_width"] = 0
	_webhook_data[? "embed_video_height"] = 0
	_webhook_data[? "embed_provider_name"] = ""
	_webhook_data[? "embed_provider_url"] = ""

	ds_map_add_map(discord_webhooks, webhook_opid, _webhook_data)
	return webhook_opid;



}
