///undo_robot(obj_layer layer, par_robot robot)

/*
    Handles undo for this robot obj
    moveHistory     -> "roomName;0,0" #Name;objPosX,objPosY
    itemHistory     -> var numKeys, bool hasBaby 
    movedDirHistroy -> str direction
*/

var layer = argument0;
var robot = argument1;

print("-> undo_robot for " + robot[| OBJECT.NAME]);

//handle this robot's undo
var movementStr = ds_stack_pop(robot[| OBJECT.MOVEHISTORY]); //string e.g. "64,64"
//print(movementStr);
    
//handle this robot's items on undo
var items = ds_stack_pop(robot[| ROBOT.ITEMHISTORY]);
if (items != undefined)
{
    robot[| ROBOT.NUMKEYS] = real(items[0]);
    robot[| ROBOT.HASBABY] = real(items[1]);
}
    
robot[| OBJECT.MOVEDDIR] = ds_stack_pop(robot[| OBJECT.MOVEDDIRHISTORY]);
if (movementStr != undefined)
{
    var moveArrComponents = scr_split(movementStr, ";");
    var objPosArr = scr_split(moveArrComponents[1], ",");
    var rmName = moveArrComponents[0];
    //print("NAME!!!!: " + string(rmName));
    if rmName != room_get_name(room)
    {
        handle_gotoRoom(scr_roomFromString(rmName), "undoRoom");
        return false; //switch to other room 
    }
    
    /* 
        Old positions are stored in tmp variables to later update the surface map.
    */
    
    var oldPosX = real(robot[| OBJECT.X]);
    var oldPosY = real(robot[| OBJECT.Y]);
    
    var oldObjPosStr = ds_stack_top(robot[| OBJECT.MOVEHISTORY]);
    if (oldObjPosStr != undefined)
    {
        var oldObjPosArr = scr_split(oldObjPosStr, ",");
        robot[| OBJECT.OLDPOSX] = real(oldObjPosArr[0]);
        robot[| OBJECT.OLDPOSY] = real(oldObjPosArr[1]);
    }
    
    robot[| OBJECT.X] = real(objPosArr[0]);
    robot[| OBJECT.Y] = real(objPosArr[1]);
    robot[| ROBOT.NEWX] = real(robot[| OBJECT.X]);
    robot[| ROBOT.NEWY] = real(robot[| OBJECT.Y]);
    
    layer_updateObjAtTile(layer, robot, oldPosX, oldPosY);
                        
    if (layer.objNameAndPosToEnumMap)
    {
        ds_map_delete(layer.objNameAndPosToEnumMap, 
                        robot[| OBJECT.NAME] + ":" + string(oldPosX) + "," + string(oldPosY));
                        
        ds_map_add(layer.objNameAndPosToEnumMap, 
                        robot[| OBJECT.NAME] + ":" + string(robot[| OBJECT.X]) + "," + string(robot[| OBJECT.Y]), 
                        robot);
    }
    
    /*
     Update camera position if player in this layer.  
    */
    
    if (obj_layerManager.playerLayer == layer)
    {
        state_centerCamera(robot[| OBJECT.X], robot[| OBJECT.Y]);
    }
}
return true; //continue to undo objects
