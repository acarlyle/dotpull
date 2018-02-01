///scr_canPullPush(int objPosX, int objPosY, bool moveDiag, par_robot robot)

var robot = argument3;

if (!(canPull || canPush)) return false;
if (isDeactivated) return false;

print(argument0);
print(argument1);

if (isSpike){
    if (targetLocked){
        if (instance_place(argument0, argument1, par_obstacle)){
            print("SPIKE STOPPED BY OBSTACLE!!!!");
            return false;
        }
        else if (!instance_place(argument0, argument1, par_platform)){
            print("No platform to push spike to");
            return false;
        }
        return true;
    }
}

if (instance_place(argument0, argument1, par_robot) && !isSpike){
    print("Can't move, player in the way");
    //print(string(argument0)); print(string(argument1)); print(string(obj_player.x)); print(string(obj_player.y));
    //print(string(global.oldPlayerX)); print(string(global.oldPlayerY));
    return false; //there's a player here!!  don't move!
}

//print("this far...");

var xDiff = robot.x - x;
var yDiff = robot.y - y;

if (!argument2 && (canPull || canPush) && !(canPull && canPush)){ //this checks left/right only
    //print("do not print");

    if (yDiff == 0){ //player is moving left/right; check for objects towards the player
        if (xDiff > 0){ //player is to the right of the obj
            for (var objX = x + global.TILE_SIZE; objX < robot.x; objX += global.TILE_SIZE){
                if (instance_place(objX, y, par_obstacle)){
                    var obs = instance_place(objX, y, par_obstacle);
                    if (isActivated(obs)){
                        return false; //don't pull if anything is in the way
                    }
                }
            }
        }
        else{ //player is to the left of the obj
            for (var objX = x - global.TILE_SIZE; objX > robot.x; objX -= global.TILE_SIZE){
                if (instance_place(objX, y, par_obstacle)){
                    var obs = instance_place(objX, y, par_obstacle);
                    if (isActivated(obs) && !instance_place(objX, y, obj_snare)){
                        print(objX);
                        print("something i nthe way");
                        print(isDeactivated);
                        return false; //don't pull if anything is in the way
                    }
                    else{
                    }
                }
            }
        }
    }
    if (xDiff == 0){ //player is moving up/down; check for objects towards the player
        if (yDiff < 0){ //player is above the obj
            for (var objY = y - global.TILE_SIZE; objY > robot.y; objY -= global.TILE_SIZE){
                if (instance_place(x, objY, par_obstacle)){
                    var obs = instance_place(x, objY, par_obstacle);
                    //print("isDeactived?");
                    if (isActivated(obs)){
                        return false; //don't pull if anything is in the way
                    }
                }
            }
        }
        else{ //player is below the obj
            for (var objY = y + global.TILE_SIZE; objY < robot.y; objY += global.TILE_SIZE){
                if (instance_place(x, objY, par_obstacle)){
                    var obs = instance_place(x, objY, par_obstacle);
                    //print(obs.isDeactivated);
                    if (!obs.isDeactivated){
                        print("oh no it is activated");
                        return false; //don't pull if anything is in the way
                    }
                    else{
                        print("it is not activated");
                    }
                }
            }
        }
    }
}

//diagonal movement
if (argument2 == true && (canPull || canPush) && !(canPull && canPush)){
    //print("Diag checking in scr_canPull");
    if (robot.y < y && robot.x > x){ //player is above the obj and to the right; pull object upright
        //print("pull object up right");
        var objX = x+global.TILE_SIZE; var objY = y-global.TILE_SIZE;
        //print(objX);
        //print(objY);
        for (objX = x + global.TILE_SIZE; objX < robot.x; objX += global.TILE_SIZE){
            //print("In that upright loop !");
            //print(objX);
            //print(objY);  
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY -= global.TILE_SIZE;  
        }
    }
    if (robot.y < y && robot.x < x){ //player is above the obj and to the left; pull object upleft
        //print("pull object up left");
        var objX = x-global.TILE_SIZE; var objY = y-global.TILE_SIZE;
        //print(objX);
        //print(objY);
        for (objX = x - global.TILE_SIZE; objX > robot.x; objX -= global.TILE_SIZE){
            //print("In that left loop !");
            //print(objX);
            //print(objY);  
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY -= global.TILE_SIZE;  
        }
    }
    if (robot.y > y && robot.x > x){ //player is below the obj and to the right; pull object downright
        //print("pull object down right");
        var objX = x + global.TILE_SIZE; var objY = y + global.TILE_SIZE;
        //print(objX);
        //print(objY);
        for (objX = x + global.TILE_SIZE; objX < robot.x; objX += global.TILE_SIZE){
            //print("In that downright loop !");
            //print(objX);
            //print(objY);  
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY += global.TILE_SIZE;  
        }          
    }
    if (robot.y > y && robot.x < x){ //player is below the obj and to the left; pull object downleft
        //print("pull object down left");
        var objX = x-global.TILE_SIZE; var objY = y+ global.TILE_SIZE;
        //print(objX);
        //print(objY);
        for (objX = x - global.TILE_SIZE; objX > robot.x; objX -= global.TILE_SIZE){
            //print("In that downleft loop !");
            //print(objX);
            //print(objY);  
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY += global.TILE_SIZE;  
        }    
    }   
}

print("wow it's here ok");


if (canPull && canPush){
    print("obj can be pushed and pulled");
    
    var xDiff = robot.x - x;
    var yDiff = robot.y - y;
    
    if (!argument2){ //this checks left/right only
    
        if (yDiff == 0){ //player is moving left/right; check for objects towards the player
            if (xDiff > 0){ //player is to the right of the obj
                for (var objX = x + global.TILE_SIZE; objX < robot.x; objX += global.TILE_SIZE){
                    if (instance_place(objX, y, par_obstacle)){
                        var obs = instance_place(objX, y, par_obstacle);
                        if (isActivated(obs)){
                            return false; //don't pull if anything is in the way
                        }
                    }
                }
            }
            else{ //player is to the left of the obj
                for (var objX = x - global.TILE_SIZE; objX > robot.x; objX -= global.TILE_SIZE){
                    if (instance_place(objX, y, par_obstacle)){
                        var obs = instance_place(objX, y, par_obstacle);
                        if (isActivated(obs) && !instance_place(objX, y, obj_snare)){
                            print(objX);
                            print("something i nthe way");
                            print(isDeactivated);
                            return false; //don't pull if anything is in the way
                        }
                    }
                }
            }
        }
        if (xDiff == 0){ //player is moving up/down; check for objects towards the player
            if (yDiff < 0){ //player is above the obj
                for (var objY = y - global.TILE_SIZE; objY > robot.y; objY -= global.TILE_SIZE){
                    if (instance_place(x, objY, par_obstacle)){
                        var obs = instance_place(x, objY, par_obstacle);
                        //print("isDeactived?");
                        if (isActivated(obs)){
                            return false; //don't pull if anything is in the way
                        }
                    }
                }
            }
            else{ //player is below the obj
                for (var objY = y + global.TILE_SIZE; objY < robot.y; objY += global.TILE_SIZE){
                    if (instance_place(x, objY, par_obstacle)){
                        var obs = instance_place(x, objY, par_obstacle);
                        //print(obs.isDeactivated);
                        if (!obs.isDeactivated){
                            print("oh no it is activated");
                            return false; //don't pull if anything is in the way
                        }
                    }
                }
            }
        }
    }
    
    //diagonal movement
    if (argument2 == true){
        //print("Diag checking in scr_canPull");
        if (robot.y < y && robot.x > x){ //player is above the obj and to the right; pull object upright
            //print("pull object up right");
            var objX = x+global.TILE_SIZE; var objY = y-global.TILE_SIZE;
            //print(objX);
            //print(objY);
            for (objX = x + global.TILE_SIZE; objX < robot.x; objX += global.TILE_SIZE){
                //print("In that upright loop !");
                //print(objX);
                //print(objY);  
                if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
                objY -= global.TILE_SIZE;  
            }
        }
        if (robot.y < y && robot.x < x){ //player is above the obj and to the left; pull object upleft
            //print("pull object up left");
            var objX = x-global.TILE_SIZE; var objY = y-global.TILE_SIZE;
            //print(objX);
            //print(objY);
            for (objX = x - global.TILE_SIZE; objX > robot.x; objX -= global.TILE_SIZE){
                //print("In that left loop !");
                //print(objX);
                //print(objY);  
                if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
                objY -= global.TILE_SIZE;  
            }
        }
        if (robot.y > y && robot.x > x){ //player is below the obj and to the right; pull object downright
            //print("pull object down right");
            var objX = x + global.TILE_SIZE; var objY = y + global.TILE_SIZE;
            //print(objX);
            //print(objY);
            for (objX = x + global.TILE_SIZE; objX < robot.x; objX += global.TILE_SIZE){
                //print("In that downright loop !");
                //print(objX);
                //print(objY);  
                if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
                objY += global.TILE_SIZE;  
            }          
        }
        if (robot.y > y && robot.x < x){ //player is below the obj and to the left; pull object downleft
            //print("pull object down left");
            var objX = x-global.TILE_SIZE; var objY = y+ global.TILE_SIZE;
            //print(objX);
            //print(objY);
            for (objX = x - global.TILE_SIZE; objX > robot.x; objX -= global.TILE_SIZE){
                //print("In that downleft loop !");
                //print(objX);
                //print(objY);  
                if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
                objY += global.TILE_SIZE;  
            }    
        }   
    }
}

if (instance_place(x, y, obj_triggerDoor) && !instance_place(argument0, argument1, obj_wall)){
    if (!isActivated(instance_place(x, y, obj_triggerDoor))){
        print("obj trapped above");
        return false; //can't move if above    
    }
}
if (instance_place(argument0, argument1, obj_block) ||
    instance_place(argument0, argument1, obj_blockPush) ||
    instance_place(argument0, argument1, obj_blockPushPull)){
    //print("Block in the way!");
    return false;
}

if (instance_place(argument0, argument1, par_fallingPlatform)){
    var fallingPlat = instance_place(argument0, argument1, par_fallingPlatform);
    if (fallingPlat.isDeactivated){
        print("Falling platform is deactivated; can't pull");
        return false;
    }
    else{
        print("yeah it's deactivated i guess");
        print(fallingPlat.isDeactivated);
        return true;
    }
}

//key parsing
/*if (isDeactivated == true && (canPull || canPush)){
    if (x != 0 && y != 0){
        print("Not deactivated anymore");
        isDeactivated = false;
        //obj_player.numKeys--;
    }
    else{
        print("Obj deactivated"); 
        return false; //do not pull this object
    }
}*/

if (instance_place(argument0, argument1, obj_spike)){
    //print("Spike in the way!");
    return false;
}
if (instance_place(argument0, argument1, obj_key)){
    //print("Key in the way!");
    return false;
}

if (instance_place(argument0, argument1, obj_trigger) && 
   !instance_place(argument0, argument1, par_obstacle) &&
   !instance_place(argument0, argument1, robot)){
    //print("There's a trigger here.");
    return true;
}
if (instance_place(argument0, argument1, obj_triggerDoor)){
    //print("There's a triggerDoor here.");
    var triggerDoor = instance_place(argument0, argument1, obj_triggerDoor);
    if (triggerDoor.isDeactivated) return true;
    return false;
}

if (instance_place(argument0, argument1, obj_hole)){
    //print("Can't move, hole in the way");
    if (!canFall) return false; //there's a hole here!!  don't move unless you can go over holes!
}

with(instance_place(argument0, argument1, par_obstacle)){
    if (isActivated(self)) {
        print("Oh no an obstacle is here and it's activated !!!");
        return false;    
    }
}

if (!instance_place(argument0, argument1, par_platform)){
    print("No platform to push/pull to");
    return false;
}


return true;
