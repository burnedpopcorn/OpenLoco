function _dcw_parseData(argument0) {
	var _data = string(argument0)
	_data = string_replace_all(_data, "\"", "\\\"")
	_data = string_replace_all(_data, "\\", "\\\\")
	_data = string_replace_all(_data, "\\\\u00ad", dcw_noone)
	return _data;



}
