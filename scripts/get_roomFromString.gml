///get_roomFromString(str roomName)

var roomNameStr = argument0;

if roomNameStr == undefined return undefined; 

var rm = asset_get_index(roomNameStr);
return rm;
