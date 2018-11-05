///layer_removeObjFromArrMap(obj_layer layer, obj_enum enum)

/*
    Remove the obj from the argument from this layer's arrayMap.  
*/

var layer = argument0;
var objEnum = argument1;

var arrPosX = objEnum[| OBJECT.X] / global.TILE_SIZE; 
var arrPosY = objEnum[| OBJECT.Y] / global.TILE_SIZE; 

print("-> layer_removeObjFromArrMap(" + string(layer.roomName) + "," + string(objEnum[| OBJECT.NAME] + ")"));
print(" -> layer_removeObjFromArrMap: Spot bef: " + string(layer.roomMapArr[arrPosY, arrPosX]));

var thisTile = layer.roomMapArr[arrPosY, arrPosX];
var tileObjs = scr_split(thisTile, ";"); //arr of every obj in this tile
for (var objAt = 0; objAt < array_length_1d(tileObjs); objAt++){ //find matching obj at tile position and remove it
    if(strcontains(tileObjs[objAt], objEnum[| OBJECT.NAME])){
    
        // Remove obj from its old position
        layer.roomMapArr[arrPosY, arrPosX] = 
            string_replace(layer.roomMapArr[arrPosY, arrPosX], 
            tileObjs[objAt] + ";", 
            "");
            
        if (layer.roomMapArr[arrPosY, arrPosX] == "")
        {
            layer.roomMapArr[arrPosY, arrPosX] = " ";
        }
    } 
}

print(" -> layer_removeObjFromArrMap: Spot now: " + string(layer.roomMapArr[arrPosY, arrPosX]));
