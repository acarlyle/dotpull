///move_pullPushables_tile_one(par_object object, par_robot robot, var objPosX, var objPosY, obj_mirptr mirptrExt, bool mirptrHz, bool mirptrVt, var pushPull)

var object = argument0;
var robot = argument1;
var objPosX = argument2;
var objPosY = argument3;
var mirptrExt = argument4;
var mirptrHz = argument5;
var mirptrVt = argument6;
var pushPull = argument7;

print("move_pullPushables_tile_one objPosX/Y: " + string(objPosX) + ", " + string(objPosY));

robot.objectMoved = false; 

//figure out which way to push/pull
if (canPush && canPull){
    if (robot.y - robot.oldPlayerY > 0){ //player moved down
        if (objPosY > robot.y) pushPull *=-1;
    }
    if (robot.x - robot.oldPlayerX > 0){ //player moved right
        if (objPosX > robot.x) pushPull *=-1;
    }
    if (robot.x - robot.oldPlayerX < 0){ //player moved left
        if (objPosX < robot.x) pushPull *=-1;
    }
    if (robot.y - robot.oldPlayerY < 0){ //player moved up
        if (objPosY < robot.y) pushPull *=-1;
    }
}
//push only
else if (canPush) pushPull *= -1;

if ((robot.oldPlayerY == objPosY && robot.y == objPosY) || (!mirptrVt && mirptrHz)){ //player moved left/right
    print("push/pull left/right");
    //print(x - (global.TILE_SIZE*pushPull));
    if (robot.x < objPosX && scr_canPullPush(objPosX - (global.TILE_SIZE*pushPull), objPosY, false, object, robot, mirptrExt)) {//player on left side of object 
        x -= (global.TILE_SIZE*pushPull);
        print("push/pull left");
        if (scr_mirptrTele(object, robot, pushPull, objPosX, objPosY)){
            print("Moved to: " + string(x) + " " + string(y));
            object.movedDir = "left";
            object.moved = true;
        }
        else{
            x += (global.TILE_SIZE*pushPull);    
        }
    }
    else if (robot.x > objPosX && scr_canPullPush(objPosX + (global.TILE_SIZE*pushPull), objPosY, false, object, robot, mirptrExt)){//player on right side of object
        x += (global.TILE_SIZE*pushPull);
        print("push/pull right");
        if (scr_mirptrTele(object, robot, pushPull, objPosX, objPosY)){
            print("Moved to: " + string(x) + " " + string(y));
            object.movedDir = "right";
            object.moved = true;
        }
        else{
            x -= (global.TILE_SIZE*pushPull);    
        }
    }
}
print("OldplYaerX: " + string(robot.oldPlayerX) + "; Robot.x: " + string(robot.x) + "; objPosX: " + string(objPosX));
if ((robot.oldPlayerX == objPosX && robot.x == objPosX) || (mirptrVt && !mirptrHz)){ //player moved up/down
    print("push/pull up/down");
    if (robot.y < objPosY && scr_canPullPush(objPosX, objPosY - (global.TILE_SIZE*pushPull), false, object, robot, mirptrExt)){ //player above object 
        y -= (global.TILE_SIZE*pushPull);
        if (scr_mirptrTele(object, robot, pushPull, objPosX, objPosY)){
            print("Moved to: " + string(x) + " " + string(y));
            object.movedDir = "up";
            object.moved = true;
        }
        else{
            y += (global.TILE_SIZE*pushPull);    
        }
    }
    else if (robot.y > objPosY && scr_canPullPush(objPosX, objPosY + (global.TILE_SIZE*pushPull), false, object, robot, mirptrExt)){//player below object 
        print("push/pull updown");
        y += (global.TILE_SIZE*pushPull);
        if (scr_mirptrTele(object, robot, pushPull, objPosX, objPosY)){
            print("Moved to: " + string(x) + " " + string(y));
            object.movedDir = "down";
            object.moved = true;
        }
        else{
            y -= (global.TILE_SIZE*pushPull);
        }
    }
}

var objRelYPos = 1;
var objRelXPos = -1;
if (robot.y < objPosY) objRelYPos *= -1;
if (robot.x > objPosX) objRelXPos *= -1;
//print(objRelXPos)
var xDiff = robot.x - robot.oldPlayerX;
var yDiff = robot.y - robot.oldPlayerY;
var newObjPosX = 0; 
var newObjPosY = 0;

if (canPull && canPush){
    if (robot.y < objPosY && robot.x > objPosX){ //player is above the obj and to the right
        //print("up and to the right");
        if (xDiff < 0) pushPull *= -1;
    }
    if (robot.y < objPosY && robot.x < objPosX){ //player is above the obj and to the left
        if (xDiff > 0) pushPull *=-1;
    }
    if (robot.y > objPosY && robot.x > objPosX){ //player is below the obj and to the right
        if (yDiff < 0) pushPull *=-1;
    }
    if (robot.y > objPosY && robot.x < objPosX){ //player is below the obj and to the left
        if (yDiff < 0) pushPull *=-1;
    }
}
if (robot.y < objPosY && robot.x > objPosX){ //player is above the obj and to the right
//print("up and to the right");
    newObjPosX = objPosX + (global.TILE_SIZE * pushPull);
    newObjPosY = objPosY - (global.TILE_SIZE * pushPull);
}
if (robot.y < objPosY && robot.x < objPosX){ //player is above the obj and to the left
    newObjPosX = objPosX - (global.TILE_SIZE * pushPull);
    newObjPosY = objPosY - (global.TILE_SIZE * pushPull);
}
if (robot.y > objPosY && robot.x > objPosX){ //player is below the obj and to the right
    newObjPosX = objPosX + (global.TILE_SIZE * pushPull);
    newObjPosY = objPosY + (global.TILE_SIZE * pushPull);
}
if (robot.y > objPosY && robot.x < objPosX){ //player is below the obj and to the left
    newObjPosX = objPosX - (global.TILE_SIZE * pushPull);
    newObjPosY = objPosY + (global.TILE_SIZE * pushPull);
}
if (!object.moved 
    && (robot.x - robot.oldPlayerX != 0) 
    && (robot.y - robot.oldPlayerY != 0) 
    && scr_canPullPush(newObjPosX, newObjPosY, true, object, robot, mirptrExt)
    && abs((robot.y - objPosY) / (robot.x - objPosX)) == 1
    && abs((robot.oldPlayerY - objPosY) / (robot.oldPlayerX - objPosX)) == 1){
    
    if (robot.y < objPosY && robot.x > objPosX){ //player is above the obj and to the right
        x += (global.TILE_SIZE * pushPull);
        y -= (global.TILE_SIZE * pushPull);
        object.movedDir = "upright";
        object.moved = true;
    }
    if (robot.y < objPosY && robot.x < objPosX){ //player is above the obj and to the left
        x -= (global.TILE_SIZE * pushPull);
        y -= (global.TILE_SIZE * pushPull); 
        object.movedDir = "upleft";
        object.moved = true;
    }
    if (robot.y > objPosY && robot.x > objPosX){ //player is below the obj and to the right
        x += (global.TILE_SIZE * pushPull);
        y += (global.TILE_SIZE * pushPull); 
        object.movedDir = "downright";
        object.moved = true;
    }
    if (robot.y > objPosY && robot.x < objPosX){ //player is below the obj and to the left
        x -= (global.TILE_SIZE * pushPull);
        y += (global.TILE_SIZE * pushPull);
        object.movedDir = "downleft";
        object.moved = true;
    }
}

