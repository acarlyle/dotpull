///scr_canPullPush_instancePlaceVersion(int objPosX, int objPosY, bool moveDiag, par_object object, par_robot robot, bool mirptrExt)

/*
    LEGACY SCRIPT
    Pull/push logic used to work by checking real objects
    in the current room
*/

/*

print("-> scr_canPullPush(" + string(argument0) + ", " + string(argument1) + ")");

var posX = argument0;
var posY = argument1;
var diagonalMovement = argument2; //boolean
var object = argument3;
var robot = argument4;
var mirptr = argument5;

var badArgList = undefined;
var mirptrHz = false;
var mirptrVt = false;
var xDiff = robot[| OBJECT.X] - posX;
var yDiff = robot[| OBJECT.Y] - posY;

if (diagonalMovement) print("scr_canPullPush diag checking");

// spikes don't care if there's a robot in the way
//if (objectStr(object) == "obj_spike") { badArgList = array(par_obstacle) }
//else { badArgList = array(par_robot, par_obstacle); }
badArgList = array(par_robot, par_obstacle);

//if there's a mirptr in the path of the object, reset object position back to where it should be
// +/- diff to spot to pull to
if (mirptr){
    if (object.x == mirptr.x){
        mirptrVt = true;
    }
    if (object.y == mirptr.y){ 
        mirptrHz = true;
    }
    posX = object.x + (posX - mirptr.x);
    posY = object.y + (posY - mirptr.y);
    //posX = object.x; 
    //posY = object.y;
    xDiff = robot.oldPlayerX - posX;
    yDiff = robot.oldPlayerY - posY; 
    if (xDiff == 0 && yDiff == 0){
        xDiff = robot[| OBJECT.X] - posX;
        yDiff = robot[| OBJECT.Y] - posY;
    }
}

print("UPDATED scr_canPullPush posX, posY: " + string(posX) + ", " + string(posY));


if (!(canPull || canPush)) return false;
if (isDeactivated) return false;

//Handle state change from active, targetLocked spike
if (objectStr(self) == "obj_spike"){
    if (targetLocked){
        if (instance_place(posX, posY, par_fallingPlatform)){
            var fallingPlat = instance_place(posX, posY, par_fallingPlatform);
            if (fallingPlat.isDeactivated){
                print("Falling platform is deactivated; can't pull");
                return false;
            }
        }
        if (instance_place(posX, posY, par_breakableWall)){
            breakableWall = instance_place(posX, posY, par_breakableWall);
            e_damageBreakableWall(breakableWall);
            if (breakableWall.isDeactivated){
                return true;
            }
        }
        if (instance_place(posX, posY, par_obstacle) &&
           !instance_place(posX, posY, obj_baby)){
            var obs = instance_place(posX, posY, par_obstacle);
            print(obs.isDeactivated);
            if (isActivated(obs)){
                print("SPIKE STOPPED BY OBSTACLE!!!!");
                return false;
            }
        }
        else if (!instance_place(posX, posY, par_platform)){
            print("No platform to push spike to");
            return false;
        }
        return true;
    }
}

print("scr_canPullPush: posX, posY: " + string(posX) + ", " + string(posY));
print("scr_canPullPush: xDiff, yDiff: " + string(xDiff) + ", " + string(yDiff));
print("scr_canPullPush: oldRobotX, oldRobotY: " + string(robot.oldPlayerX) + ", " + string(robot.oldPlayerY));

/*
    TODO
    
    This xDiff + yDiff logic doesn't apply when an object that can move into robots is right next to a
    robot.  E.G. -> a spike that is one tile to the right of Rob has an xDiff of zero (Rob.x - posToPullTo).
    Therefore, the logic results in the second else being checked after xDiff fails.  This isn't right because
    xDiff is zero regardless.  The logic doesn't catch this edge case.  The result of this bobo is fine
    but there might be a time when it's a problem.    
*/
/*
if (!diagonalMovement && (canPull || canPush) && !(canPull && canPush)){ //this checks left/right only
    if (yDiff == 0 || (!mirptrVt && mirptrHz)){ //player is moving left/right; check for objects towards the player
        print("scr_canPullPush: Robot moving left/right");
        if (xDiff > 0){ //player is to the right of the obj
            var objX = object.x + global.TILE_SIZE;
            var objY = object.y;
            while(!scr_tileContains(objX, objY, badArgList)){
                print("scr_canPullPush: player right: x, y: " + string(objX) + ", " + string(objY));
                if (instance_place(objX, objY, obj_mirptr)){
                    //objX += global.TILE_SIZE;
                    mp = instance_place(objX, objY, obj_mirptr);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    print("scr_canPullPush: mp is a real boy; new objY: " + string(objY));
                }
                objX += global.TILE_SIZE;
            }
            // checking for this specific robot at this position; we don't want to move it for rob + roberta
            // if she's next to Rob 
            if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
            
            if (!instance_place(objX, objY, par_robot)){
                print("scr_canPullPush: No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }
        }
        else{ //player is to the left of the obj
            var objX = object.x - global.TILE_SIZE;
            var objY = object.y;
            while(!scr_tileContains(objX, objY, badArgList)){
                print("scr_canPullPush: player left: x, y: " + string(objX) + ", " + string(objY));
                if (instance_place(objX, objY, obj_mirptr)){
                    //objX -= global.TILE_SIZE;
                    mp = instance_place(objX, objY, obj_mirptr);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    print("scr_canPullPush: mp is a real boy; new objY: " + string(objY));
                }
                objX -= global.TILE_SIZE;
            }
            
            // checking for this specific robot at this position; we don't want to move it for rob + roberta
            // if she's next to Rob 
            if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
            
            if (!instance_place(objX, objY, par_robot)){
                print("scr_canPullPush: No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }
        }
    }
    //print("xDIFF: " + string(xDiff));
    //print("yDIFF: " + string(yDiff));
    if (xDiff == 0 || (!mirptrHz && mirptrVt)){ //player is moving up/down; check for objects towards the player
        print("scr_canPullPush: Robot moving up/down, moveDir: " + string(robot[| OBJECT.MOVEDDIR));
        if (yDiff < 0){ //player is above the obj
            var objX = object.x;
            var objY = y - global.TILE_SIZE
            //for (var objY = y - global.TILE_SIZE; (objY > endPosY) || (objY > robot[| OBJECT.Y]); objY -= global.TILE_SIZE){
            while(!scr_tileContains(objX, objY, badArgList)){
                print("player above: x, y: " + string(objX) + ", " + string(objY));
                if (instance_place(objX, objY, obj_mirptr)){
                    //objY -= global.TILE_SIZE;
                    mp = instance_place(objX, objY, obj_mirptr);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    print("mp is a real boy; new objX: " + string(objY));
                }
                objY -= global.TILE_SIZE;
            }
            
            // checking for this specific robot at this position; we don't want to move it for rob + roberta
            // if she's next to Rob 
            if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
            
            if (!instance_place(objX, objY, par_robot)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }
        }
        else{
            print("below object");
            var objX = object.x;
            var objY = y + global.TILE_SIZE;
            //print("objY: " + string(objY));
            //for (var objY = y + global.TILE_SIZE; (objY < endPosY) || (objY < robot[| OBJECT.Y]); objY += global.TILE_SIZE){
            while(!scr_tileContains(objX, objY, badArgList)){
                print("player below: x, y: " + string(objX) + ", " + string(objY));
                //var yakuza = "ya";
                //get_string(yakuza, yakuza);
                if (instance_place(objX, objY, obj_mirptr)){
                    //objY += global.TILE_SIZE;
                    mp = instance_place(objX, objY, obj_mirptr);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    //objY += global.TILE_SIZE;
                    print("mp is a real boy; new objX, objY: " + string(objX) + "," + string(objY));
                }
                objY += global.TILE_SIZE;
            }
            
            // checking for this specific robot at this position; we don't want to move it for rob + roberta
            // if she's next to Rob 
            if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
            
            if (!instance_place(objX, objY, par_robot)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                print("Robot at: " + string(robot[| OBJECT.X]) + " " + string(robot[| OBJECT.Y]));
                return false;
            }
        }
    }
}

//diagonal movement
if (diagonalMovement == true && (canPull || canPush) && !(canPull && canPush)){
    print("scr_canPullPush: Diag checking");
    if (robot[| OBJECT.Y] < y && robot[| OBJECT.X] > x){ //player is above the obj and to the right; pull object upright
        var objX = x+global.TILE_SIZE; var objY = y-global.TILE_SIZE;
        while(!scr_tileContains(objX, objY, badArgList)){
            print("scr_canPullPush: robot upright: x, y: " + string(objX) + ", " + string(objY));
            if (instance_place(objX, objY, obj_mirptr)){
                mp = instance_place(objX, objY, obj_mirptr);
                objX = mp.mirptrPtr.x;
                objY = mp.mirptrPtr.y;
                print("scr_canPullPush: mp is a real boy; new objX: " + string(objX));
                print("scr_canPullPush: mp is a real boy; new objY: " + string(objY));
            }  
            objX += global.TILE_SIZE;
            objY -= global.TILE_SIZE;  
        }
        
        // checking for this specific robot at this position; we don't want to move it for rob + roberta
        // if she's next to Rob 
        if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
            
        if (!instance_place(objX, objY, par_robot)){
            print("scr_canPullPush: No robot here! :(" + " " + string(objX) + " " + string(objY));
            return false;
        }
    }
    if (robot[| OBJECT.Y] < y && robot[| OBJECT.X] < x){ //player is above the obj and to the left; pull object upleft
        var objX = x-global.TILE_SIZE; var objY = y-global.TILE_SIZE;
        while(!scr_tileContains(objX, objY, badArgList)){
            print("scr_canPullPush: robot upleft: x, y: " + string(objX) + ", " + string(objY));
            if (instance_place(objX, objY, obj_mirptr)){
                mp = instance_place(objX, objY, obj_mirptr);
                objX = mp.mirptrPtr.x;
                objY = mp.mirptrPtr.y;
                print("scr_canPullPush: mp is a real boy; new objX: " + string(objX));
                print("scr_canPullPush: mp is a real boy; new objY: " + string(objY));
            } 
            objX -= global.TILE_SIZE;
            objY -= global.TILE_SIZE;  
        }
        
        // checking for this specific robot at this position; we don't want to move it for rob + roberta
        // if she's next to Rob 
        if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
        
        if (!instance_place(objX, objY, par_robot)){
            print("scr_canPullPush: No robot here! :(" + " " + string(objX) + " " + string(objY));
            return false;
        }
    }
    if (robot[| OBJECT.Y] > y && robot[| OBJECT.X] > x){ //player is below the obj and to the right; pull object downright
        var objX = x + global.TILE_SIZE; var objY = y + global.TILE_SIZE;
        while(!scr_tileContains(objX, objY, badArgList)){
            print("scr_canPullPush: robot downright: x, y: " + string(objX) + ", " + string(objY));
            if (instance_place(objX, objY, obj_mirptr)){
                mp = instance_place(objX, objY, obj_mirptr);
                objX = mp.mirptrPtr.x;
                objY = mp.mirptrPtr.y;
                print("scr_canPullPush: mp is a real boy; new objX: " + string(objX));
                print("scr_canPullPush: mp is a real boy; new objY: " + string(objY));
            } 
            objX += global.TILE_SIZE;
            objY += global.TILE_SIZE;  
        }   
        
        // checking for this specific robot at this position; we don't want to move it for rob + roberta
        // if she's next to Rob 
        if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
        
        if (!instance_place(objX, objY, par_robot)){
            print("scr_canPullPush: No robot here! :(" + " " + string(objX) + " " + string(objY));
            return false;
        }       
    }
    if (robot[| OBJECT.Y] > y && robot[| OBJECT.X] < x){ //player is below the obj and to the left; pull object downleft
        var objX = x-global.TILE_SIZE; var objY = y+ global.TILE_SIZE;
        while(!scr_tileContains(objX, objY, badArgList)){
            print("scr_canPullPush: robot downleft: x, y: " + string(objX) + ", " + string(objY));
            if (instance_place(objX, objY, obj_mirptr)){
                mp = instance_place(objX, objY, obj_mirptr);
                objX = mp.mirptrPtr.x;
                objY = mp.mirptrPtr.y;
                print("scr_canPullPush: mp is a real boy; new objX: " + string(objX));
                print("scr_canPullPush: mp is a real boy; new objY: " + string(objY));
            }   
            objX -= global.TILE_SIZE;
            objY += global.TILE_SIZE;  
        }
        
        // checking for this specific robot at this position; we don't want to move it for rob + roberta
        // if she's next to Rob 
        if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
        
        if (!instance_place(objX, objY, par_robot)){
            print("scr_canPullPush: No robot here! :(" + " " + string(objX) + " " + string(objY));
            return false;
        }    
    }   
} //end diag movement for push or pull

if (canPull && canPush){
    print("scr_canPullPush: obj can be pushed and pulled");
    
    var xDiff = robot[| OBJECT.X] - x;
    var yDiff = robot[| OBJECT.Y] - y;
    
    if (!diagonalMovement){ //this checks left/right only
    
        if (yDiff == 0){ //player is moving left/right; check for objects towards the player
            if (xDiff > 0){ //player is to the right of the obj
                //for (var objX = x + global.TILE_SIZE; objX < endPosX; objX += global.TILE_SIZE){
                while(!scr_tileContains(objX, objY, badArgList)){
                    print("robot right pull&push: x, y: " + string(objX) + ", " + string(objY));
                    if (instance_place(objX, objY, obj_mirptr)){
                        mp = instance_place(objX, objY, obj_mirptr);
                        objX = mp.mirptrPtr.x;
                        objY = mp.mirptrPtr.y;
                        print("mp is a real boy; new objX: " + string(objX));
                        print("mp is a real boy; new objY: " + string(objY));
                    } 
                    objX += global.TILE_SIZE;
                }
                
                // checking for this specific robot at this position; we don't want to move it for rob + roberta
                // if she's next to Rob 
                if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
        
                if (!instance_place(objX, objY, par_robot)){
                    print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                    return false;
                }
                
            }
            else{ //player is to the left of the obj
                //for (var objX = x - global.TILE_SIZE; objX > endPosX; objX -= global.TILE_SIZE){
                while(!scr_tileContains(objX, objY, badArgList)){
                    print("robot left pull&push: x, y: " + string(objX) + ", " + string(objY));
                    if (instance_place(objX, objY, obj_mirptr)){
                        mp = instance_place(objX, objY, obj_mirptr);
                        objX = mp.mirptrPtr.x;
                        objY = mp.mirptrPtr.y;
                        print("mp is a real boy; new objX: " + string(objX));
                        print("mp is a real boy; new objY: " + string(objY));
                    } 
                    objX -= global.TILE_SIZE;
                }
                
                // checking for this specific robot at this position; we don't want to move it for rob + roberta
                // if she's next to Rob 
                if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
                
                if (!instance_place(objX, objY, par_robot)){
                    print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                    return false;
                }
            }
        }
        if (xDiff == 0){ //player is moving up/down; check for objects towards the player
            if (yDiff < 0){ //player is above the obj
                //for (var objY = y - global.TILE_SIZE; objY > endPosY; objY -= global.TILE_SIZE){
                while(!scr_tileContains(objX, objY, badArgList)){
                    print("robot above pull&push: x, y: " + string(objX) + ", " + string(objY));
                    if (instance_place(objX, objY, obj_mirptr)){
                        mp = instance_place(objX, objY, obj_mirptr);
                        objX = mp.mirptrPtr.x;
                        objY = mp.mirptrPtr.y;
                        print("mp is a real boy; new objX: " + string(objX));
                        print("mp is a real boy; new objY: " + string(objY));
                    }
                    objY -= global.TILE_SIZE; 
                }
                
                // checking for this specific robot at this position; we don't want to move it for rob + roberta
                // if she's next to Rob 
                if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
                
                if (!instance_place(objX, objY, par_robot)){
                    print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                    return false;
                }
            }
            else{ //player is below the obj
                //for (var objY = y + global.TILE_SIZE; objY < endPosY; objY += global.TILE_SIZE){
                while(!scr_tileContains(objX, objY, badArgList)){
                    print("robot below pull&push: x, y: " + string(objX) + ", " + string(objY));
                    if (instance_place(objX, objY, obj_mirptr)){
                        mp = instance_place(objX, objY, obj_mirptr);
                        objX = mp.mirptrPtr.x;
                        objY = mp.mirptrPtr.y;
                        print("mp is a real boy; new objX: " + string(objX));
                        print("mp is a real boy; new objY: " + string(objY));
                    } 
                    objY += global.TILE_SIZE;
                }
                
                // checking for this specific robot at this position; we don't want to move it for rob + roberta
                // if she's next to Rob 
                if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
                
                if (!instance_place(objX, objY, par_robot)){
                    print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                    return false;
                }
            }
        }
    }
    
    //diagonal movement
    if (diagonalMovement == true){
        //print("Diag checking in scr_canPull");
        if (robot[| OBJECT.Y] < y && robot[| OBJECT.X] > x){ //player is above the obj and to the right; pull object upright
            //print("pull object up right");
            var objX = x+global.TILE_SIZE; var objY = y-global.TILE_SIZE;
            while(!scr_tileContains(objX, objY, badArgList)){
                print("robot upright pull&push: x, y: " + string(objX) + ", " + string(objY));
                if (instance_place(objX, objY, obj_mirptr)){
                    mp = instance_place(objX, objY, obj_mirptr);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    print("mp is a real boy; new objX: " + string(objX));
                    print("mp is a real boy; new objY: " + string(objY));
                }   
                objX += global.TILE_SIZE;
                objY -= global.TILE_SIZE;  
            }
            
            // checking for this specific robot at this position; we don't want to move it for rob + roberta
            // if she's next to Rob 
            if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
                
            if (!instance_place(objX, objY, par_robot)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }
        }
        if (robot[| OBJECT.Y] < y && robot[| OBJECT.X] < x){ //player is above the obj and to the left; pull object upleft
            var objX = x-global.TILE_SIZE; var objY = y-global.TILE_SIZE;
            //for (objX = x - global.TILE_SIZE; objX > endPosX; objX -= global.TILE_SIZE){
            while(!scr_tileContains(objX, objY, badArgList)){
                print("robot upleft pull&push: x, y: " + string(objX) + ", " + string(objY));
                if (instance_place(objX, objY, obj_mirptr)){
                    mp = instance_place(objX, objY, obj_mirptr);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    print("mp is a real boy; new objX: " + string(objX));
                    print("mp is a real boy; new objY: " + string(objY));
                }    
                objX -= global.TILE_SIZE;
                objY -= global.TILE_SIZE;  
            }
            
            // checking for this specific robot at this position; we don't want to move it for rob + roberta
            // if she's next to Rob 
            if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
            
            if (!instance_place(objX, objY, par_robot)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }
        }
        if (robot[| OBJECT.Y] > y && robot[| OBJECT.X] > x){ //player is below the obj and to the right; pull object downright
            var objX = x + global.TILE_SIZE; var objY = y + global.TILE_SIZE;
            //for (objX = x + global.TILE_SIZE; objX < endPosX; objX += global.TILE_SIZE){
            while(!scr_tileContains(objX, objY, badArgList)){
                print("robot downright pull&push: x, y: " + string(objX) + ", " + string(objY));
                if (instance_place(objX, objY, obj_mirptr)){
                    mp = instance_place(objX, objY, obj_mirptr);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    print("mp is a real boy; new objX: " + string(objX));
                    print("mp is a real boy; new objY: " + string(objY));
                }    
                objX += global.TILE_SIZE;
                objY += global.TILE_SIZE;  
            }  
            
            // checking for this specific robot at this position; we don't want to move it for rob + roberta
            // if she's next to Rob 
            if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
            
            if (!instance_place(objX, objY, par_robot)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }        
        }
        if (robot[| OBJECT.Y] > y && robot[| OBJECT.X] < x){ //player is below the obj and to the left; pull object downleft
            var objX = x-global.TILE_SIZE; var objY = y+ global.TILE_SIZE;
            //for (objX = x - global.TILE_SIZE; objX > endPosX; objX -= global.TILE_SIZE){
            while(!scr_tileContains(objX, objY, badArgList)){
                print("robot downleft pull&push: x, y: " + string(objX) + ", " + string(objY));
                if (instance_place(objX, objY, obj_mirptr)){
                    mp = instance_place(objX, objY, obj_mirptr);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    print("mp is a real boy; new objX: " + string(objX));
                    print("mp is a real boy; new objY: " + string(objY));
                }     
                objX -= global.TILE_SIZE;
                objY += global.TILE_SIZE;  
            }  
            
            // checking for this specific robot at this position; we don't want to move it for rob + roberta
            // if she's next to Rob 
            if (instance_place(objX, objY, par_robot) == robot && canMoveIntoRobot){ return true; }
            
            if (!instance_place(objX, objY, par_robot)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }  
        }   
    }
}

if (instance_place(x, y, obj_triggerDoor) && !instance_place(posX, posY, obj_wall)){
    if (isActivated(instance_place(x, y, obj_triggerDoor))){
        print("scr_canPullPush: obj trapped above");
        return false; //can't move if above    
    }
}
//TODO -> outdated code.  update to use par_pullable, at least
if (instance_place(posX, posY, obj_block) ||
    instance_place(posX, posY, obj_blockPush) ||
    instance_place(posX, posY, obj_blockPushPull)){
    //print("Block in the way!");
    return false;
}

if (instance_place(posX, posY, par_fallingPlatform)){
    var fallingPlat = instance_place(posX, posY, par_fallingPlatform);
    if (fallingPlat.isDeactivated){
        print("scr_canPullPush: Falling platform is deactivated; can't pull");
        return false;
    }
    else{
        print("scr_canPullPush: yeah it's deactivated i guess");
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
/*
if (instance_place(posX, posY, obj_spike)){
    //print("Spike in the way!");
    return false;
}
if (instance_place(posX, posY, obj_key)){
    //print("Key in the way!");
    return false;
}

if (instance_place(posX, posY, obj_trigger) && 
   !instance_place(posX, posY, par_obstacle) &&
   !instance_place(posX, posY, robot)){
    //print("There's a trigger here.");
    return true;
}
if (instance_place(posX, posY, obj_triggerDoor)){
    //print("There's a triggerDoor here.");
    var triggerDoor = instance_place(posX, posY, obj_triggerDoor);
    if (triggerDoor.isDeactivated) return true;
    return false;
}

if (instance_place(posX, posY, obj_hole)){
    //print("Can't move, hole in the way");
    if (!canFall) return false; //there's a hole here!!  don't move unless you can go over holes!
}

if(instance_place(posX, posY, par_obstacle)){
    var obs = instance_place(posX, posY, par_obstacle);
    if (isActivated(obs)) {
        print("scr_canPullPush: Oh no an obstacle is here and it's activated !!!");
        return false;    
    }
}

if (!instance_place(posX, posY, par_platform)){
    print("scr_canPullPush: No platform to push/pull to");
    return false;
}


return true;*/
