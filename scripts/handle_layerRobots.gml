///handle_layerRobots(obj_layer layer, par_robot robot);

var layer = argument0;
var robot = argument1;

handle_deployBaby(layer, robot);  //this handles baby placement if player pressed space and has a Baby on Board

//if on a slideTile, disable player input keys
if (map_place(layer, obj_slideTile, robot[| OBJECT.X], robot[| OBJECT.X])){
    baby[| OBJECT.STATE] = "tile_slide";
}

var pushXOntoStack = robot[| ROBOT.OLDPOSX];
var pushYOntoStack = robot[| ROBOT.OLDPOSY];


switch(robot[| OBJECT.STATE]){
    case "tile_one": //normal state; robot moves one tile at a time
        handle_robotMove_tile_one(layer, robot);
        break;
    case "tile_slide": //robot is sliding across some ice, cannot control direction
        handle_robotMove_tile_slide(layer, robot);
        break;
}

if (!robot[| OBJECT.MOVED] && !robot[| ROBOT.ISDEAD]){ //if we didn't move and we aren't dead
    handle_checkForStairs(layer, robot);
    if (!global.switchRooms) { //we aren't switching rooms
        handle_checkLowerRoom(layer, robot);
    }
}

if (robot[| OBJECT.MOVED]){
    
    handle_checkForRoomTransition(layer, robot);
    
    if (robot[| OBJECT.NAME] == "obj_player" && robot[| OBJECT.MOVED]){
        global.playerMoved = true;
        print("PLAYER MOVED");
    }
    
    if (global.playerMoved){ 
        push_robotState(robot, false, pushXOntoStack, pushYOntoStack);
    }
    else{
        robot[| OBJECT.MOVEDDIR] = "";
    }
    
    // Now update this layer's position with moved Robot
    
    // TODO -> Refactor Layer Robot into enum so I can use only one layer_updateObj script instead of 2
    layer_updateRobotAtTile(layer, pushXOntoStack, pushYOntoStack); //pass old positions
    
}

layer.move = false;
robot[| ROBOT.CANMOVE] = true;
robot[| OBJECT.STATE] = "tile_one"; //reset state to default movement 
