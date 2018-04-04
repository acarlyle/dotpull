///scr_platformIsWalkable(var posX, var posY)

/*
    Checks to make sure the platform isn't a fallen falling
    platform.
*/

var posX = argument0;
var posY = argument1;

if (instance_place(posX, posY, par_fallingPlatform)){
    var platform = instance_place(posX, posY, par_fallingPlatform);
    if (platform.numSteps == 0){
        return false;
    }
}
else if (!instance_place(posX, posY, par_platform)) return false;

return true;
