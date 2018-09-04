///scr_steppingStoneBelow(var posX, var posY, var roomBelowName)

/*
    Returns true if there's a walkable object at posX, posY below the robot.
*/

var posX = argument0;
var posY = argument1;
var roomBelowName = argument2;

if (!roomBelowName) return false;

var roomBelowFile = roomBelowName + ".sav";

if (file_exists(roomBelowFile)){  // TODO - creating an object for checking for stepping stones below SUCKS, fix it, too spaghetti/hackish
    var roomBelowArr = get_arrayOfRoomFromFile(roomBelowFile);
    var objectsAtTileArr = get_objectsFromRoomArrayTile(roomBelowArr, posX, posY);
    var stoneFound = false;
    for (var obj = 0; obj < array_length_1d(objectsAtTileArr); obj++){
        var split_roomArrByColon = scr_split(objectsAtTileArr[obj], ":");
        print(split_roomArrByColon[0]);
        if (split_roomArrByColon[0] == " ") continue;
        //print("after cont");
        var object = instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, get_objectFromString(split_roomArrByColon[0]));
        //print("created obj");
        if (object.isSteppingStone){
            stoneFound = true;
        }
        instance_destroy(object);
        if (stoneFound) return true;
    }
}
return false; //either no file or no 
