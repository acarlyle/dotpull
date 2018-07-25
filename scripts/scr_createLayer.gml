///scr_createLayer(str roomName)

var m_roomName = argument0;

//print(" -> scr_createLayer of room " + string(m_room));

var layer = instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, obj_layer);
layer.m_roomName = m_roomName;
layer.m_arrMap = get_arrayOfRoom(layer.m_roomName);

return layer;
