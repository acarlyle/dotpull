///map_place(obj_layer thisLayer, par_object object, int posX, int posY)

/*
    Functions as GameMaker's instance_place, but for the virtual 2D array of this 
    room's map.
*/

thisLayer = argument0;
object = argument1;
posX = argument2;
posY = argument3;

if (string_count(asset_get_index(object), 
                 thisLayer.roomMapArr[(real(posY))/global.TILE_SIZE, (real(posX))/global.TILE_SIZE])) return true;
