///undo_fallingPlatform(par_fallingPlatform fallingPlatform)

/*
    Handles undo for this fallingPlatform obj
*/

breakableWall = argument0;
print("Undoing breakableWall 1: " + string(breakableWall.hitsLeft));

var breakableWallStr = ds_stack_pop(breakableWall.stateHistory);
print(breakableWallStr); 
if (breakableWallStr != undefined){
    print ("UNDOING breakable wall");
    if ((breakableWall.hitsLeft < breakableWallStr)){
        breakableWall.hitsLeft++;
        breakableWall.image_index--;
        if (breakableWall.hitsLeft != 0){
            breakableWall.isDeactivated = false;
        }
    }
    else if ((breakableWallStr < breakableWall.hitsLeft)){
        breakableWall.hitsLeft--;
        breakableWall.image_index++;
        if (breakableWall.hitsLeft != 0){
            breakableWall.isDeactivated = false;
        }
    }
}
print("Undoing breakableWall 2: " + string(breakableWall.hitsLeft));
