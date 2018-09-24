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
var xDiff = robot[| OBJECT.X] - posX;
var yDiff = robot[| OBJECT.Y] - posY;

if (diagonalMovement) print("scr_canPullPush diag checking");

badArgList = array(par_robot, par_obstacle);

//if there's a mirptr in the path of the object, reset object position back to where it should be
// +/- diff to spot to pull to
/*if (mirptr){
    if (object[| OBJECT.X] == mirptr[| OBJECT.X]){
        mirptrVt = true;
    }
    if (object[| OBJECT.Y] == mirptr[| OBJECT.Y]){ 
        mirptrHz = true;
    }
    posX = object[| OBJECT.X] + (posX - mirptr[| OBJECT.X]);
    posY = object[| OBJECT.Y] + (posY - mirptr[| OBJECT.Y]);
    xDiff = robot[| OBJECT.OLDPOSX] - posX;
    yDiff = robot[| OBJECT.OLDPOSY] - posY; 
    if (xDiff == 0 && yDiff == 0){
        xDiff = robot[| OBJECT.X] - posX;
        yDiff = robot[| OBJECT.Y] - posY;
    }
}*/

print("scr_canPullPush UPDATED posX, posY: " + string(posX) + ", " + string(posY));
print("scr_canPullPush isActive: " + string(object[| OBJECT.ISACTIVE]));


if (!(object[| OBJECT.CANPULL] || object[| OBJECT.CANPUSH])) return false;
if (!object[| OBJECT.ISACTIVE]) return false; //if it's not pullable, return

//Handle state change from active, targetLocked spike
if (object[| OBJECT.NAME] == "obj_spike"){
    if (object[| AI.TARGETLOCKED]){
        if (map_place(layer, par_fallingPlatform, posX, posY)){
            var fallingPlat = map_place(layer, par_fallingPlatform, posX, posY);
            if (!fallingPlat[| OBJECT.ISACTIVE]){
                print("Falling platform is deactivated; can't pull for spike");
                return false;
            }
        }
        if (map_place(layer, par_breakableWall, posX, posY)){
            breakableWall = map_place(layer, par_breakableWall, posX, posY);
            e_damageBreakableWall(breakableWall);
            if (!breakableWall[| OBJECT.ISACTIVE]){
                return true;
            }
        }
        if (map_place(layer, par_obstacle, posX, posY) &&
           !map_place(layer, obj_baby, posX, posY)){
            var obs = map_place(layer, par_obstacle, posX, posY);
            if (obs[| OBJECT.ISACTIVE]){
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

/*
    TODO
    
    This xDiff + yDiff logic doesn't apply when an object that can move into robots is right next to a
    robot.  E.G. -> a spike that is one tile to the right of Rob has an xDiff of zero (Rob.x - posToPullTo).
    Therefore, the logic results in the second else being checked after xDiff fails.  This isn't right because
    xDiff is zero regardless.  The logic doesn't catch this edge case.  The result of this bobo is fine
    but there might be a time when it's a problem.    
*/

if ((object[| OBJECT.CANPULL] ^^ object[| OBJECT.CANPUSH])){  //xor

   if (!scr_pathBetween(layer, robot, object)) return false;
   
}

if (map_place(layer, obj_triggerDoor, object[| OBJECT.X], object[| OBJECT.Y]) && !map_place(layer, obj_wall, posX, posY)){
    if (map_place(layer, obj_triggerDoor, objX, objY)){
        var triggerDoor = map_place(layer, obj_triggerDoor, objX, objY)
        if (triggerDoor[| OBJECT.ISACTIVE]){
            print("scr_canPullPush: obj trapped above");
            return false; //can't move if above
        }    
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
    if (!triggerDoor[| OBJECT.ISACTIVE]) return true;
    return false;
}

if(map_place(layer, par_obstacle, posX, posY)){
    var obs = map_place(layer, par_obstacle, posX, posY);
    if (obs[| OBJECT.ISACTIVE]) {
        print("scr_canPullPush: Oh no an obstacle is here and it's activated !!!");
        return false;    
    }
}

if (!map_place(layer, par_platform, posX, posY)){
    print("scr_canPullPush: No platform to push/pull to");
    return false;
}

return true;
