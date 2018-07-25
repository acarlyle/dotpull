///handle_layerRobots(par_robot robot);

var robot = argument0;

handle_deployBaby(robot);  //this handles baby placement if player pressed space and has a Baby on Board

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

if (!robot.moved && !robot.isDead){ //if we didn't move and we aren't dead
    handle_checkForStairs(robot);
    if (!global.switchRooms) { //we aren't switching rooms
        handle_checkLowerRoom(robot);
    }
}

if (robot.moved){
    
    handle_checkForRoomTransition(robot);
    
    if (object_get_name(robot.object_index) == "obj_player" && robot.moved){
        global.playerMoved = true;
        print("PLAYER MOVED");
        print("Robot at " + string(robot.x) + "," + string(robot.y));
    }
    
    if (global.playerMoved){ 
        push_robotState(robot, false, pushXOntoStack, pushYOntoStack);
    }
    else{
        robot.movedDir = "";
    }
}

robot.move = false;
robot.canMove = true;
robot.state = "tile_one"; //reset state to default movement 
