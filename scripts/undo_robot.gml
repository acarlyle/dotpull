///undo_robot(par_robot robot)

/*
    Handles undo for this robot obj
    moveHistory     -> "roomName;0,0" #Name;objPosX,objPosY
    itemHistory     -> var numKeys, bool hasBaby 
    movedDirHistroy -> str direction
*/

robot = argument0;

//handle this robot's undo
var movementStr = ds_stack_pop(robot.moveHistory); //string e.g. "64,64"
print(movementStr);

//handle this robot's items on undo
var items = ds_stack_pop(robot.itemHistory);
if (items != undefined){
    robot.numKeys = items[0];
    robot.hasBaby = items[1];
}
    
robot.movedDir = ds_stack_pop(robot.movedDirHistory);
if (movementStr != undefined){
    var moveArrComponents = scr_split(movementStr, ";");
    var objPosArr = scr_split(moveArrComponents[1], ",");
    var rmName = moveArrComponents[0];
    print("NAME!!!!: " + string(rmName));
    if rmName != room_get_name(room){
        handle_gotoRoom(scr_roomFromString(rmName), "undoRoom");
        return false; //switch to other room 
    }
    
    robot.x = objPosArr[0];
    robot.y = objPosArr[1];
    robot.playerX = robot.x;
    robot.playerY = robot.y;
}
return true; //continue to undo objects
