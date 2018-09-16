///get_arrayOfRoom(var roomStr)

var roomName = argument0;

print(" -> get_arrayOfRoom(" + string(roomName) + ")");

var fileName = roomName + ".sav";

var roomArr = get_arrayOfRoomFromFile(fileName);

if (roomArr == false){
    print(" -> get_arrayOfRoom: no room file found, creating a new one.");
    handle_roomSave(true); //save room Rob is in
    roomArr = get_arrayOfRoomFromFile(fileName);
}

return roomArr;
