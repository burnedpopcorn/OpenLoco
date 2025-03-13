/// @param webhook_opid
/// @param edit_type
/// @param value
function discord_webhook_edit(argument0, argument1, argument2) {

	var webhook_opid = argument0
	var _type = argument1
	var _value = argument2
	var _webhook = discord_webhooks[? webhook_opid]


	switch(_type)
	{
		case edit_url:
			_webhook[? "url"] = _value
			break;
		
		case edit_id:
			_webhook[? "url_id"] = _value
			_webhook[? "url"] = _dcw_createURL(_value, _webhook[? "url_token"])
			break;
		
		case edit_token:
			_webhook[? "url_token"] = _value
			_webhook[? "url"] = _dcw_createURL(_webhook[? "url_id"], _value)
			break;
		
		case edit_content:
			_webhook[? "content"] = _value
			break;
		
		case edit_username:
			_webhook[? "username"] = _value
			break;
		
		case edit_avatar_url:
			_webhook[? "avatar_url"] = _value
			break;

		case edit_embed_use:
			_webhook[? "embed_use"] = _value
			break;
		
		case edit_embed_title:
			_webhook[? "embed_title"] = _value
			break;
		
		case edit_embed_description:
			_webhook[? "embed_description"] = _value
			break;
		
		case edit_embed_url:
			_webhook[? "embed_url"] = _value
			break;
		
		case edit_embed_color:
			_webhook[? "embed_color"] = _value
			break;
		
		case edit_embed_author_name:
			_webhook[? "embed_author_name"] = _value
			break;
		
		case edit_embed_author_url:
			_webhook[? "embed_author_url"] = _value
			break;
		
		case edit_embed_author_iconUrl:
			_webhook[? "embed_author_iconUrl"] = _value
			break;
		
		case edit_embed_image_url:
			_webhook[? "embed_image_url"] = _value
			break;
		
		case edit_embed_image_width:
			_webhook[? "embed_image_width"] = _value
			break;
		
		case edit_embed_image_height:
			_webhook[? "embed_image_height"] = _value
			break;
		
		case edit_embed_footer_text:
			_webhook[? "embed_footer_text"] = _value
			break;
		
		case edit_embed_footer_iconUrl:
			_webhook[? "embed_footer_iconUrl"] = _value
			break;
		
		case edit_embed_thumbnail_url:
			_webhook[? "embed_thumbnail_url"] = _value
			break;
		
		case edit_embed_thumbnail_width:
			_webhook[? "embed_thumbnail_width"] = _value
			break;
		
		case edit_embed_thumbnail_height:
			_webhook[? "embed_thumbnail_height"] = _value
			break;
		
		case edit_embed_video_url:
			_webhook[? "embed_video_url"] = _value
			break;
		
		case edit_embed_video_width:
			_webhook[? "embed_video_width"] = _value
			break;
		
		case edit_embed_video_height:
			_webhook[? "embed_video_height"] = _value
			break;
		
		case edit_embed_provider_name:
			_webhook[? "embed_provider_name"] = _value
			break;
		
		case edit_embed_provider_url:
			_webhook[? "embed_provider_url"] = _value
			break;
	}


}
