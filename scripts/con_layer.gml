///con_layer(str roomName, ds_list sortedObjPriorityList)

var roomName = argument0;
var sortedObjPriorityList = argument1;

print(" -> con_layer of room " + string(roomName));

var layer = instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, obj_layer);

layer.roomName = roomName;
layer.roomMapArr = get_arrayOfRoom(layer.roomName);
layer.yBound = array_height_2d(layer.roomMapArr) * global.TILE_SIZE; 
layer.xBound = array_length_2d(layer.roomMapArr, 0) * global.TILE_SIZE; 

var plat = map_place(layer, obj_fallingPlatform_3Step, 64, 16);
print(plat[| OBJECT.NAME]);

print("con_layer I: room map height: " + string(array_height_2d(layer.roomMapArr)));
print("con_layer I: room map length: " + string(array_length_2d(layer.roomMapArr, 0)));

//print("con_layer: #####");
//print("con_layer: " + layer.roomMapArr[64/16, 16/16]);

//TODO Need actual parser to determine robots in this layer and not just hardcode player
layer.list_robots = ds_list_create();
if (layer.list_robots)
    ds_list_add(layer.list_robots, con_objectEnum("obj_player", obj_player.x, obj_player.y));

//now set the layer's objPosToNameMap and associated mapKeyPriorityKey
con_priorityObjPosMap(layer, sortedObjPriorityList);

print("con_layer: mapKeyPriorityList size: " + string(ds_list_size(layer.mapKeyPriorityList)));

for (var i = 0; i < ds_list_size(layer.mapKeyPriorityList); i++){
    var mapKey = ds_list_find_value(layer.mapKeyPriorityList, i);
    //print("con_layer: map key: " + string(mapKey) + "at for loop index " + string(i));
    var mapKeyArr = scr_split(mapKey, ":"); // "mapPos(int):x,y"
    var objPosAt = mapKeyArr[0]; // "mapPos(int)"
    var objPosStr = mapKeyArr[1]; // "x,y" -> functions as the key for the priorityMap 
    //print("con_layer: objPosStr: " + string(objPosStr));
    var objectString = ds_map_find_value(layer.objPosToNameMap, objPosStr);
    //we can have multiple objects stored at each position in the map, so split them
    
    //print("con_layer: objectString: " + string(objectString));
    
    var objectArr = scr_split(objectString, ";");
    var objectString = objectArr[objPosAt]; //we want the ith item at this index....
    var object = get_objectFromString(objectString);
    
    var objPosStrArr = scr_split(objPosStr, ",");
    
    var objPosX = objPosStrArr[0];
    var objPosY = objPosStrArr[1];
    
    objEnum = con_objectEnum(objectString, objPosX, objPosY);
    if (!layer.list_objEnums){ //shouldn't have this logic every loop TODO
        layer.list_objEnums = ds_list_create();
    }
    if (!layer.objNameAndPosToEnumMap){ 
        layer.objNameAndPosToEnumMap = ds_map_create();
        //print("con_layer: CREATED objNameAndPosToEnumMap");
    }
    ds_list_add(layer.list_objEnums, objEnum);
    ds_map_add(layer.objNameAndPosToEnumMap, string(objectString) + ":" + string(objPosX) + "," + string(objPosY), objEnum);
}

// Map the roomname to the layer (obj_control map)
ds_map_add(global.layerMap, layer.roomName, layer);

//con surface of this layer


var alphaVal = 1; //halved each lower surface (for drawing the surface to the screen)
layer.surfaceInf = con_surface(surf_layerRoom, layer, 0, 0, 1, 1, 0, c_white, alphaVal);

print("con_layer: Finished constructing obj_layer!");

return layer;
