///scr_tileIsOpen(obj_layer layer, int posX, int posY)

var layer = argument0;
var posX = argument1;
var posY = argument2;

if (scr_tileContains(layer, posX, posY, array(par_obstacle)))
{
    var obstacle = map_place(layer, par_obstacle, posX, posY);
    if (!obstacle.isDeactivated) return false; //obstacle will block your path
}

if (map_place(layer, par_platform, posX, posY))
{
    var platform = map_place(layer, par_platform, posX, posY);
    /*if (platform.isFallingPlatform)
    {
        if (platform.stepsLeft <= 0)
        {
            return false; //obj can't move, the platform has fallen and the city is lost
        }
    }*/
    return true;
}

return false;
