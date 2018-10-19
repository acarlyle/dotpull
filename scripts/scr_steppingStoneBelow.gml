///scr_steppingStoneBelow(var posX, var posY, var roomBelowName)

/*
    Returns true if there's a walkable object at posX, posY below the robot.
*/

var layer = argument0;
var posX = real(argument1);
var posY = real(argument2);
var roomBelowName = argument3;

if (roomBelowName == undefined || roomBelowName == noone) return false;

print("-> scr_steppingStoneBelow: lower room name: " + string(roomBelowName) + " at x,y: " + string(posX) + "," + string(posY));

var layerBelow = get_layerFromRoomStr(roomBelowName);

if (layerBelow == undefined) 
{
    print(" -> scr_steppingStoneBelow is undefined !");
    return false;
}
    
print(string(layerBelow.roomMapArr[posY / global.TILE_SIZE, posX / global.TILE_SIZE]));
var objectsAtTileArr = get_objectsFromRoomArrayTile(layerBelow.roomMapArr, posX, posY);
var stoneFound = false;
print(" -> scr_steppingStoneBelow: objectsAtTileArr: " + string(objectsAtTileArr));
for (var obj = 0; obj < array_length_1d(objectsAtTileArr); obj++){
    var split_roomArrByColon = scr_split(objectsAtTileArr[obj], ":");
    print(split_roomArrByColon[0]);
    if (split_roomArrByColon[0] == " ") continue;
    //print("after cont");
    //var object = instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, get_objectFromString(split_roomArrByColon[0]));
    //print("created obj");
    print(string(split_roomArrByColon[0]));
    var objRef = "";
    if (strcontains(split_roomArrByColon[0], "["))
    {
        var objNameAndVars = scr_split(split_roomArrByColon[0], "[");
        objRef = get_objectFromString(objNameAndVars[0]);
    }
    else
    {
        objRef = get_objectFromString(split_roomArrByColon[0]);
    }
    if (objRef.isSteppingStone){
        stoneFound = true;
    }
    //instance_destroy(object);
    if (stoneFound) 
    {
        print("scr_steppingStoneBelow: stepping stone Found!");
        return true;
    }
}

return false; //either no file or no 
