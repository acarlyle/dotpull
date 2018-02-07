///move_pullPushables(obj object, par_robot robot)

/*
    This function handles:
    obj_block
    obj_blockPush
    obj_blockPushPull
    obj_key
*/

object = argument0;
robot = argument1;

var objMove = false; 
var pushPull = 1;

//figure out which way to push/pull
if (canPush && canPull){
    if (robot.y - robot.oldPlayerY > 0){ //player moved down
        if (y > robot.y) pushPull *=-1;
    }
    if (robot.x - robot.oldPlayerX > 0){ //player moved right
        if (x > robot.x) pushPull *=-1;
    }
    if (robot.x - robot.oldPlayerX < 0){ //player moved left
        if (x < robot.x) pushPull *=-1;
    }
    if (robot.y - robot.oldPlayerY < 0){ //player moved up
        if (y < robot.y) pushPull *=-1;
    }
}
//push only
else if (canPush) pushPull *= -1;
if (robot.oldPlayerY == y && robot.y == y){ //player moved left/right
    print("push/pull left/right");
    //print(x - (global.TILE_SIZE*pushPull));
    if (robot.x < x && scr_canPullPush(x - (global.TILE_SIZE*pushPull), y, false, robot)) {//player on left side of object 
        x -= (global.TILE_SIZE*pushPull);
        objMove = true;
        print("Move is true left");
    }
    else if (robot.x > x && scr_canPullPush(x + (global.TILE_SIZE*pushPull), y, false, robot)){//player on right side of object
        x += (global.TILE_SIZE*pushPull);
        objMove = true;
        print("Move is true right");
    }
}
if (robot.oldPlayerX == x && robot.x == x){ //player moved up/down
    print("let's maybe pull this shit");
    if (robot.y < y && scr_canPullPush(x, y - (global.TILE_SIZE*pushPull), false, robot)){ //player above object 
        y -= (global.TILE_SIZE*pushPull);
        objMove = true;
        print("pulling");
    }
    else if (robot.y > y && scr_canPullPush(x, y + (global.TILE_SIZE*pushPull), false, robot)){//player below object 
        print("push/pull updown");
        y += (global.TILE_SIZE*pushPull);
        objMove = true;
    }
}
var objRelYPos = 1;
var objRelXPos = -1;
if (robot.y < y) objRelYPos *= -1;
if (robot.x > x) objRelXPos *= -1;
//print(objRelXPos)

var xDiff = robot.x - robot.oldPlayerX;
var yDiff = robot.y - robot.oldPlayerY;
var newObjPosX = 0; 
var newObjPosY = 0;

if (canPull && canPush){
    if (robot.y < y && robot.x > x){ //player is above the obj and to the right
        //print("up and to the right");
        if (xDiff < 0) pushPull *= -1;
    }
    if (robot.y < y && robot.x < x){ //player is above the obj and to the left
        if (xDiff > 0) pushPull *=-1;
    }
    if (robot.y > y && robot.x > x){ //player is below the obj and to the right
        if (yDiff < 0) pushPull *=-1;
    }
    if (robot.y > y && robot.x < x){ //player is below the obj and to the left
        if (yDiff < 0) pushPull *=-1;
    }
}

if (robot.y < y && robot.x > x){ //player is above the obj and to the right
//print("up and to the right");
    newObjPosX = x + (global.TILE_SIZE * pushPull);
    newObjPosY = y - (global.TILE_SIZE * pushPull);
}
if (robot.y < y && robot.x < x){ //player is above the obj and to the left
    newObjPosX = x - (global.TILE_SIZE * pushPull);
    newObjPosY = y - (global.TILE_SIZE * pushPull);
}
if (robot.y > y && robot.x > x){ //player is below the obj and to the right
    newObjPosX = x + (global.TILE_SIZE * pushPull);
    newObjPosY = y + (global.TILE_SIZE * pushPull);
}
if (robot.y > y && robot.x < x){ //player is below the obj and to the left
    newObjPosX = x - (global.TILE_SIZE * pushPull);
    newObjPosY = y + (global.TILE_SIZE * pushPull);
}

if (!objMove  
    && (robot.x - robot.oldPlayerX != 0) 
    && (robot.y - robot.oldPlayerY != 0) 
    && scr_canPullPush(newObjPosX, newObjPosY, true, robot)
    && abs((robot.y - y) / (robot.x - x)) == 1
    && abs((robot.oldPlayerY - y) / (robot.oldPlayerX - x)) == 1){
    
    if (robot.y < y && robot.x > x){ //player is above the obj and to the right
        x += (global.TILE_SIZE * pushPull);
        y -= (global.TILE_SIZE * pushPull);
    }
    if (robot.y < y && robot.x < x){ //player is above the obj and to the left
        x -= (global.TILE_SIZE * pushPull);
        y -= (global.TILE_SIZE * pushPull); 
    }
    if (robot.y > y && robot.x > x){ //player is below the obj and to the right
        x += (global.TILE_SIZE * pushPull);
        y += (global.TILE_SIZE * pushPull); 
    }
    if (robot.y > y && robot.x < x){ //player is below the obj and to the left
        x -= (global.TILE_SIZE * pushPull);
        y += (global.TILE_SIZE * pushPull);
    }
    objMove = true;
}

if (objMove){
    audio_play_sound(snd_blockDrag, 10, false);
}

/*if (!objMove && canFall && instance_place(x, y, obj_hole)){
    //print("and this object falls down");
    sprite_index = spr_key;
    isDeactivated = true;
    justDeactivated = true;
    deactivatedX = x;
    deactivatedY = y;
    ds_stack_push(moveHistory, string(x) + "," + string(y));
    x = 0;
    y = 0;
}
//else if (!instance_place(x, y, obj_hole) && canFall){
//    sprite_index = spr_key;
//    //print("no hole");
//}
else if(instance_place(x, y, obj_hole) && canFall){
    //print("HOLE");
    sprite_index = spr_keyFloating;
    image_speed = .3;
}*/
