///undo_fallingPlatform(obj_enum fallingPlatform)

/*
    Handles undo for this fallingPlatform obj
*/

var fallingPlatform = argument0;

var fallingPlatformStr = ds_stack_pop(fallingPlatform[| OBJECT.STATEHISTORY]);
if (fallingPlatformStr != undefined)
{
    if ((fallingPlatform[| PLATFORM.STEPSLEFT] < fallingPlatformStr))
    {
        fallingPlatform[| PLATFORM.STEPSLEFT]++;
        fallingPlatform[| OBJECT.IMGIND]--;
        if (fallingPlatform[| PLATFORM.STEPSLEFT] != 0)
        {
            fallingPlatform[| OBJECT.ISACTIVE] = true;
        }
    }
}
