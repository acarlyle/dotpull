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
    print("get_arrayOfRoom I: room map height: " + string(array_height_2d(roomArr)));
    print("get_arrayOfRoom I: room map length: " + string(array_length_2d(roomArr, 0)));
}

return roomArr;
