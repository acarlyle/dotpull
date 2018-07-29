 ///move_pullPushables(obj_layer thisLayer, obj_spike spike, int spike_posX, int spike_posY)

/*
    This function handles:
    obj_block
    obj_blockPush
    obj_blockPushPull
    obj_key
    obj_magneticSnare
*/

thisLayer = argument0;
object = argument1;
object_posX = argument2;
object_posY = argument3;

var pushPull = 1;

var mirptrExt = false; // if a mirptr is in the objects push/pull path
var mirptrVt = false;
var mirptrHz = false;

object.moved = false; 
object.state = "tile_one";

//TODO -> Mirraporter logic w/ 2d array
/*with (obj_mirptr){
    
    var mirptr = self;
    var mirptrPtr = self.mirptrPtr;
    if ((mirptr.x == object.x && (robot.oldPlayerX == mirptrPtr.x || robot.x == mirptrPtr.x)) &&
        (robot.y - robot.oldPlayerY != 0)){ //checks to see if player actually moved up/down
        //print("NSYNC!!!! VT");
        object_posX = mirptrPtr.x;
        object_posY = mirptrPtr.y;
        //mirptrExt = true;
        mirptrExt = mirptr;
        mirptrVt = true;
    }
    if ((mirptr.y == object.y && (robot.oldPlayerY == mirptrPtr.y || robot.y == mirptrPtr.y)) &&
        (robot.x - robot.oldPlayerX != 0)){ //checks to see if player actually moved left/right
        //print("NSYNC!!!! HZ");
        object_posX = mirptrPtr.x;
        object_posY = mirptrPtr.y;
        //mirptrExt = true;
        mirptrExt = mirptr;
        mirptrHz = true;
    }
}*/

if (map_place(thisLayer, obj_slideTile, object_posX, object_posY)){
    object.state = "tile_slide";
}

switch(object.state){
    case "tile_one":
        move_pullPushables_tile_one(object, robot, object_posX, object_posY, mirptrExt, mirptrHz, mirptrVt, pushPull); //default one tile grid movement
        break;
    case "tile_slide":
        move_pullPushables_tile_slide(object, robot, object_posX, object_posY, mirptrExt, mirptrHz, mirptrVt, pushPull); //if an object is sliding (on ice or something)
        break;
}

if (object.moved){
    audio_play_sound(snd_blockDrag, 10, false);
}
