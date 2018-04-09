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

//MOVE UP/DOWN A FLOOR
else if (instance_place(robot.playerX, robot.playerY, par_stairs)){
    if (instance_place(robot.playerX, robot.playerY, obj_stairsAsc)){
        var thisRoomName = room_get_name(room);
        print(thisRoomName);
        print(scr_split(thisRoomName, "_"));
    }
}
