///con_priorityObjPosMap(var layer, ds_list sortedObjPriorityList)

/*
    Goal is to create a priority map by populating 2 data structures.  Since a map
    in GameMaker adds elements in a semi-random way, we need a way to maintain the 
    priority-move-order of puzzle elements.  This is solved by eimultaneously populating
    a ds_priority queue tied to a ds_map.     
*/

//args
var layer = argument0;
var sortedObjPriorityList = argument1;

//local
var objInst = undefined;
var priorQueueKey = undefined;
var mapValue = "";

layer.m_objPosToNameMap = ds_map_create();
layer.m_mapKeyPriorityQueue = ds_priority_create();

/*
    Loop through ds_list of ordered-by-move-priority puzzle elements in this layer object.  
    m_objPosToNameMap maps the position of the element to its name.  The position acts as a key.  
    If the key already has a puzzle element in that position, it is appended after a ';'.  
    Finally, this position is added to m_mapKeyPriorityQueue to keep the prioritized element order.  
*/
for (var i = 0; i < ds_list_size(sortedObjPriorityList); i++){
    objInst = ds_list_find_value(sortedObjPriorityList, i);
    priorityQueueKey = ds_stack_top(objInst.moveHistory); //obj posstr like "x,y"
    print("priorityQueueKey: " + string(priorityQueueKey));
    print("objStr: " + string(objectStr(objInst)));
    //if the key already exists in the map, append obj to the same position as that key
    if (ds_map_find_value(layer.m_objPosToNameMap, priorityQueueKey)){
        mapValue = string(ds_map_find_value(layer.m_objPosToNameMap, priorityQueueKey)) + objectStr(objInst) + ";";
        ds_map_replace(layer.m_objPosToNameMap, priorityKeyQueue, mapValue);
    }
    else{
        ds_map_add(layer.m_objPosToNameMap, priorityQueueKey, objectStr(objInst) + ";"); 
    }
    ds_priority_add(layer.m_mapKeyPriorityQueue, priorityQueueKey, i);
}
