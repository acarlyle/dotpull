///con_layer(str roomName, ds_list sortedObjPriorityList)

var roomName = argument0;
var sortedObjPriorityList = argument1;

print(" -> con_layer of room " + string(roomName));

var layer = instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, obj_layer);
layer.roomName = roomName;
layer.roomMapArr = get_arrayOfRoom(layer.roomName);
layer.robot = obj_player;  //this is wrong, TODO.  it's hard because what if multiple robots..?

//print("ROBOT X: " + string(layer.robot.x));

//now set the layer's objPosToNameMap and associated mapKeyPriorityKey
con_priorityObjPosMap(layer, sortedObjPriorityList);


for (var i = 0; i < ds_list_size(layer.mapKeyPriorityList); i++){
    var mapKey = ds_list_find_value(layer.mapKeyPriorityList, i);
    var mapKeyArr = scr_split(mapKey, ":"); // "mapPos(int):x,y"
    var objPosAt = mapKeyArr[0]; // "mapPos(int)"
    var objPosStr = mapKeyArr[1]; // "x,y" -> functions as the key for the priorityMap 
    var objectString = ds_map_find_value(layer.objPosToNameMap, objPosStr);
    //we can have multiple objects stored at each position in the map, so split them
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
    }
    ds_list_add(layer.list_objEnums, objEnum);
    ds_map_add(layer.objNameAndPosToEnumMap, string(objectString) + ":" + string(objPosX) + "," + string(objPosY), objEnum);
}



return layer;
