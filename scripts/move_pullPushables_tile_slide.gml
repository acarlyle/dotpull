///move_pullPushables_tile_slide(par_object object, par_robot robot, var objPosX, var objPosY, obj_mirptr mirptrExt, bool mirptrHz, bool mirptrVt, var pushPull)

var object = argument0;
var robot = argument1;
var objPosX = argument2;
var objPosY = argument3;
var mirptrExt = argument4;
var mirptrHz = argument5;
var mirptrVt = argument6;
var pushPull = argument7;

var newObjPosX, newObjPosY;

print("move_pullPushables_tile_slide objPosX/Y: " + string(objPosX) + ", " + string(objPosY));

if ((object.movedDir == "left") && 
    (scr_tileIsOpen(objPosX - (global.TILE_SIZE*pushPull), objPosY, object))){ 
    object.movedDir = "left";
    object.moved = true;
    object.x = objPosX - (global.TILE_SIZE*pushPull);
    //print("mv'd left");
}
if ((object.movedDir == "right") && 
    scr_tileIsOpen(objPosX + (global.TILE_SIZE*pushPull), objPosY, object)){
    object.movedDir = "right";
    object.moved = true;
    object.x = objPosX + (global.TILE_SIZE*pushPull);
    //print("mv'd right");
}
if ((object.movedDir == "up") && 
    scr_tileIsOpen(objPosX, objPosY - (global.TILE_SIZE*pushPull), object)){
    object.movedDir = "up";
    object.moved = true;
    object.y = objPosY - (global.TILE_SIZE*pushPull);
    //print("mv'd up");
}
if ((object.movedDir == "down") && 
    scr_tileIsOpen(objPosX, objPosY + (global.TILE_SIZE*pushPull), object)){
    object.movedDir = "down";
    object.moved = true;
    object.y = objPosY + (global.TILE_SIZE*pushPull);
    //print("mv'd down");
}

//diag checking
if (!object.moved){
    switch(object.movedDir){
        case "upleft":
            newObjPosX = objPosX - (global.TILE_SIZE * pushPull);
            newObjPosY = objPosY - (global.TILE_SIZE * pushPull);
            break;
        case "upright":
            newObjPosX = objPosX + (global.TILE_SIZE * pushPull);
            newObjPosY = objPosY - (global.TILE_SIZE * pushPull);
            break;
        case "downleft":
            newObjPosX = objPosX - (global.TILE_SIZE * pushPull);
            newObjPosY = objPosY + (global.TILE_SIZE * pushPull);
            break;
        case "downright":
            newObjPosX = objPosX + (global.TILE_SIZE * pushPull);
            newObjPosY = objPosY + (global.TILE_SIZE * pushPull);
            break;
    }
    if (scr_tileIsOpen(newObjPosX, newObjPosY, object)){
        
        if ((object.movedDir == "upleft") ){
            object.movedDir = "upleft";
        }
        if ((object.movedDir == "upright") ){
            object.movedDir = "upright";
        }
        if ((object.movedDir == "downleft") ){
            object.movedDir = "downleft";
        }
        if ((object.movedDir == "downright") ){
            object.movedDir = "downright";
        }
        object.moved = true;
        object.x = newObjPosX;
        object.y = newObjPosY;
    }
}
