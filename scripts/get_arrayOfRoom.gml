///get_arrayOfRoom(var roomStr)

var roomName = argument0;

print(" -> get_arrayOfRoom(" + string(roomName) + ")");

var fileName = roomName + ".sav";

return get_arrayOfRoomFromFile(fileName);
