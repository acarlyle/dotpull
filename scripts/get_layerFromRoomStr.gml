///get_layerFromRoomStr(var roomName)

/*
    Returns Layer mapping the passed roomname.
*/

var roomName = argument0;

layer = ds_map_find_value(obj_layerManager.layerMap, roomName);

return layer;
