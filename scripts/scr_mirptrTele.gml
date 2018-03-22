///scr_mirptrTele(par_obj obj, par_robot robot)

var object = argument0;
var robot = argument1;
var pushPull = argument2; //whether to push or pull
var objPosX = argument3;
var objPosY = argument4;

var objMove = false;

print("-> scr_mirptrTele(" + string(objPosX) + ", " + string(objPosY) + ")");

//the obj moved onto a mirptr. 
//now obj should teleport to its mirptrPtr (already confirmed can push/pull past its mirptrPtr)
if (instance_place(object.x, object.y, obj_mirptr)){ 
    var mirptr = instance_place(object.x, object.y, obj_mirptr);
    if (robot.oldPlayerY == objPosY && robot.y == objPosY){ //player moved left/right
        object.x = mirptr.mirptrPtr.x;
        object.y = mirptr.mirptrPtr.y;
        if (robot.x < objPosX) {//player on left side of object 
            if (robot.x != object.x - (global.TILE_SIZE*pushPull)){ 
                x -= (global.TILE_SIZE*pushPull);
                objMove = true;
            }
            else{
                object.y = mirptr.y;
                return false;
            }
        }
        else if (robot.x > objPosX){//player on right side of object
            if (robot.x != object.x + (global.TILE_SIZE*pushPull)){ 
                x += (global.TILE_SIZE*pushPull);
                objMove = true;
            }
            else{
                object.y = mirptr.y;
                return false;
            }
        }
    }
    if (robot.oldPlayerX == objPosX && robot.x == objPosX){ //player moved up/down
        object.x = mirptr.mirptrPtr.x;
        object.y = mirptr.mirptrPtr.y;
        if (robot.y < objPosY){ //player above object
            if (robot.y != object.y - (global.TILE_SIZE*pushPull)){ 
                y -= (global.TILE_SIZE*pushPull);
                objMove = true;
            }
            else{
                object.x = mirptr.x;
                return false;
            }
        }
        else if (robot.y > objPosY){ //player below object 
            if (robot.y != object.y + (global.TILE_SIZE*pushPull)){
                y += (global.TILE_SIZE*pushPull);
                objMove = true;
            }
            else{
                object.x = mirptr.x;
                return false;
            }
        }
    }
    return true;
}
else return true;
