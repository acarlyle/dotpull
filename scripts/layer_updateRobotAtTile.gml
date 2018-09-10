///layer_updateRobotAtTile(obj_layer layer, var oldPosX, var oldPosY)

//!!! DEPRECIATED

var layer = argument0;
var oldObjX = argument1;
var oldObjY = argument2;

var robot = layer.robot;

var thisTile = layer.roomMapArr[oldObjY / global.TILE_SIZE, oldObjX / global.TILE_SIZE];
var tileObjs = scr_split(thisTile, ";"); //arr of every obj in this tile
for (var objAt = 0; objAt < array_length_1d(tileObjs); objAt++){ //find matching obj at tile position and remove it
    if(strcontains(tileObjs[objAt], object_get_name(robot))){
    
        // Remove obj from its old position
        layer.roomMapArr[oldObjY / global.TILE_SIZE, oldObjX / global.TILE_SIZE] = 
            trim(string_replace(layer.roomMapArr[oldObjY / global.TILE_SIZE, oldObjX / global.TILE_SIZE], 
            tileObjs[objAt], 
            ""));
                       
        // Add obj to its new position
        layer.roomMapArr[robot[| OBJECT.Y] / global.TILE_SIZE, robot[| OBJECT.X] / global.TILE_SIZE] =
            string_insert(tileObjs[objAt],
            layer.roomMapArr[robot[| OBJECT.Y] / global.TILE_SIZE, robot[| OBJECT.X] / global.TILE_SIZE],
            strlen(layer.roomMapArr[robot[| OBJECT.Y] / global.TILE_SIZE, robot[| OBJECT.X] / global.TILE_SIZE]) + 1)
            + ";";
        
        break;
    } 
}
