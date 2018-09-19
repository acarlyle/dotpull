///get_arrayOfRoom(str roomStr)

var roomName = argument0;

var layer = get_layerFromRoomStr(roomName);

print(" -> get_arrayOfRoom(" + string(roomName) + ")");

var fileName = roomName + ".sav";

var roomArr = get_arrayOfRoomFromFile(fileName);

if (roomArr == false){
    print(" -> get_arrayOfRoom: no room file found, creating a new one.");
    handle_roomSave(true, layer);
    roomArr = get_arrayOfRoomFromFile(fileName);
}

return roomArr;
