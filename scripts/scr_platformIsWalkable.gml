///scr_platformIsWalkable(obj_layer layer, var posX, var posY)

/*
    Checks to make sure the platform isn't a fallen falling
    platform.
*/

var layer = argument0;
var posX = argument1;
var posY = argument2;

if (map_place(layer, par_fallingPlatform, posX, posY))
{
    var platform = map_place(layer, par_fallingPlatform, posX, posY);
    if (platform[| PLATFORM.STEPSLEFT] == 0)
    {
        return false;
    }
}
else if (!map_place(layer, par_platform, posX, posY)) return false;

return true;
