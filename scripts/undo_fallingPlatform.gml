///undo_fallingPlatform(par_fallingPlatform fallingPlatform)

/*
    Handles undo for this fallingPlatform obj
*/

fallingPlatform = argument0;

var fallingPlatformStr = ds_stack_pop(fallingPlatform.stateHistory);
if (fallingPlatform.fallingPlatformStr != undefined){
    //print ("UNDOING FALLING PLATFORM");
    if ((fallingPlatform.stepsLeft < fallingPlatform.fallingPlatformStr)){
        fallingPlatform.stepsLeft++;
        fallingPlatform.image_index--;
        if (fallingPlatform.stepsLeft != 0){
            fallingPlatform.isDeactivated = false;
        }
    }
}
