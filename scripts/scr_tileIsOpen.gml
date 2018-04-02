///scr_tileIsOpen(int posX, int posY, par_object object)

var posX = argument0;
var posY = argument1;
var object = argument2;

/*if (instance_place(argument0, argument1, obj_mirptr)){
    var mirptr = instance_place(argument0, argument1, obj_mirptr);
    print("old robo x: " + string(robot.x));
    var roboXDiff = argument0 - robot.playerX; 
    var roboYDiff = argument1 - robot.playerY; 
    if !scr_collisionCheck(mirptr.mirptrPtr.x + roboXDiff, mirptr.mirptrPtr.y + roboYDiff, robot){
        //robot.x += (mirptr.mirptrPtr.x + roboXDiff) - mirptr.x;
        //robot.y += (mirptr.mirptrPtr.y + roboYDiff) - mirptr.y;
        robot.playerX += (mirptr.mirptrPtr.x + roboXDiff) - mirptr.x;
        robot.playerY += (mirptr.mirptrPtr.y + roboYDiff) - mirptr.y;
        print("PROBLEM: Recursive call, new robot x, y: " + string(robot.playerX) + " " + string(robot.playerY));
    }
    else{
        return true;
    }
    
    
    robot.playerX = mirptr.mirptrPtr.x;
    robot.playerY = mirptr.mirptrPtr.y;
    print("mirptr collision in player move");
    print(mirptr.mirptrPtr.x);
}*/

if (scr_tileContains(posX, posY, array(par_obstacle))){
    var obstacle = instance_place(argument0, argument1, par_obstacle);
    if (!obstacle.isDeactivated) return false; //obstacle will block your path
}

if (instance_place(argument0, argument1, par_platform)){
    var platform = instance_place(argument0, argument1, par_platform);
    if (platform.isFallingPlatform){
        if (platform.stepsLeft <= 0){
            return false; //obj can't move, the platform has fallen and the city is lost
        }
    }
    return true;
}

return true;
