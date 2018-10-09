///get_lowestRoomInLayer(room curRoom)

var curRoom = argument0;
var lowestRoom = curRoom;
var lowerRoomName;

while(curRoom != undefined && room_exists(curRoom)){
    lowestRoom = curRoom;
    lowerRoomName = get_lowerRoomName(room_get_name(curRoom));
    print(lowerRoomName);
    curRoom = get_roomFromString(lowerRoomName);
}

return lowestRoom;
