///undo_robot(par_robot robot)

/*
    Handles undo for this robot obj
*/

robot = argument0;

//handle this robot's undo
var objPosStr = ds_stack_pop(robot.moveHistory); //string e.g. "64,64"
print(objPosStr);
//print(obj_player.x);
//print(obj_player.y);
if (objPosStr != undefined){
    var objCoordArr = scr_split(objPosStr);
    //print(objCoordArr[0]);
    //print(objCoordArr[1]);
    robot.x = objCoordArr[0];
    robot.y = objCoordArr[1];
    robot.playerX = robot.x;
    robot.playerY = robot.y;
}
//handle this robot's items on undo
var items = ds_stack_pop(robot.itemHistory);
robot.numKeys = items[0];
