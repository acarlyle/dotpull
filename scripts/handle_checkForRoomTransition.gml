///handle_checkForRoomTransition(obj_layer layer, objEnum robot)

var layer = argument0;
var robot = argument1;
 
//GOTO ROOM
if (robot[| OBJECT.NAME] == "obj_player" && 
    instance_place(robot[| ROBOT.NEWX], robot[| ROBOT.NEWY], obj_gotoRoom)){

    robot[| OBJECT.X] = robot[| OBJECT.OLDPOSX];
    robot[| OBJECT.Y] = robot[| OBJECT.OLDPOSY];
    robot[| OBJECT.MOVEDDIR] = "";
    robot[| OBJECT.MOVED] = false;
    //handle_freeRoomMemory();
    
    var gotoRoom = instance_place(robot[| ROBOT.NEWX], robot[| ROBOT.NEWY], obj_gotoRoom);
    
    handle_gotoRoom(gotoRoom.target_r, "gotoRoom");
    
}
