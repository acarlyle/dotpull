///handle_checkForRoomTransition(par_robot robot)

var robot = argument0;
 
//GOTO ROOM
if (instance_place(robot.playerX, robot.playerY, obj_gotoRoom)){
    robot.x = robot.playerX;
    robot.y = robot.playerY;
    robot.movedDir = "";
    robot.moved = false;
    handle_freeRoomMemory();
}
