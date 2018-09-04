///scr_canPullPush(int objPosX, int objPosY, bool moveDiag, enum objEnum, par_robot robot, bool mirptrExt, par_layer layer)

print("-> scr_canPullPush(" + string(argument0) + ", " + string(argument1) + ")");

var posX = argument0;
var posY = argument1;
var diagonalMovement = argument2; //boolean
var object = argument3; //objEnum
var robot = argument4;
var mirptr = argument5;
var layer = argument6;

var badArgList = undefined;
var mirptrHz = false;
var mirptrVt = false;
var xDiff = robot.x - posX;
var yDiff = robot.y - posY;

if (diagonalMovement) print("scr_canPullPush diag checking");

var badArgList = array(par_robot, par_obstacle);

//if there's a mirptr in the path of the object, reset object position back to where it should be
// +/- diff to spot to pull to
if (mirptr){
    if (object[| OBJECT.X] == mirptr.x){
        mirptrVt = true;
    }
    if (object[| OBJECT.Y] == mirptr.y){ 
        mirptrHz = true;
    }
    posX = object[| OBJECT.X] + (posX - mirptr.x);
    posY = object[| OBJECT.Y] + (posY - mirptr.y);
    xDiff = robot.oldPlayerX - posX;
    yDiff = robot.oldPlayerY - posY; 
    if (xDiff == 0 && yDiff == 0){
        xDiff = robot.x - posX;
        yDiff = robot.y - posY;
    }
}

print("UPDATED scr_canPullPush posX, posY: " + string(posX) + ", " + string(posY));
print("isActive: " + string(object[| OBJECT.ISACTIVE]));


if (!(object[| OBJECT.CANPULL] || object[| OBJECT.CANPUSH])) return false;
if (!object[| OBJECT.ISACTIVE]) return false; //if it's not pullable, return

//Handle state change from active, targetLocked spike
if (object[| OBJECT.NAME] == "obj_spike"){
    if (targetLocked){
        if (map_place(layer, par_fallingPlatform, posX, posY)){
            var fallingPlat = map_place(layer, par_fallingPlatform, posX, posY);
            if (fallingPlat.isDeactivated){
                print("Falling platform is deactivated; can't pull");
                return false;
            }
        }
        if (map_place(layer, par_breakableWall, posX, posY)){
            breakableWall = map_place(layer, par_breakableWall, posX, posY);
            e_damageBreakableWall(breakableWall);
            if (breakableWall.isDeactivated){
                return true;
            }
        }
        if (map_place(layer, par_obstacle, posX, posY) &&
           !map_place(layer, obj_baby, posX, posY)){
            var obs = map_place(layer, par_obstacle, posX, posY);
            print(obs.isDeactivated);
            if (isActivated(obs)){
                print("SPIKE STOPPED BY OBSTACLE!!!!");
                return false;
            }
        }
        else if (!map_place(layer, par_platform, posX, posY)){
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

if (!diagonalMovement && (object[| OBJECT.CANPULL] || object[| OBJECT.CANPUSH]) && !(object[| OBJECT.CANPULL] && object[| OBJECT.CANPUSH])){ //this checks left/right only
    if (yDiff == 0 || (!mirptrVt && mirptrHz)){ //player is moving left/right; check for objects towards the player
        print("scr_canPullPush: Robot moving left/right");
        if (xDiff > 0){ //player is to the right of the obj
            var objX = object[| OBJECT.X] + global.TILE_SIZE;
            var objY = object[| OBJECT.Y];
            while(!scr_tileContains(layer, objX, objY, badArgList)){
                print("scr_canPullPush: player right: x, y: " + string(objX) + ", " + string(objY));
                if (map_place(layer, obj_mirptr, objX, objY)){
                    //objX += global.TILE_SIZE;
                    mp = map_place(layer, obj_mirptr, objX, objY);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    print("scr_canPullPush: mp is a real boy; new objY: " + string(objY));
                }
                objX += global.TILE_SIZE;
            }
            // checking for this specific robot at this position; we don't want to move it for rob + roberta
            // if she's next to Rob 
            if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
            
            if (!map_place(layer, par_robot, objX, objY)){
                print("scr_canPullPush: No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }
        }
        else{ //player is to the left of the obj
            var objX = object[| OBJECT.X] - global.TILE_SIZE;
            var objY = object[| OBJECT.Y];
            while(!scr_tileContains(layer, objX, objY, badArgList)){
                print("scr_canPullPush: player left: x, y: " + string(objX) + ", " + string(objY));
                if (map_place(layer, obj_mirptr, objX, objY)){
                    //objX -= global.TILE_SIZE;
                    mp = map_place(layer, obj_mirptr, objX, objY);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    print("scr_canPullPush: mp is a real boy; new objY: " + string(objY));
                }
                objX -= global.TILE_SIZE;
            }
            
            // checking for this specific robot at this position; we don't want to move it for rob + roberta
            // if she's next to Rob 
            if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
            
            if (!map_place(layer, par_robot, objX, objY)){
                print("x,y: " + string (objX) + "," + string(objY));
                print("HERE scr_canPullPush: No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }
        }
    }
    //print("xDIFF: " + string(xDiff));
    //print("yDIFF: " + string(yDiff));
    if (xDiff == 0 || (!mirptrHz && mirptrVt)){ //player is moving up/down; check for objects towards the player
        print("scr_canPullPush: Robot moving up/down, moveDir: " + string(robot.movedDir));
        if (yDiff < 0){ //player is above the obj
            var objX = object[| OBJECT.X];
            var objY = y - global.TILE_SIZE
            //for (var objY = y - global.TILE_SIZE; (objY > endPosY) || (objY > robot.y); objY -= global.TILE_SIZE){
            while(!scr_tileContains(layer, objX, objY, badArgList)){
                print("player above: x, y: " + string(objX) + ", " + string(objY));
                if (map_place(layer, obj_mirptr, objX, objY)){
                    //objY -= global.TILE_SIZE;
                    mp = map_place(layer, obj_mirptr, objX, objY);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    print("mp is a real boy; new objX: " + string(objY));
                }
                objY -= global.TILE_SIZE;
            }
            
            // checking for this specific robot at this position; we don't want to move it for rob + roberta
            // if she's next to Rob 
            if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
            
            if (!map_place(layer, par_robot, objX, objY)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }
        }
        else{
            print("below object");
            var objX = object[| OBJECT.X];
            var objY = y + global.TILE_SIZE;
            //print("objY: " + string(objY));
            //for (var objY = y + global.TILE_SIZE; (objY < endPosY) || (objY < robot.y); objY += global.TILE_SIZE){
            while(!scr_tileContains(layer, objX, objY, badArgList)){
                print("player below: x, y: " + string(objX) + ", " + string(objY));
                //var yakuza = "ya";
                //get_string(yakuza, yakuza);
                if (map_place(layer, obj_mirptr, objX, objY)){
                    //objY += global.TILE_SIZE;
                    mp = map_place(layer, obj_mirptr, objX, objY);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    //objY += global.TILE_SIZE;
                    print("mp is a real boy; new objX, objY: " + string(objX) + "," + string(objY));
                }
                objY += global.TILE_SIZE;
            }
            
            // checking for this specific robot at this position; we don't want to move it for rob + roberta
            // if she's next to Rob 
            if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
            
            if (!map_place(layer, par_robot, objX, objY)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                print("Robot at: " + string(robot.x) + " " + string(robot.y));
                return false;
            }
        }
    }
}

//diagonal movement
if (diagonalMovement == true && (object[| OBJECT.CANPULL] || object[| OBJECT.CANPUSH]) && !(object[| OBJECT.CANPULL] && object[| OBJECT.CANPUSH])){
    print("scr_canPullPush: Diag checking");
    if (robot.y < y && robot.x > x){ //player is above the obj and to the right; pull object upright
        var objX = x+global.TILE_SIZE; var objY = y-global.TILE_SIZE;
        while(!scr_tileContains(layer, objX, objY, badArgList)){
            print("scr_canPullPush: robot upright: x, y: " + string(objX) + ", " + string(objY));
            if (map_place(layer, obj_mirptr, objX, objY)){
                mp = map_place(layer, obj_mirptr, objX, objY);
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
        if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
            
        if (!map_place(layer, par_robot, objX, objY)){
            print("scr_canPullPush: No robot here! :(" + " " + string(objX) + " " + string(objY));
            return false;
        }
    }
    if (robot.y < y && robot.x < x){ //player is above the obj and to the left; pull object upleft
        var objX = x-global.TILE_SIZE; var objY = y-global.TILE_SIZE;
        while(!scr_tileContains(layer, objX, objY, badArgList)){
            print("scr_canPullPush: robot upleft: x, y: " + string(objX) + ", " + string(objY));
            if (map_place(layer, obj_mirptr, objX, objY)){
                mp = map_place(layer, obj_mirptr, objX, objY);
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
        if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
        
        if (!map_place(layer, par_robot, objX, objY)){
            print("scr_canPullPush: No robot here! :(" + " " + string(objX) + " " + string(objY));
            return false;
        }
    }
    if (robot.y > y && robot.x > x){ //player is below the obj and to the right; pull object downright
        var objX = x + global.TILE_SIZE; var objY = y + global.TILE_SIZE;
        while(!scr_tileContains(layer, objX, objY, badArgList)){
            print("scr_canPullPush: robot downright: x, y: " + string(objX) + ", " + string(objY));
            if (map_place(layer, obj_mirptr, objX, objY)){
                mp = map_place(layer, obj_mirptr, objX, objY);
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
        if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
        
        if (!map_place(layer, par_robot, objX, objY)){
            print("scr_canPullPush: No robot here! :(" + " " + string(objX) + " " + string(objY));
            return false;
        }       
    }
    if (robot.y > y && robot.x < x){ //player is below the obj and to the left; pull object downleft
        var objX = x-global.TILE_SIZE; var objY = y+ global.TILE_SIZE;
        while(!scr_tileContains(layer, objX, objY, badArgList)){
            print("scr_canPullPush: robot downleft: x, y: " + string(objX) + ", " + string(objY));
            if (map_place(layer, obj_mirptr, objX, objY)){
                mp = map_place(layer, obj_mirptr, objX, objY);
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
        if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
        
        if (!map_place(layer, par_robot, objX, objY)){
            print("scr_canPullPush: No robot here! :(" + " " + string(objX) + " " + string(objY));
            return false;
        }    
    }   
} //end diag movement for push or pull

if (object[| OBJECT.CANPULL] && object[| OBJECT.CANPUSH]){
    print("scr_canPullPush: obj can be pushed and pulled");
    
    var xDiff = robot.x - x;
    var yDiff = robot.y - y;
    
    if (!diagonalMovement){ //this checks left/right only
    
        if (yDiff == 0){ //player is moving left/right; check for objects towards the player
            if (xDiff > 0){ //player is to the right of the obj
                //for (var objX = x + global.TILE_SIZE; objX < endPosX; objX += global.TILE_SIZE){
                while(!scr_tileContains(layer, objX, objY, badArgList)){
                    print("robot right pull&push: x, y: " + string(objX) + ", " + string(objY));
                    if (map_place(layer, obj_mirptr, objX, objY)){
                        mp = map_place(layer, obj_mirptr, objX, objY);
                        objX = mp.mirptrPtr.x;
                        objY = mp.mirptrPtr.y;
                        print("mp is a real boy; new objX: " + string(objX));
                        print("mp is a real boy; new objY: " + string(objY));
                    } 
                    objX += global.TILE_SIZE;
                }
                
                // checking for this specific robot at this position; we don't want to move it for rob + roberta
                // if she's next to Rob 
                if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
        
                if (!map_place(layer, par_robot, objX, objY)){
                    print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                    return false;
                }
                
            }
            else{ //player is to the left of the obj
                //for (var objX = x - global.TILE_SIZE; objX > endPosX; objX -= global.TILE_SIZE){
                while(!scr_tileContains(layer, objX, objY, badArgList)){
                    print("robot left pull&push: x, y: " + string(objX) + ", " + string(objY));
                    if (map_place(layer, obj_mirptr, objX, objY)){
                        mp = map_place(layer, obj_mirptr, objX, objY);
                        objX = mp.mirptrPtr.x;
                        objY = mp.mirptrPtr.y;
                        print("mp is a real boy; new objX: " + string(objX));
                        print("mp is a real boy; new objY: " + string(objY));
                    } 
                    objX -= global.TILE_SIZE;
                }
                
                // checking for this specific robot at this position; we don't want to move it for rob + roberta
                // if she's next to Rob 
                if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
                
                if (!map_place(layer, par_robot, objX, objY)){
                    print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                    return false;
                }
            }
        }
        if (xDiff == 0){ //player is moving up/down; check for objects towards the player
            if (yDiff < 0){ //player is above the obj
                //for (var objY = y - global.TILE_SIZE; objY > endPosY; objY -= global.TILE_SIZE){
                while(!scr_tileContains(layer, objX, objY, badArgList)){
                    print("robot above pull&push: x, y: " + string(objX) + ", " + string(objY));
                    if (map_place(layer, obj_mirptr, objX, objY)){
                        mp = map_place(layer, obj_mirptr, objX, objY);
                        objX = mp.mirptrPtr.x;
                        objY = mp.mirptrPtr.y;
                        print("mp is a real boy; new objX: " + string(objX));
                        print("mp is a real boy; new objY: " + string(objY));
                    }
                    objY -= global.TILE_SIZE; 
                }
                
                // checking for this specific robot at this position; we don't want to move it for rob + roberta
                // if she's next to Rob 
                if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
                
                if (!map_place(layer, par_robot, objX, objY)){
                    print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                    return false;
                }
            }
            else{ //player is below the obj
                //for (var objY = y + global.TILE_SIZE; objY < endPosY; objY += global.TILE_SIZE){
                while(!scr_tileContains(layer, objX, objY, badArgList)){
                    print("robot below pull&push: x, y: " + string(objX) + ", " + string(objY));
                    if (map_place(layer, obj_mirptr, objX, objY)){
                        mp = map_place(layer, obj_mirptr, objX, objY);
                        objX = mp.mirptrPtr.x;
                        objY = mp.mirptrPtr.y;
                        print("mp is a real boy; new objX: " + string(objX));
                        print("mp is a real boy; new objY: " + string(objY));
                    } 
                    objY += global.TILE_SIZE;
                }
                
                // checking for this specific robot at this position; we don't want to move it for rob + roberta
                // if she's next to Rob 
                if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
                
                if (!map_place(layer, par_robot, objX, objY)){
                    print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                    return false;
                }
            }
        }
    }
    
    //diagonal movement
    if (diagonalMovement == true){
        //print("Diag checking in scr_canPull");
        if (robot.y < y && robot.x > x){ //player is above the obj and to the right; pull object upright
            //print("pull object up right");
            var objX = x+global.TILE_SIZE; var objY = y-global.TILE_SIZE;
            while(!scr_tileContains(layer, objX, objY, badArgList)){
                print("robot upright pull&push: x, y: " + string(objX) + ", " + string(objY));
                if (map_place(layer, obj_mirptr, objX, objY)){
                    mp = map_place(layer, obj_mirptr, objX, objY);
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
            if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
                
            if (!map_place(layer, par_robot, objX, objY)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }
        }
        if (robot.y < y && robot.x < x){ //player is above the obj and to the left; pull object upleft
            var objX = x-global.TILE_SIZE; var objY = y-global.TILE_SIZE;
            //for (objX = x - global.TILE_SIZE; objX > endPosX; objX -= global.TILE_SIZE){
            while(!scr_tileContains(layer, objX, objY, badArgList)){
                print("robot upleft pull&push: x, y: " + string(objX) + ", " + string(objY));
                if (map_place(layer, obj_mirptr, objX, objY)){
                    mp = map_place(layer, obj_mirptr, objX, objY);
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
            if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
            
            if (!map_place(layer, par_robot, objX, objY)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }
        }
        if (robot.y > y && robot.x > x){ //player is below the obj and to the right; pull object downright
            var objX = x + global.TILE_SIZE; var objY = y + global.TILE_SIZE;
            //for (objX = x + global.TILE_SIZE; objX < endPosX; objX += global.TILE_SIZE){
            while(!scr_tileContains(layer, objX, objY, badArgList)){
                print("robot downright pull&push: x, y: " + string(objX) + ", " + string(objY));
                if (map_place(layer, obj_mirptr, objX, objY)){
                    mp = map_place(layer, obj_mirptr, objX, objY);
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
            if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
            
            if (!map_place(layer, par_robot, objX, objY)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }        
        }
        if (robot.y > y && robot.x < x){ //player is below the obj and to the left; pull object downleft
            var objX = x-global.TILE_SIZE; var objY = y+ global.TILE_SIZE;
            //for (objX = x - global.TILE_SIZE; objX > endPosX; objX -= global.TILE_SIZE){
            while(!scr_tileContains(layer, objX, objY, badArgList)){
                print("robot downleft pull&push: x, y: " + string(objX) + ", " + string(objY));
                if (map_place(layer, obj_mirptr, objX, objY)){
                    mp = map_place(layer, obj_mirptr, objX, objY);
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
            if (map_place(layer, par_robot, objX, objY) == robot){ return true; }
            
            if (!map_place(layer, par_robot, objX, objY)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }  
        }   
    }
}

if (map_place(layer, x, y, obj_triggerDoor) && !map_place(layer, obj_wall, posX, posY)){
    if (isActivated(map_place(layer, obj_triggerDoor, objX, objY))){
        print("scr_canPullPush: obj trapped above");
        return false; //can't move if above    
    }
}

if (map_place(layer, par_pullable, posX, posY)){
    return false;
}

if (map_place(layer, par_fallingPlatform, posX, posY)){
    var fallingPlat = map_place(layer, par_fallingPlatform, posX, posY);
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

if (map_place(layer, obj_triggerDoor, posX, posY)){
    //print("There's a triggerDoor here.");
    var triggerDoor = map_place(layer, obj_triggerDoor, posX, posY);
    if (triggerDoor.isDeactivated) return true;
    return false;
}

if(map_place(layer, par_obstacle, posX, posY)){
    var obs = map_place(layer, par_obstacle, posX, posY);
    if (isActivated(obs)) {
        print("scr_canPullPush: Oh no an obstacle is here and it's activated !!!");
        return false;    
    }
}

if (!map_place(layer, par_platform, posX, posY)){
    print("scr_canPullPush: No platform to push/pull to");
    return false;
}


return true;
