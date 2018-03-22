///scr_canPullPush(int objPosX, int objPosY, bool moveDiag, par_object object, par_robot robot, bool mirptrExt)

print("-> scr_canPullPush(" + string(argument0) + ", " + string(argument1) + ")");

var posX = argument0;
var posY = argument1;
var object = argument3;
var robot = argument4;
var mirptr = argument5;

var mirptrHz = false;
var mirptrVt = false;
var endPosX = robot.x;
var endPosY = robot.y;
var badArgList = array(par_robot, par_obstacle);

//if there's a mirptr in the path of the object
if (mirptr){
    if (object.x == mirptr.x){
        mirptrVt = true;
        endPosY = mirptr.y;
    }
    if (object.y == mirptr.y){ 
        mirptrHz = true;
        endPosX = mirptr.x;
    }
}


if (!(canPull || canPush)) return false;
if (isDeactivated) return false;

//Handle active angry spike charge
if (isSpike){
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
        if (instance_place(posX, posY, par_obstacle)){
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

/*if (instance_place(posX, posY, par_robot) && !isSpike){
    print("Can't move, player in the way");
    //print(string(posX)); print(string(posY)); print(string(obj_player.x)); print(string(obj_player.y));
    //print(string(global.oldPlayerX)); print(string(global.oldPlayerY));
    return false; //there's a player here!!  don't move!
}*/ 

//print("this far...");

var xDiff = robot.x - posX;
var yDiff = robot.y - posY;


/*if (mirptrVt){
    print("vt true");
    posX = mirptr.x; 
    posY = mirptr.y;
}
if (mirptrHz){
    posX = mirptr.x;
    posY = mirptr.y; 
    print("Hz true");
}*/

print("pull push: posX: " + string(posX) + " " + string(posY));

if (!argument2 && (canPull || canPush) && !(canPull && canPush)){ //this checks left/right only
    //print("do not print");

    if (yDiff == 0){ //player is moving left/right; check for objects towards the player
        if (xDiff > 0){ //player is to the right of the obj
            var objY = object.y;
            for (var objX = x + global.TILE_SIZE; objX < endPosX; objX += global.TILE_SIZE){
                print("player right: x, y: " + string(objX) + ", " + string(objY));
                if (instance_place(objX + global.TILE_SIZE, objY, obj_mirptr)){
                    objX += global.TILE_SIZE;
                    endPosX = robot.x;
                    mp = instance_place(objX, objY, obj_mirptr);
                    //objX -= global.TILE_SIZE;
                    objY = mp.mirptrPtr.y;
                    print("mp is a real boy; new objY: " + string(objY));
                }
                if (instance_place(objX, y, par_obstacle)){
                    var obs = instance_place(objX, y, par_obstacle);
                    if (isActivated(obs)){
                        return false; //don't pull if anything is in the way
                    }
                }
            }
            if (!instance_place(objX, objY, par_robot)){
                print("No ! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }
        }
        else{ //player is to the left of the obj
            var objY = object.y;
            for (var objX = x - global.TILE_SIZE; objX > endPosX; objX -= global.TILE_SIZE){
                print("player left: x, y: " + string(objX) + ", " + string(objY));
                if (instance_place(objX - global.TILE_SIZE, objY, obj_mirptr)){
                    objX -= global.TILE_SIZE;
                    endPosX = robot.x;
                    mp = instance_place(objX, objY, obj_mirptr);
                    //objX -= global.TILE_SIZE;
                    objY = mp.mirptrPtr.y;
                    print("mp is a real boy; new objY: " + string(objY));
                }
                if (instance_place(objX, y, par_obstacle)){
                    var obs = instance_place(objX, y, par_obstacle);
                    if (isActivated(obs) && !instance_place(objX, y, obj_snare)){
                        return false; //don't pull if anything is in the way
                    }
                }
            }
            if (!instance_place(objX, objY, par_robot)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }
        }
    }
    if (xDiff == 0){ //player is moving up/down; check for objects towards the player
        if (yDiff < 0){ //player is above the obj
            var objX = object.x;
            for (var objY = y - global.TILE_SIZE; (objY > endPosY) || (objY > robot.y); objY -= global.TILE_SIZE){
                print("player above: x, y: " + string(objX) + ", " + string(objY));
                if (instance_place(objX, objY, obj_mirptr)){
                    //objY -= global.TILE_SIZE;
                    endPosY = robot.y;
                    mp = instance_place(objX, objY, obj_mirptr);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    print("mp is a real boy; new objX: " + string(objY));
                }
                if (instance_place(objX, objY, par_obstacle)){
                    var obs = instance_place(x, objY, par_obstacle);
                    //print("isDeactived?");
                    if (isActivated(obs)){
                        return false; //don't pull if anything is in the way
                    }
                }
            }
            if (!instance_place(objX, objY, par_robot)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }
        }
        /*else{ //player is below the obj
            print("below object");
            var objX = object.x;
            //print("objY: " + string(objY));
            for (var objY = y + global.TILE_SIZE; (objY < endPosY) || (objY < robot.y); objY += global.TILE_SIZE){
                print("player below: x, y: " + string(objX) + ", " + string(objY));
                if (instance_place(objX, objY + global.TILE_SIZE, obj_mirptr)){
                    //objY += global.TILE_SIZE;
                    endPosY = robot.y;
                    mp = instance_place(objX, objY + global.TILE_SIZE, obj_mirptr);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    //objY += global.TILE_SIZE;
                    print("mp is a real boy; new objX, objY: " + string(objX) + "," + string(objY));
                }
                if (instance_place(objX, objY, par_obstacle)){
                    var obs = instance_place(objX, objY, par_obstacle);
                    //print("below object");
                    if (!obs.isDeactivated){
                        print("oh no it is activated");
                        return false; //don't pull if anything is in the way
                    }
                }
            }
            if (!instance_place(objX, objY, par_robot)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                print("Robot at: " + string(robot.x) + " " + string(robot.y));
                return false;
            }
        }*/
        print("below object");
        var objX = object.x;
        var objY = y + global.TILE_SIZE;
        //print("objY: " + string(objY));
        //for (var objY = y + global.TILE_SIZE; (objY < endPosY) || (objY < robot.y); objY += global.TILE_SIZE){
        while(!scr_tileContains(objX, objY, badArgList)){
            print("player below: x, y: " + string(objX) + ", " + string(objY));
            //var yakuza = "ya";
            //get_string(yakuza, yakuza);
            if (instance_place(objX, objY, obj_mirptr)){
                //objY += global.TILE_SIZE;
                endPosY = robot.y;
                mp = instance_place(objX, objY, obj_mirptr);
                objX = mp.mirptrPtr.x;
                objY = mp.mirptrPtr.y;
                //objY += global.TILE_SIZE;
                print("mp is a real boy; new objX, objY: " + string(objX) + "," + string(objY));
            }
            objY += global.TILE_SIZE;
        }
        if (!instance_place(objX, objY, par_robot)){
            print("No robot here! :(" + " " + string(objX) + " " + string(objY));
            print("Robot at: " + string(robot.x) + " " + string(robot.y));
            return false;
        }
    }
}

//diagonal movement
if (argument2 == true && (canPull || canPush) && !(canPull && canPush)){
    print("Diag checking in scr_canPull");
    if (robot.y < y && robot.x > x){ //player is above the obj and to the right; pull object upright
        //print("pull object up right");
        var objX = x+global.TILE_SIZE; var objY = y-global.TILE_SIZE;
        //print(objX);
        //print(objY);
        for (objX = x + global.TILE_SIZE; objX < endPosX; objX += global.TILE_SIZE){
            print("robot upright: x, y: " + string(objX) + ", " + string(objY));
            if (instance_place(objX + global.TILE_SIZE, objY - global.TILE_SIZE, obj_mirptr)){
                objX += global.TILE_SIZE
                objY -= global.TILE_SIZE;
                endPosX = robot.x;
                mp = instance_place(objX, objY, obj_mirptr);
                objX = mp.mirptrPtr.x;
                objY = mp.mirptrPtr.y;
                print("mp is a real boy; new objX: " + string(objX));
                print("mp is a real boy; new objY: " + string(objY));
            }  
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY -= global.TILE_SIZE;  
        }
        if (!instance_place(objX, objY, par_robot)){
            print("No robot here! :(" + " " + string(objX) + " " + string(objY));
            return false;
        }
    }
    if (robot.y < y && robot.x < x){ //player is above the obj and to the left; pull object upleft
        //print("pull object up left");
        var objX = x-global.TILE_SIZE; var objY = y-global.TILE_SIZE;
        //print(objX);
        //print(objY);
        for (objX = x - global.TILE_SIZE; objX > endPosX; objX -= global.TILE_SIZE){
            print("robot upleft: x, y: " + string(objX) + ", " + string(objY));
            if (instance_place(objX - global.TILE_SIZE, objY - global.TILE_SIZE, obj_mirptr)){
                objX -= global.TILE_SIZE
                objY -= global.TILE_SIZE;
                endPosX = robot.x;
                mp = instance_place(objX, objY, obj_mirptr);
                objX = mp.mirptrPtr.x;
                objY = mp.mirptrPtr.y;
                print("mp is a real boy; new objX: " + string(objX));
                print("mp is a real boy; new objY: " + string(objY));
            } 
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY -= global.TILE_SIZE;  
        }
        if (!instance_place(objX, objY, par_robot)){
            print("No robot here! :(" + " " + string(objX) + " " + string(objY));
            return false;
        }
    }
    if (robot.y > y && robot.x > x){ //player is below the obj and to the right; pull object downright
        //print("pull object down right");
        var objX = x + global.TILE_SIZE; var objY = y + global.TILE_SIZE;
        //print(objX);
        //print(objY);
        for (objX = x + global.TILE_SIZE; objX < endPosX; objX += global.TILE_SIZE){
            print("robot downright: x, y: " + string(objX) + ", " + string(objY));
            if (instance_place(objX + global.TILE_SIZE, objY + global.TILE_SIZE, obj_mirptr)){
                objX += global.TILE_SIZE
                objY += global.TILE_SIZE;
                endPosX = robot.x;
                mp = instance_place(objX, objY, obj_mirptr);
                objX = mp.mirptrPtr.x;
                objY = mp.mirptrPtr.y;
                print("mp is a real boy; new objX: " + string(objX));
                print("mp is a real boy; new objY: " + string(objY));
            } 
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY += global.TILE_SIZE;  
        }   
        if (!instance_place(objX, objY, par_robot)){
            print("No robot here! :(" + " " + string(objX) + " " + string(objY));
            return false;
        }       
    }
    if (robot.y > y && robot.x < x){ //player is below the obj and to the left; pull object downleft
        //print("pull object down left");
        var objX = x-global.TILE_SIZE; var objY = y+ global.TILE_SIZE;
        //print(objX);
        //print(objY);
        for (objX = x - global.TILE_SIZE; objX > endPosX; objX -= global.TILE_SIZE){
            print("robot downleft: x, y: " + string(objX) + ", " + string(objY));
            if (instance_place(objX - global.TILE_SIZE, objY + global.TILE_SIZE, obj_mirptr)){
                objX -= global.TILE_SIZE
                objY += global.TILE_SIZE;
                endPosX = robot.x;
                mp = instance_place(objX, objY, obj_mirptr);
                objX = mp.mirptrPtr.x;
                objY = mp.mirptrPtr.y;
                print("mp is a real boy; new objX: " + string(objX));
                print("mp is a real boy; new objY: " + string(objY));
            }   
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY += global.TILE_SIZE;  
        }
        if (!instance_place(objX, objY, par_robot)){
            print("No robot here! :(" + " " + string(objX) + " " + string(objY));
            return false;
        }    
    }   
}

if (canPull && canPush){
    print("obj can be pushed and pulled");
    
    var xDiff = robot.x - x;
    var yDiff = robot.y - y;
    
    if (!argument2){ //this checks left/right only
    
        if (yDiff == 0){ //player is moving left/right; check for objects towards the player
            if (xDiff > 0){ //player is to the right of the obj
                for (var objX = x + global.TILE_SIZE; objX < endPosX; objX += global.TILE_SIZE){
                    print("robot right pull&push: x, y: " + string(objX) + ", " + string(objY));
                    if (instance_place(objX + global.TILE_SIZE, objY, obj_mirptr)){
                        objX += global.TILE_SIZE
                        endPosX = robot.x;
                        mp = instance_place(objX, objY, obj_mirptr);
                        //objX = mp.mirptrPtr.x;
                        objY = mp.mirptrPtr.y;
                        print("mp is a real boy; new objX: " + string(objX));
                        print("mp is a real boy; new objY: " + string(objY));
                    } 
                    if (instance_place(objX, y, par_obstacle)){
                        var obs = instance_place(objX, y, par_obstacle);
                        if (isActivated(obs)){
                            return false; //don't pull if anything is in the way
                        }
                    }
                }
                if (!instance_place(objX, objY, par_robot)){
                    print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                    return false;
                }
                
            }
            else{ //player is to the left of the obj
                for (var objX = x - global.TILE_SIZE; objX > endPosX; objX -= global.TILE_SIZE){
                    print("robot left pull&push: x, y: " + string(objX) + ", " + string(objY));
                    if (instance_place(objX - global.TILE_SIZE, objY, obj_mirptr)){
                        objX -= global.TILE_SIZE
                        endPosX = robot.x;
                        mp = instance_place(objX, objY, obj_mirptr);
                        //objX = mp.mirptrPtr.x;
                        objY = mp.mirptrPtr.y;
                        print("mp is a real boy; new objX: " + string(objX));
                        print("mp is a real boy; new objY: " + string(objY));
                    } 
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
                if (!instance_place(objX, objY, par_robot)){
                    print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                    return false;
                }
            }
        }
        if (xDiff == 0){ //player is moving up/down; check for objects towards the player
            if (yDiff < 0){ //player is above the obj
                for (var objY = y - global.TILE_SIZE; objY > endPosY; objY -= global.TILE_SIZE){
                    print("robot above pull&push: x, y: " + string(objX) + ", " + string(objY));
                    if (instance_place(objX, objY - global.TILE_SIZE, obj_mirptr)){
                        objY -= global.TILE_SIZE
                        endPosY = robot.y;
                        mp = instance_place(objX, objY, obj_mirptr);
                        objX = mp.mirptrPtr.x;
                        //objY = mp.mirptrPtr.y;
                        print("mp is a real boy; new objX: " + string(objX));
                        print("mp is a real boy; new objY: " + string(objY));
                    } 
                    if (instance_place(x, objY, par_obstacle)){
                        var obs = instance_place(x, objY, par_obstacle);
                        //print("isDeactived?");
                        if (isActivated(obs)){
                            return false; //don't pull if anything is in the way
                        }
                    }
                }
                if (!instance_place(objX, objY, par_robot)){
                    print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                    return false;
                }
            }
            else{ //player is below the obj
                for (var objY = y + global.TILE_SIZE; objY < endPosY; objY += global.TILE_SIZE){
                    print("robot below pull&push: x, y: " + string(objX) + ", " + string(objY));
                    if (instance_place(objX, objY + global.TILE_SIZE, obj_mirptr)){
                        objY += global.TILE_SIZE
                        endPosY = robot.y;
                        mp = instance_place(objX, objY, obj_mirptr);
                        objX = mp.mirptrPtr.x;
                        //objY = mp.mirptrPtr.y;
                        print("mp is a real boy; new objX: " + string(objX));
                        print("mp is a real boy; new objY: " + string(objY));
                    } 
                    if (instance_place(x, objY, par_obstacle)){
                        var obs = instance_place(x, objY, par_obstacle);
                        //print(obs.isDeactivated);
                        if (!obs.isDeactivated){
                            print("oh no it is activated");
                            return false; //don't pull if anything is in the way
                        }
                    }
                }
                if (!instance_place(objX, objY, par_robot)){
                    print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                    return false;
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
            for (objX = x + global.TILE_SIZE; objX < endPosX; objX += global.TILE_SIZE){
                print("robot upright pull&push: x, y: " + string(objX) + ", " + string(objY));
                if (instance_place(objX + global.TILE_SIZE, objY - global.TILE_SIZE, obj_mirptr)){
                    objX += global.TILE_SIZE
                    objY -= global.TILE_SIZE;
                    endPosX = robot.x;
                    mp = instance_place(objX, objY, obj_mirptr);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    print("mp is a real boy; new objX: " + string(objX));
                    print("mp is a real boy; new objY: " + string(objY));
                }   
                if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
                objY -= global.TILE_SIZE;  
            }
            if (!instance_place(objX, objY, par_robot)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }
        }
        if (robot.y < y && robot.x < x){ //player is above the obj and to the left; pull object upleft
            //print("pull object up left");
            var objX = x-global.TILE_SIZE; var objY = y-global.TILE_SIZE;
            //print(objX);
            //print(objY);
            for (objX = x - global.TILE_SIZE; objX > endPosX; objX -= global.TILE_SIZE){
                print("robot upleft pull&push: x, y: " + string(objX) + ", " + string(objY));
                if (instance_place(objX - global.TILE_SIZE, objY - global.TILE_SIZE, obj_mirptr)){
                    objX -= global.TILE_SIZE
                    objY -= global.TILE_SIZE;
                    endPosX = robot.x;
                    mp = instance_place(objX, objY, obj_mirptr);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    print("mp is a real boy; new objX: " + string(objX));
                    print("mp is a real boy; new objY: " + string(objY));
                }    
                if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
                objY -= global.TILE_SIZE;  
            }
            if (!instance_place(objX, objY, par_robot)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }
        }
        if (robot.y > y && robot.x > x){ //player is below the obj and to the right; pull object downright
            //print("pull object down right");
            var objX = x + global.TILE_SIZE; var objY = y + global.TILE_SIZE;
            //print(objX);
            //print(objY);
            for (objX = x + global.TILE_SIZE; objX < endPosX; objX += global.TILE_SIZE){
                print("robot downright pull&push: x, y: " + string(objX) + ", " + string(objY));
                if (instance_place(objX + global.TILE_SIZE, objY + global.TILE_SIZE, obj_mirptr)){
                    objX += global.TILE_SIZE
                    objY += global.TILE_SIZE;
                    endPosX = robot.x;
                    mp = instance_place(objX, objY, obj_mirptr);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    print("mp is a real boy; new objX: " + string(objX));
                    print("mp is a real boy; new objY: " + string(objY));
                }    
                if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
                objY += global.TILE_SIZE;  
            }  
            if (!instance_place(objX, objY, par_robot)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }        
        }
        if (robot.y > y && robot.x < x){ //player is below the obj and to the left; pull object downleft
            //print("pull object down left");
            var objX = x-global.TILE_SIZE; var objY = y+ global.TILE_SIZE;
            //print(objX);
            //print(objY);
            for (objX = x - global.TILE_SIZE; objX > endPosX; objX -= global.TILE_SIZE){
                print("robot downleft pull&push: x, y: " + string(objX) + ", " + string(objY));
                if (instance_place(objX - global.TILE_SIZE, objY + global.TILE_SIZE, obj_mirptr)){
                    objX -= global.TILE_SIZE
                    objY += global.TILE_SIZE;
                    endPosX = robot.x;
                    mp = instance_place(objX, objY, obj_mirptr);
                    objX = mp.mirptrPtr.x;
                    objY = mp.mirptrPtr.y;
                    print("mp is a real boy; new objX: " + string(objX));
                    print("mp is a real boy; new objY: " + string(objY));
                }     
                if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
                objY += global.TILE_SIZE;  
            }  
            if (!instance_place(objX, objY, par_robot)){
                print("No robot here! :(" + " " + string(objX) + " " + string(objY));
                return false;
            }  
        }   
    }
}

if (instance_place(x, y, obj_triggerDoor) && !instance_place(posX, posY, obj_wall)){
    if (isActivated(instance_place(x, y, obj_triggerDoor))){
        print("obj trapped above");
        return false; //can't move if above    
    }
}
if (instance_place(posX, posY, obj_block) ||
    instance_place(posX, posY, obj_blockPush) ||
    instance_place(posX, posY, obj_blockPushPull)){
    //print("Block in the way!");
    return false;
}

if (instance_place(posX, posY, par_fallingPlatform)){
    var fallingPlat = instance_place(posX, posY, par_fallingPlatform);
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
        print("Oh no an obstacle is here and it's activated !!!");
        print("pls be a spike" + string(isSpike));
        return false;    
    }
}

if (!instance_place(posX, posY, par_platform)){
    print("No platform to push/pull to");
    return false;
}


return true;
