///get_higherRoomName(var lowerRoomName)

/*
    Returns undefined if the room that should be above the 
    argument's doesn't exist, otherwise returns matching
    room above. 
*/

var lowerRoomName = argument0;

//print(lowerRoomName);
if lowerRoomName == noone return undefined;

thisRoomNameArr = scr_split(lowerRoomName, "_");

//does not follow multi-floor room naming convention
if (array_length_1d(thisRoomNameArr) < 3) return undefined;
    
var roomPrefix = thisRoomNameArr[0];
var roomName = thisRoomNameArr[1];
var floorType = thisRoomNameArr[2];
var floorNumber = thisRoomNameArr[3];

switch(floorType){
    case "b": //basement     
        if (real(floorNumber) == 1){ floorType = "f"; }
        else{ floorNumber = real(floorNumber) + 1; }
        break;
    case "f": //normie floor
        floorNumber = real(floorNumber) - 1; 
        break;  
}   

var newRoomName = roomPrefix + "_" 
                + roomName + "_" 
                + string(floorType) + "_" 
                + string(floorNumber);
                
//print("newRoomName: " + string(newRoomName)); 
if (room_exists(scr_roomFromString(newRoomName))) return newRoomName;
else return undefined;  
