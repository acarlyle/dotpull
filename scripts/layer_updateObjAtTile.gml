///layer_updateObjAtTile(obj_layer layer, objEnum object, var oldObjX, var oldObjY)

var layer = argument0;
var object = argument1;
var oldObjX = argument2;
var oldObjY = argument3;

var thisTile = layer.roomMapArr[oldObjY / global.TILE_SIZE, oldObjX / global.TILE_SIZE];
var tileObjs = scr_split(thisTile, ";"); //arr of every obj in this tile
for (var objAt = 0; objAt < array_length_1d(tileObjs); objAt++){ //find matching obj at tile position and remove it
    if(strcontains(tileObjs[objAt], object[| OBJECT.NAME])){
    
        // Remove obj from its old position
        layer.roomMapArr[oldObjY / global.TILE_SIZE, oldObjX / global.TILE_SIZE] = 
            trim(string_replace(layer.roomMapArr[oldObjY / global.TILE_SIZE, oldObjX / global.TILE_SIZE], 
            tileObjs[objAt], 
            ""));
                       
        // Add obj to its new position
        layer.roomMapArr[object[| OBJECT.Y] / global.TILE_SIZE, object[| OBJECT.X] / global.TILE_SIZE] =
            string_insert(tileObjs[objAt],
            layer.roomMapArr[object[| OBJECT.Y] / global.TILE_SIZE, object[| OBJECT.X] / global.TILE_SIZE],
            strlen(layer.roomMapArr[object[| OBJECT.Y] / global.TILE_SIZE, object[| OBJECT.X] / global.TILE_SIZE]) + 1)
            + ";";
        
        break;
    } 
}
