///get_objectLocalVarsStr(var object)

/*
    Returns a string containing both the variable name of the object and the value of the var for every
    local var in this object.  The purpose is to capture Heap memory that the objects use not stores
    in the ds_stacks.  String follows this naming convention:
    
    objAtTile(1,0)[localVar=value/localVar2=number]:moveHistory_<stackHash>;|   <- typical obj. line
    
    [localVar=value/localVar2=number] <- this is the relevant bit returned from this function

*/

var object = argument0;

if (object.isPuzzleElement == false) 
    return "";

var rtnStr = "[state=" + string(object.state); // tile_slide, static, etc

/*switch (object_get_name(object)){
    case "obj_trigger":
        var triggerDoor = object.triggerDoorPtr;
        var doorX = triggerDoor.x;
        var doorY = triggerDoor.y;
        if (doorX == global.DEACTIVATED_X || doorY == global.DEACTIVATED_Y){
            doorX = triggerDoor.deactivatedX;
            doorY = triggerDoor.deactivatedY;
        }
        rtnStr = rtnStr + "/triggerDoorPtr_posX=" + string(doorX) + "/triggerDoorPtr_posY=" + string(doorY);
                                             
        //print("triggerDoorPtr: " + string(object.triggerDoorPtr));
        break;
}*/

rtnStr = rtnStr + "]";

return rtnStr;
