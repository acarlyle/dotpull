///handle_activeRooms();

/*
    Handle room's objects from rooms other than the current
    floor.
*/

print(" -> handle_activeRooms() ");  

var curRoomName = room_get_name(room);
var lowerRoomName = "";
var alphaVal = 1; //halved each lower surface

while (get_lowerRoomName(curRoomName) != undefined){
    alphaVal /= 2;       
    scr_createSurface(surf_lowerRooms, curRoomName, 0, 0, 1, 1, 0, c_white, alphaVal);
    lowerRoomName = get_lowerRoomName(curRoomName); 
    curRoomName = lowerRoomName;
    //print("alphaVal: " + string(alphaVal));
}
