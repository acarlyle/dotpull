///move_pullPushables_tile_one(obj_layer thisLayer, enum objectEnum, obj_mirptr mirptrExt, bool mirptrHz, bool mirptrVt, var pushPull)

var thisLayer = argument0;
var object = argument1;
var mirptrExt = argument2;
var mirptrHz = argument3;
var mirptrVt = argument4;
var pushPull = argument5;

var robot = thisLayer.robot; //TODO hardcoded to be obj_player

print("-> move_pullPushables_tile_one: " + string(object[| OBJECT.NAME]));

//print("move_pullPushables_tile_one object[| OBJECT.X]/Y: " + string(object[| OBJECT.X]) + ", " + string(object[| OBJECT.Y]));

print("Old Player Y: " + string(robot.oldPlayerY));

print("BLOCK: " + string(object[| OBJECT.X]) + "," + string(object[| OBJECT.Y]));

//figure out which way to push/pull
if (object[| OBJECT.CANPUSH] && object[| OBJECT.CANPULL]){
    if (robot.y - robot.oldPlayerY > 0){ //player moved down
        if (object[| OBJECT.Y] > robot.y) pushPull *=-1;
    }
    if (robot.x - robot.oldPlayerX > 0){ //player moved right
        if (object[| OBJECT.X] > robot.x) pushPull *=-1;
    }
    if (robot.x - robot.oldPlayerX < 0){ //player moved left
        if (object[| OBJECT.X] < robot.x) pushPull *=-1;
    }
    if (robot.y - robot.oldPlayerY < 0){ //player moved up
        if (object[| OBJECT.Y] < robot.y) pushPull *=-1;
    }
}
//push only
else if (object[| OBJECT.CANPUSH]) pushPull *= -1;

if ((robot.oldPlayerY == object[| OBJECT.Y] && robot.y == object[| OBJECT.Y]) || (!mirptrVt && mirptrHz)){ //player moved left/right
    print("push/pull left/right");
    //print(x - (global.TILE_SIZE*pushPull));
    if (robot.x < object[| OBJECT.X] && scr_canPullPush(object[| OBJECT.X] - (global.TILE_SIZE*pushPull), object[| OBJECT.Y], false, object, robot, mirptrExt, thisLayer)) {//player on left side of object 
        print("move_pullPushables_tile_one: CAN push/pull left");
        object[| OBJECT.X] -= (global.TILE_SIZE*pushPull);
        object[| OBJECT.MOVEDDIR] = "left";
        object[| OBJECT.MOVED] = true;
        /*if (scr_mirptrTele(thisLayer, object, robot, pushPull)){
            object[| OBJECT.MOVEDDIR] = "left";
            object[| OBJECT.MOVED] = true;
        }
        else{
            print("BLOCK: " + string(object[| OBJECT.X]) + "," + string(object[| OBJECT.Y]));
            object[| OBJECT.X] += (global.TILE_SIZE*pushPull); 
            print("BLOCK: " + string(object[| OBJECT.X]) + "," + string(object[| OBJECT.Y]));   
        }*/
    }
    else if (robot.x > object[| OBJECT.X] && scr_canPullPush(object[| OBJECT.X] + (global.TILE_SIZE*pushPull), object[| OBJECT.Y], false, object, robot, mirptrExt, thisLayer)){//player on right side of object
        print("move_pullPushables_tile_one: CAN push/pull right");
        object[| OBJECT.X] += (global.TILE_SIZE*pushPull);
        object[| OBJECT.MOVEDDIR] = "right";
        object[| OBJECT.MOVED] = true;
        /*if (scr_mirptrTele(thisLayer, object, robot, pushPull)){
            object[| OBJECT.MOVEDDIR] = "right";
            object[| OBJECT.MOVED] = true;
        }
        else{
            object[| OBJECT.X] -= (global.TILE_SIZE*pushPull);    
        }*/
    }
}
print("OldplYaerX: " + string(robot.oldPlayerX) + "; Robot.x: " + string(robot.x) + "; object[| OBJECT.X]: " + string(object[| OBJECT.X]));
//puling up/down
if ((robot.oldPlayerX == object[| OBJECT.X] && robot.x == object[| OBJECT.X]) || (mirptrVt && !mirptrHz)){ //player moved up/down
    if (robot.y < object[| OBJECT.Y] && scr_canPullPush(object[| OBJECT.X], object[| OBJECT.Y] - (global.TILE_SIZE*pushPull), false, object, robot, mirptrExt, thisLayer)){ //player above object 
        print("move_pullPushables_tile_one: CAN push/pull up/down");
        object[| OBJECT.Y] -= (global.TILE_SIZE*pushPull);
        object[| OBJECT.MOVEDDIR] = "up";
        object[| OBJECT.MOVED] = true;
        /*if (scr_mirptrTele(thisLayer, object, robot, pushPull)){
            object[| OBJECT.MOVEDDIR] = "up";
            object[| OBJECT.MOVED] = true;
        }
        else{
            object[| OBJECT.Y] += (global.TILE_SIZE*pushPull);    
        }*/
    }
    else if (robot.y > object[| OBJECT.Y] && scr_canPullPush(object[| OBJECT.X], object[| OBJECT.Y] + (global.TILE_SIZE*pushPull), false, object, robot, mirptrExt, thisLayer)){//player below object 
        print("move_pullPushables_tile_one: CAN push/pull updown");
        object[| OBJECT.Y]  += (global.TILE_SIZE*pushPull);
        object[| OBJECT.MOVEDDIR] = "down";
        object[| OBJECT.MOVED] = true;
        /*if (scr_mirptrTele(thisLayer, object, robot, pushPull)){
            object[| OBJECT.MOVEDDIR] = "down";
            object[| OBJECT.MOVED] = true;
        }
        else{
            object[| OBJECT.Y] -= (global.TILE_SIZE*pushPull);
        }*/
    }
}

var objRelYPos = 1;
var objRelXPos = -1;
if (robot.y < object[| OBJECT.Y]) objRelYPos *= -1;
if (robot.x > object[| OBJECT.X]) objRelXPos *= -1;
//print(objRelXPos)
var xDiff = robot.x - robot.oldPlayerX;
var yDiff = robot.y - robot.oldPlayerY;
var newObjPosX = 0; 
var newObjPosY = 0;

if (object[| OBJECT.CANPULL] && object[| OBJECT.CANPUSH]){
    if (robot.y < object[| OBJECT.Y] && robot.x > object[| OBJECT.X]){ //player is above the obj and to the right
        //print("up and to the right");
        if (xDiff < 0) pushPull *= -1;
    }
    if (robot.y < object[| OBJECT.Y] && robot.x < object[| OBJECT.X]){ //player is above the obj and to the left
        if (xDiff > 0) pushPull *=-1;
    }
    if (robot.y > object[| OBJECT.Y] && robot.x > object[| OBJECT.X]){ //player is below the obj and to the right
        if (yDiff < 0) pushPull *=-1;
    }
    if (robot.y > object[| OBJECT.Y] && robot.x < object[| OBJECT.X]){ //player is below the obj and to the left
        if (yDiff < 0) pushPull *=-1;
    }
}
if (robot.y < object[| OBJECT.Y] && robot.x > object[| OBJECT.X]){ //player is above the obj and to the right
//print("up and to the right");
    newObjPosX = object[| OBJECT.X] + (global.TILE_SIZE * pushPull);
    newObjPosY = object[| OBJECT.Y] - (global.TILE_SIZE * pushPull);
}
if (robot.y < object[| OBJECT.Y] && robot.x < object[| OBJECT.X]){ //player is above the obj and to the left
    newObjPosX = object[| OBJECT.X] - (global.TILE_SIZE * pushPull);
    newObjPosY = object[| OBJECT.Y] - (global.TILE_SIZE * pushPull);
}
if (robot.y > object[| OBJECT.Y] && robot.x > object[| OBJECT.X]){ //player is below the obj and to the right
    newObjPosX = object[| OBJECT.X] + (global.TILE_SIZE * pushPull);
    newObjPosY = object[| OBJECT.Y] + (global.TILE_SIZE * pushPull);
}
if (robot.y > object[| OBJECT.Y] && robot.x < object[| OBJECT.X]){ //player is below the obj and to the left
    newObjPosX = object[| OBJECT.X] - (global.TILE_SIZE * pushPull);
    newObjPosY = object[| OBJECT.Y] + (global.TILE_SIZE * pushPull);
}
if (!object[| OBJECT.MOVED] 
    && (robot.x - robot.oldPlayerX != 0) 
    && (robot.y - robot.oldPlayerY != 0) 
    && scr_canPullPush(newObjPosX, newObjPosY, true, object, robot, mirptrExt, thisLayer)
    && abs((robot.y - object[| OBJECT.Y]) / (robot.x - object[| OBJECT.X])) == 1
    && abs((robot.oldPlayerY - object[| OBJECT.Y]) / (robot.oldPlayerX - object[| OBJECT.X])) == 1){
    
    if (robot.y < object[| OBJECT.Y] && robot.x > object[| OBJECT.X]){ //player is above the obj and to the right
        object[| OBJECT.X] += (global.TILE_SIZE * pushPull);
        object[| OBJECT.Y] -= (global.TILE_SIZE * pushPull);
        object[| OBJECT.MOVEDDIR] = "upright";
        object[| OBJECT.MOVED] = true;
    }
    if (robot.y < object[| OBJECT.Y] && robot.x < object[| OBJECT.X]){ //player is above the obj and to the left
        object[| OBJECT.X] -= (global.TILE_SIZE * pushPull);
        object[| OBJECT.Y] -= (global.TILE_SIZE * pushPull); 
        object[| OBJECT.MOVEDDIR] = "upleft";
        object[| OBJECT.MOVED] = true;
    }
    if (robot.y > object[| OBJECT.Y] && robot.x > object[| OBJECT.X]){ //player is below the obj and to the right
        object[| OBJECT.X] += (global.TILE_SIZE * pushPull);
        object[| OBJECT.Y] += (global.TILE_SIZE * pushPull); 
        object[| OBJECT.MOVEDDIR] = "downright";
        object[| OBJECT.MOVED] = true;
    }
    if (robot.y > object[| OBJECT.Y] && robot.x < object[| OBJECT.X]){ //player is below the obj and to the left
        object[| OBJECT.X] -= (global.TILE_SIZE * pushPull);
        object[| OBJECT.Y] += (global.TILE_SIZE * pushPull);
        object[| OBJECT.MOVEDDIR] = "downleft";
        object[| OBJECT.MOVED] = true;
    }
}
