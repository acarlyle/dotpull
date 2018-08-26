///scr_tileIsOpen(int posX, int posY)

var posX = argument0;
var posY = argument1;

if (scr_tileContains(layer, posX, posY, array(par_obstacle))){
    var obstacle = instance_place(argument0, argument1, par_obstacle);
    if (!obstacle.isDeactivated) return false; //obstacle will block your path
}

if (instance_place(argument0, argument1, par_platform)){
    var platform = instance_place(argument0, argument1, par_platform);
    if (platform.isFallingPlatform){
        if (platform.stepsLeft <= 0){
            return false; //obj can't move, the platform has fallen and the city is lost
        }
    }
    return true;
}

return false;
