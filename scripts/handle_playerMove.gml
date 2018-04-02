///handle_playerMove(par_robot robot);

var robot = argument0;

//if on a slideTile, disable player input keys
if (instance_place(robot.x, robot.y, obj_slideTile)){
    robot.state = "tile_slide";
}

var pushXOntoStack = robot.playerX;
var pushYOntoStack = robot.playerY;

switch(robot.state){
    case "tile_one": //normal state; robot moves one tile at a time
        handle_robotMove_tile_one(robot);
        break;
    case "tile_slide": //robot is sliding across some ice, cannot control direction
        handle_robotMove_tile_slide(robot);
        break;
}

if (robot.moved){
    //GOTO ROOM
    if (instance_place(robot.playerX, robot.playerY, obj_gotoRoom)){
        robot.x = robot.playerX;
        robot.y = robot.playerY;
        robot.movedDir = "";
        robot.moved = false;
        handle_freeRoomMemory();
    }
    
    if (object_get_name(robot.object_index) == "obj_player" && robot.moved){
        global.playerMoved = true;
        print("PLAYER MOVED");
    }
    
    if (global.playerMoved){ 
        //print("pushed: " + string(robot.x) + "," + string(robot.y));
        ds_stack_push(robot.moveHistory, string(pushXOntoStack) + "," + string(pushYOntoStack)); //pushing previous turn's movement
        ds_stack_push(robot.itemHistory, array(robot.numKeys));
        ds_stack_push(robot.movedDirHistory, robot.movedDir);
        //print("Pushed onto robots's stack: " + string(robot.x) + " " + string(robot.y));
        //print("Pushed numKeys onto robots's stack: " + string(obj_player.numKeys));
        robot.oldPlayerX = x;
        robot.oldPlayerY = y;
        //print("robot oldPlayerX set to " + string(robot.oldPlayerX));
        //print("robot oldPlayerY set to " + string(robot.oldPlayerY));
        robot.x = robot.playerX; 
        robot.y = robot.playerY;
        //print("new robo x: " + string(robot.x)); 
        if (instance_place(robot.x, robot.y, obj_slideTile)){
            robot.canMove = false;
        }
    }
    else{
        robot.movedDir = "";
    }
}
robot.move = false;
robot.canMove = true;
robot.state = "tile_one"; //reset state to default movement 
