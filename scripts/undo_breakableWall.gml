///undo_fallingPlatform(par_fallingPlatform fallingPlatform)

/*
    Handles undo for this fallingPlatform obj
*/

breakableWall = argument0;

var breakableWallStr = ds_stack_pop(breakableWall.stateHistory);
if (breakableWallStr != undefined){
    //print ("UNDOING breakable wall");
    if ((breakableWall.hitsLeft < breakableWallStr)){
        breakableWall.hitsLeft++;
        breakableWall.image_index--;
        if (breakableWall.hitsLeft != 0){
            breakableWall.isDeactivated = false;
        }
    }
}
