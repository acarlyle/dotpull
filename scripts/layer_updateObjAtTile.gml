///layer_updateObjAtTile(obj_layer layer, objEnum object, var oldObjX, var oldObjY)

/*
    Script is designed to work with removing an obj's old position in the RoomMap Array and 
    adding that obj to its new spot in the room Map Arr.
*/

var layer = argument0;
var object = argument1;
var oldObjX = real(argument2);
var oldObjY = real(argument3);

print("-> layer_updateObjectAtTile " + string(object[| OBJECT.NAME]) + ":oldPosX: " + string(oldObjX) + ", oldPosY: " + string(oldObjY));

//print("Old Old Spot: " + string(layer.roomMapArr[oldObjY / global.TILE_SIZE, oldObjX / global.TILE_SIZE]));

var thisTile = layer.roomMapArr[oldObjY / global.TILE_SIZE, oldObjX / global.TILE_SIZE];
var tileObjs = scr_split(thisTile, ";"); //arr of every obj in this tile
for (var objAt = 0; objAt < array_length_1d(tileObjs); objAt++){ //find matching obj at tile position and remove it
    if(strcontains(tileObjs[objAt], object[| OBJECT.NAME])){
    
        //print("tileAt: " + string(tileObjs[objAt]));
    
        // Remove obj from its old position
        layer.roomMapArr[oldObjY / global.TILE_SIZE, oldObjX / global.TILE_SIZE] = 
            string_replace(layer.roomMapArr[oldObjY / global.TILE_SIZE, oldObjX / global.TILE_SIZE], 
            tileObjs[objAt] + ";", 
            "");
            
        if (layer.roomMapArr[oldObjY / global.TILE_SIZE, oldObjX / global.TILE_SIZE] == "")
        {
            layer.roomMapArr[oldObjY / global.TILE_SIZE, oldObjX / global.TILE_SIZE] = " ";
        }
                       
        // Add obj to its new position.  If there's no object at that position, add it at str pos 0.  Otherwise, it will be added at pos strlen+1. [padding variable]
        //print("-> ????????????????????? layer_updateObjectAtTile: pre New Spot STRLEN:" + string(strlen(string(layer.roomMapArr[object[| OBJECT.Y] / global.TILE_SIZE, object[| OBJECT.X] / global.TILE_SIZE]))));
        
        /*
            If it's a tile position with no objects, set the string from the getgo.  Otherwise, use string_insert to append the object.
        */
        
        if (layer.roomMapArr[object[| OBJECT.Y] / global.TILE_SIZE, object[| OBJECT.X] / global.TILE_SIZE] == " ")
        {
            layer.roomMapArr[object[| OBJECT.Y] / global.TILE_SIZE, object[| OBJECT.X] / global.TILE_SIZE] =
                tileObjs[objAt] + ";";
        }
        else
        {
        layer.roomMapArr[object[| OBJECT.Y] / global.TILE_SIZE, object[| OBJECT.X] / global.TILE_SIZE] =
            string_insert(tileObjs[objAt],
            layer.roomMapArr[object[| OBJECT.Y] / global.TILE_SIZE, object[| OBJECT.X] / global.TILE_SIZE],
            strlen(layer.roomMapArr[object[| OBJECT.Y] / global.TILE_SIZE, object[| OBJECT.X] / global.TILE_SIZE]) + 1)
            + ";";
         
        }   
        //print(" -> layer_updateObjectAtTile: Updated Old Spot: " + string(layer.roomMapArr[oldObjY / global.TILE_SIZE, oldObjX / global.TILE_SIZE]));
        //print(" -> layer_updateObjectAtTile: Updated New Spot:" + string(layer.roomMapArr[object[| OBJECT.Y] / global.TILE_SIZE, object[| OBJECT.X] / global.TILE_SIZE]));
        //print("-> ????????????????????? layer_updateObjectAtTile: Updated New Spot STRLEN:" + string(strlen(string(layer.roomMapArr[object[| OBJECT.Y] / global.TILE_SIZE, object[| OBJECT.X] / global.TILE_SIZE]))));
        
        break;
    } 
}
