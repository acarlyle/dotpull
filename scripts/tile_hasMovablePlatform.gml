///tile_hasMovablePlatform(var posX, var posY)

var posX = argument0;
var posY = argument1;

if (instance_place(posX, posY, par_platform)){
    var platform = instance_place(posX, posY, par_platform);
    if (platform.numSteps > 0){
        return true;
    }
}

return false;
