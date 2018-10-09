///scr_initRoom

/*
    Called in every room's creation code  
*/

print ("-> scr_initRoom()");

var layer;

/*
    This is the first room loaded in.
*/
if (!instance_exists(obj_layerManager)){
    con_layerManager();
}

/*
    Init every layer in this room and hand them off to the LayerManager.  This is done
    for every rm_ in this layer.  
*/
if (global.loadingRoom){

    var roomSaveFileName = string(room_get_name(room)) + ".sav";
    
    if (file_exists(roomSaveFileName)) {
        file_delete(roomSaveFileName);
        print("###############################");
        print("###############################");
        print("###############################");
        print(" -> scr_initRoom: Warning: " + string(roomSaveFileName) + " has been deleted!");
    }
    
    //var priorityElementList = con_priorityObjectList(); //gets a list of every object in this room sorted by movement priority 
    //ds_list_destroy(priorityElementList);
    
    var platform = instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, obj_platform);
    for (var i = 0; i < ds_list_size(layer.list_objEnums); i++){
        var objEnum = layer.list_objEnums[| i];
        if (!instance_exists(get_objectFromString(objEnum[| OBJECT.NAME]))){ 
            instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, get_objectFromString(objEnum[| OBJECT.NAME]));
            print(" -> scr_initRoom: Created a deactivated " + string(objEnum[| OBJECT.NAME]) + " at " + string(global.DEACTIVATED_X) + "," + string(global.DEACTIVATED_Y));
            print(objEnum[| OBJECT.X]);
            print(objEnum[| OBJECT.Y]);
            print(layer.roomMapArr[16/16, 64/16]);
        }
    }
}

else{
    
    //add layer to layer manager's active layer list if it's not there
    //if (!ds_map_find_value(obj_layerManager.layerMap, room_get_name(room))){
    //layer = con_layer(room_get_name(room), priorityElementList);
    //ds_list_add(obj_layerManager.list_activeLayers, layer);
    //    print(" -> scr_initRoom: added layer of room " + string(layer.roomName) + " to the global.activeLayers ds list in the layerManager.");
    //}
    //get the layer of this room and update the surface
    //else{
    //    layer = ds_map_find_value(obj_layerManager.layerMap, room_get_name(room));
    //    layer.surfaceInf = con_surface(surf_layerRoom, layer, 0, 0, 1, 1, 0, c_white, 1);
    //}
    
    //obj_layerManager.playerLayer = layer;
    //print(" -> scr_initRoom: !!!!!!!!!!!!!!!!PLAYER LAYER: " + string(obj_layerManager.playerLayer.roomName));
    
    
    /*//set the state of the object in the list
    for (var i = 0; i < ds_list_size(priorityElementList); i++){
        var inst = ds_list_find_value(priorityElementList, i);
        set_objectState(inst);
    }
    
    ds_list_destroy(priorityElementList);*/

}

/*
    Load in every rm_ in this layer to give to the LayerManager.  
*/
if (global.loadedRoom == false) global.loadingRoom = true;
