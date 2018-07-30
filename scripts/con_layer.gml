///con_layer(str roomName, ds_list sortedObjPriorityList)

var roomName = argument0;
var sortedObjPriorityList = argument1;

print(" -> con_layer of room " + string(roomName));

var layer = instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, obj_layer);
layer.roomName = roomName;
layer.roomMapArr = get_arrayOfRoom(layer.roomName);
layer.robot = obj_player;  //this is wrong, TODO.  it's hard because what if multiple objects?

//now set the layer's objPosToNameMap and associated mapKeyPriorityKey
con_priorityObjPosMap(layer, sortedObjPriorityList);

return layer;
