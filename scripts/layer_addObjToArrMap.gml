///layer_addObjToArrMap(obj_layer layer, obj_enum enum)

/*
    Remove the obj from the argument from this layer's arrayMap.  
*/

var layer = argument0;
var object = argument1;

var arrPosX = object[| OBJECT.X] / global.TILE_SIZE; 
var arrPosY = object[| OBJECT.Y] / global.TILE_SIZE; 

print("-> layer_addObjToArrMap(" + string(layer.roomName) + "," + string(object[| OBJECT.NAME]) + ")");

print(" -> layer_addObjToArrMap: Tilemap spot before:  " + string(layer.roomMapArr[arrPosY, arrPosX]));
    
/*
    Add obj to its new position.  If there's no object at that position, add it at str pos 0.  
    Otherwise, it will be added at pos strlen+1. [padding variable].
    If it's a tile position with no objects, set the string from the getgo.  
    Otherwise, use string_insert to append the object.
*/

if (layer.roomMapArr[arrPosY, arrPosX] == " ")
{
    layer.roomMapArr[arrPosY, arrPosX] =
        object[| OBJECT.NAME] + ";";
}
else
{
    layer.roomMapArr[arrPosY, arrPosX] =
        string_insert(object[| OBJECT.NAME],
        layer.roomMapArr[arrPosY, arrPosX],
        strlen(layer.roomMapArr[arrPosY, arrPosX]) + 1)
        + ";";
 
}   

print(" -> layer_addObjToArrMap: Tilemap spot now: " + string(layer.roomMapArr[arrPosY, arrPosX]));
