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

ds_stack_push(fallingPlatform.stateHistory, fallingPlatform.stepsLeft);
if (robot.oldPlayerX == fallingPlatform.x && robot.oldPlayerY == fallingPlatform.y){
    fallingPlatform.stepsLeft--;
    image_index++;
    if (fallingPlatform.stepsLeft == 0){
        fallingPlatform.isDeactivated = true;
    }
}
