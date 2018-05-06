 ///move_pullPushables(obj object, par_robot robot)

/*
    This function handles:
    obj_block
    obj_blockPush
    obj_blockPushPull
    obj_key
    obj_magneticSnare
*/

var object = argument0;
var robot = argument1;

var pushPull = 1;

var objPosX = object.x;
var objPosY = object.y;

var mirptrExt = false; // if a mirptr is in the objects push/pull path
var mirptrVt = false;
var mirptrHz = false;

object.moved = false; 
object.state = "tile_one";

with (obj_mirptr){
    
    var mirptr = self;
    var mirptrPtr = self.mirptrPtr;
    if ((mirptr.x == object.x && (robot.oldPlayerX == mirptrPtr.x || robot.x == mirptrPtr.x)) &&
        (robot.y - robot.oldPlayerY != 0)){ //checks to see if player actually moved up/down
        //print("NSYNC!!!! VT");
        objPosX = mirptrPtr.x;
        objPosY = mirptrPtr.y;
        //mirptrExt = true;
        mirptrExt = mirptr;
        mirptrVt = true;
    }
    if ((mirptr.y == object.y && (robot.oldPlayerY == mirptrPtr.y || robot.y == mirptrPtr.y)) &&
        (robot.x - robot.oldPlayerX != 0)){ //checks to see if player actually moved left/right
        //print("NSYNC!!!! HZ");
        objPosX = mirptrPtr.x;
        objPosY = mirptrPtr.y;
        //mirptrExt = true;
        mirptrExt = mirptr;
        mirptrHz = true;
    }
}

if (instance_place(object.x, object.y, obj_slideTile)){
    object.state = "tile_slide";
}

switch(object.state){
    case "tile_one":
        move_pullPushables_tile_one(object, robot, objPosX, objPosY, mirptrExt, mirptrHz, mirptrVt, pushPull); //default one tile grid movement
        break;
    case "tile_slide":
        move_pullPushables_tile_slide(object, robot, objPosX, objPosY, mirptrExt, mirptrHz, mirptrVt, pushPull); //if an object is sliding (on ice or something)
        break;
}

if (object.moved){
    audio_play_sound(snd_blockDrag, 10, false);
}
