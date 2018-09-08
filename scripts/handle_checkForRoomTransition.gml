///handle_checkForRoomTransition(obj_layer layer, objEnum robot)

var layer = argument0;
var robot = argument1;
 
//GOTO ROOM
if (map_place(layer, obj_gotoRoom, robot[| ROBOT.NEWX], robot[| ROBOT.NEWY])){

    robot[| OBJECT.X] = robot[| ROBOT.OLDPOSX];
    robot[| OBJECT.Y] = robot[| ROBOT.OLDPOSY];
    robot[| OBJECT.MOVEDDIR] = "";
    robot[| OBJECT.MOVED] = false;
    handle_freeRoomMemory();
}
