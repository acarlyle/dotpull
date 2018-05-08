///get_lowerRoomName(var upperRoomName)

/*
    Returns undefined if the room that should be below the 
    argument's doesn't exist, otherwise returns matching
    room below. 
*/

var upperRoomName = argument0;

thisRoomNameArr = scr_split(upperRoomName, "_");
    
var roomPrefix = thisRoomNameArr[0];
var roomName = thisRoomNameArr[1];
var floorType = thisRoomNameArr[2];
var floorNumber = thisRoomNameArr[3];

switch(floorType){
    case "b": //basement
        floorNumber = real(floorNumber) + 1; 
        break;        
    case "f": //normie floor
        if (real(floorNumber) == 1){ floorType = "b"; }
        else{ floorNumber = real(floorNumber) - 1; }
        break;
}   

var newRoomName = roomPrefix + "_" 
                + roomName + "_" 
                + string(floorType) + "_" 
                + string(floorNumber);
                
print("newRoomName: " + string(newRoomName)); 
if (room_exists(scr_roomFromString(newRoomName))) return newRoomName;
else return undefined;  
