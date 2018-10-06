///get_layerFromRoomStr(var roomName)

/*
    Returns Layer mapping the passed roomname.
*/

var roomName = argument0;

layer = ds_map_find_value(obj_layerManager.layerMap, roomName);

//if layer doesn't exist, creare a basic version of it
if (!layer) layer = con_layer(roomName, false);

return layer;
