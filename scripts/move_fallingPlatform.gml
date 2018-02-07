///move_fallingPlatform(par_fallingPlatform fallingPlatform, par_robot robot)

/*
    This function handles:
        obj_fallingPlatform_1Step
        obj_fallingPlatform_2Step
        obj_fallingPlatform_3Step
*/

fallingPlatform = argument0;
robot = argument1;

ds_stack_push(fallingPlatform.stateHistory, fallingPlatform.stepsLeft);
if (robot.oldPlayerX == fallingPlatform.x && robot.oldPlayerY == fallingPlatform.y){
    fallingPlatform.stepsLeft--;
    image_index++;
    if (fallingPlatform.stepsLeft == 0){
        fallingPlatform.isDeactivated = true;
    }
}
