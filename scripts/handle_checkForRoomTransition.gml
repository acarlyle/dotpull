///handle_checkForRoomTransition(obj_layer layer, objEnum robot)

var layer = argument0;
var robot = argument1;
 
//GOTO ROOM
<<<<<<< HEAD
if (map_place(layer, obj_gotoRoom, robot[| ROBOT.NEWX], robot[| ROBOT.NEWY])){
=======
if (map_place(layer, obj_gotoRoom, robot[| ROBOT.OLDPOSX], robot[| ROBOT.OLDPOSX])){
>>>>>>> master
    robot[| OBJECT.X] = robot[| ROBOT.OLDPOSX];
    robot[| OBJECT.Y] = robot[| ROBOT.OLDPOSY];
    robot[| OBJECT.MOVEDDIR] = "";
    robot[| OBJECT.MOVED] = false;
    handle_freeRoomMemory();
}
