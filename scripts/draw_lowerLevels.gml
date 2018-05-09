///draw_lowerLevels()

var curRoomName = room_get_name(room);
//print(curRoomName);

// get below room's name
var lowerRoomName = get_lowerRoomName(curRoomName);
if (lowerRoomName != undefined){
    //print("lowerRoomName: " + string(lowerRoomName));
    var fileName = lowerRoomName + ".sav";
    print("Filename: " + fileName);
    var lowerRoomArray = get_arrayOfRoomFromFile(fileName);
    print2dArray(lowerRoomArray);
}
