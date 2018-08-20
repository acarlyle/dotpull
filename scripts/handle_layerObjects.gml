///handle_layerObjects(par_robot robot, obj_layer layer);

var robot = argument0;
var thisLayer = argument1;

print("");
print("handle_layerObjects");

handle_cleanUpElementEffects();

for (var i = 0; i < ds_list_size(thisLayer.mapKeyPriorityList); i++){
    var mapKey = ds_list_find_value(thisLayer.mapKeyPriorityList, i);
    var mapKeyArr = scr_split(mapKey, ":"); // str looks like "mapPos(int):x,y"
    var objPosAt = mapKeyArr[0]; // "mapPos(int)"
    var objPosStr = mapKeyArr[1]; // "x,y" -> functions as the key for the priorityMap 
    var objectString = ds_map_find_value(thisLayer.objPosToNameMap, objPosStr);
    //we can have multiple objects stored at each position in the map, so split them
    var objectArr = scr_split(objectString, ";");
    var objectString = objectArr[objPosAt]; //we want the ith item at this index....
    var object = get_objectFromString(objectString);
    
    var objPosStrArr = scr_split(objPosStr, ",");
    
    var objPosX = objPosStrArr[0];
    var objPosY = objPosStrArr[1];
    
    var objEnum = con_objectEnum(objectString, objPosX, objPosY);
     
    print("Handling " + object_get_name(object.object_index));
    
    /*
        HANDLE DIFFERENT TYPES OF OBJECT MOVEMENTS
        
        We have, and need to pass to each move_:
          * 2D Array of room map        -> thisLayer.m_roomMapArr
          * Object asset                -> object
          * Object position in the map  -> objPosStr
    */ 
    
    //Handles: par_cannon
    if (get_parent(object) == "par_cannon"){
        //print("handling cannon move");
        move_cannon(object, robot);
    }
    
    //If object is on top of a snare, don't do anything with it
    if (instance_place(x, y, par_snare)) {
        continue;
    }
    //Handles: obj_trigger, obj_triggerDoor
    else if (objectStr(object) == "obj_trigger" || objectStr == "obj_triggerDoor"){
        move_trigger(object, robot);
    }
    //Handles: obj_eviscerator
    else if (objectStr(object) == "obj_eviscerator"){
        move_eviscerator(object, robot);
    }
    //Handles: par_arrow
    else if (get_parent(object) == "par_arrow"){
        move_arrow(object);
    }
    //Handles: par_fallingPlatform
    else if (get_parent(object) == "par_fallingPlatform"){
        move_fallingPlatform(object, robot);
    }
    //Handles: obj_spike
    else if (objectStr(object) == "obj_spike"){
        move_spike(thisLayer, object, objPosX, objPosY);
    }
    //Handles: par_block, obj_key, obj_magneticSnare
    else if ((objEnum[| OBJECT.CANPUSH] || objEnum[| OBJECT.CANPULL])){
        print("ok nao: " + string(objEnum[| OBJECT.CANPULL]));
        move_pullPushables(thisLayer, objEnum);
    }
    else if (objectStr(object) == "obj_blackHole"){
        move_blackHole(object);
    }  
    else if (objectStr(object) == "obj_baby"){
        move_baby(object, robot);
    }
    
    ds_list_destroy(objEnum); //destroys enum (it's really a list..)
}

handle_prioritizeItems();

moved = false;
