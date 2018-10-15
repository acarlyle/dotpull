///con_priorityObjPosMap(var layer, ds_list sortedObjPriorityList)

/*
    Goal is to create a priority map by populating 2 data structures.  Since a map
    in GameMaker adds elements in a semi-random way, we need a way to maintain the 
    priority-move-order of puzzle elements.  This is solved by simultaneously populating
    a ds_list tied to a ds_map.     
*/

//args
var layer = argument0;
var sortedObjPriorityList = argument1;

//local
var objInst = undefined;
var priorityListValue = undefined;
var mapValue = "";
var objAt = 0; //for keeping track of which obj at that position was added in the ds_map in the priorityList
var curObjStr = "";

layer.objPosToNameMap = ds_map_create();
layer.mapKeyPriorityList = ds_list_create();

//print("con_priorityObjPosMap: sortedPriorityList size: " + string(ds_list_size(sortedObjPriorityList)));

/*
    Loop through ds_list of ordered-by-move-priority puzzle elements in this layer object.  
    m_objPosToNameMap maps the position of the element to its name.  The position acts as a key.  
    If the key already has a puzzle element in that position, it is appended after a ';'.  
    Finally, this position is added to m_mapKeyPriorityList to keep the prioritized element order.  
*/

for (var i = 0; i < ds_list_size(sortedObjPriorityList); i++){
    objInst = ds_list_find_value(sortedObjPriorityList, i);
    objAt = 0;
    //print("con_priorityObjPosMap: looking at objInst: " + string(objectStr(objInst)));
    if (!objInst.moveHistory) {
        print("con_priorityObjPosMap: CRITICAL warning!  obj has no move history.  skipping for the priorityList");
        continue; //objs with no move history are skipped
    }
    priorityListValue = ds_stack_top(objInst.moveHistory); //obj posstr like "x,y"
    //print("con_priorityObjPosMap: priorityQueueKey: " + string(priorityListValue));
    //print("con_priorityObjPosMap: ds_map_find_value: " + string(ds_map_find_value(layer.objPosToNameMap, priorityListValue)));
    //if the key already exists in the map, append obj to the same position as that key
    if (ds_map_find_value(layer.objPosToNameMap, priorityListValue) != undefined){ // priorityListValue = "x,y"
        curObjStr = string(ds_map_find_value(layer.objPosToNameMap, priorityListValue));
        objAt = string_count(";", curObjStr); //if 0 ';'s then this objAt will be one and the obj will be added after the zeroth ';'
        //print("con_priorityObjPosMap objAt val: " + string(objAt));
        mapValue = curObjStr + objectStr(objInst) + ";";
        ds_map_replace(layer.objPosToNameMap, priorityListValue, mapValue);
    }
    else{
        ds_map_add(layer.objPosToNameMap, priorityListValue, objectStr(objInst) + ";"); 
        //print("con_priorityObjPosMap: added value to objPosToNameMap: " + objectStr(objInst) + ";" + " at map key " + string(priorityListValue));
        //print("con_priorityObjPosMap: why couldn't you find this: ???? " + string(ds_map_find_value(layer.objPosToNameMap, priorityListValue)));
    }
    ds_list_add(layer.mapKeyPriorityList, string(objAt) + ":" + string(priorityListValue));
}
