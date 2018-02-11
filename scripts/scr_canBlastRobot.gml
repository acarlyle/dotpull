///scr_canBlastRobot(int canPosX, int canPosY, par_robot robot)

cannon = argument0;
robot = argument1;

var xDiff = robot.x - cannon.x;
var yDiff = robot.y - cannon.y;


if (yDiff == 0){ //robot is moving left/right; check for objects towards the player
    if (xDiff > 0){ //robot is to the right of the obj
        for (var objX = cannon.x + global.TILE_SIZE; objX < robot.x; objX += global.TILE_SIZE){
            if (instance_place(objX, cannon.y, par_obstacle)){
                var obs = instance_place(objX, cannon.y, par_obstacle);
                if (isActivated(obs)){
                    return false; //don't pull if anything is in the way
                }
            }
        }
    }
    else{ //robot is to the left of the obj
        for (var objX = cannon.x - global.TILE_SIZE; objX > robot.x; objX -= global.TILE_SIZE){
            if (instance_place(objX, cannon.y, par_obstacle)){
                var obs = instance_place(objX, cannon.y, par_obstacle);
                if (isActivated(obs) && !instance_place(objX, cannon.y, obj_snare)){
                    //print(objX);
                    //print("something i nthe way");
                    //print(cannon.isDeactivated);
                    return false; //don't pull if anything is in the way
                }
                else{
                }
            }
        }
    }
}
if (xDiff == 0){ //robot is moving up/down; check for objects towards the player
    //print("xdiff zero, robot up/down");
    if (yDiff < 0){ //robot is above the obj
        for (var objY = cannon.y - global.TILE_SIZE; objY > robot.y; objY -= global.TILE_SIZE){
            if (instance_place(cannon.x, objY, par_obstacle)){
                var obs = instance_place(cannon.x, objY, par_obstacle);
                //print("isDeactived?");
                if (isActivated(obs)){
                    //print("don't pull something in the way: " + string(objY));
                    return false; //don't pull if anything is in the way
                }
            }
        }
    }
    else{ //robot is below the obj
        for (var objY = cannon.y + global.TILE_SIZE; objY < robot.y; objY += global.TILE_SIZE){
            if (instance_place(cannon.x, objY, par_obstacle)){
                //print(objY);
                var obs = instance_place(cannon.x, objY, par_obstacle);
                //print(obs.isDeactivated);
                if (!obs.isDeactivated){
                    //print("oh no it is activated");
                    return false; //don't pull if anything is in the way
                }
                else{
                    //print("it is not activated");
                }
            }
            //print("nothing here: " + string(objY));
        }
    }
}
return true;
