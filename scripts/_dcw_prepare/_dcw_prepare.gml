function _dcw_prepare(argument0, argument1) {
	var content = argument0
	var username = argument1

	if(string_width(content)<=0){
		content = "­"
	}
	else if string_length(content)>2000{
		content = string_copy(content, 0, 1999)
	}
	
	if(string_width(username)<=0){
		username = "UserName"
	}

	return [content, username]



}
