///handle_checkForRoomTransition(obj_layer layer, par_robot robot)

var layer = argument0;
var robot = argument1;
 
//GOTO ROOM
if (instance_place(robot.playerX, robot.playerY, obj_gotoRoom)){
    robot.x = robot.playerX;
    robot.y = robot.playerY;
    robot.movedDir = "";
    robot.moved = false;
    handle_freeRoomMemory();
}
