///move_fallingPlatform(obj_layer layer, par_fallingPlatform fallingPlatform)

/*
    This function handles:
        obj_fallingPlatform_1Step
        obj_fallingPlatform_2Step
        obj_fallingPlatform_3Step
*/

var layer = argument0;
var fallingPlatform = argument1;

var robot = layer.robot;

//ds_stack_push(fallingPlatform.stateHistory, fallingPlatform.stepsLeft);
if (robot[| OBJECT.OLDPOSX] == fallingPlatform[| OBJECT.X] && robot[| OBJECT.OLDPOSY] == fallingPlatform[| OBJECT.Y]){
    fallingPlatform[| PLATFORM.STEPSLEFT] -= 1;
    fallingPlatform[| OBJECT.IMGIND] += 1;
    if (fallingPlatform[| PLATFORM.STEPSLEFT] == 0){
        fallingPlatform[| OBJECT.ISACTIVE] = false;
    }
}
