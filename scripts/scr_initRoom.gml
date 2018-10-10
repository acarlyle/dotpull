///scr_initRoom

/*
    Called in every room's creation code  
*/

print ("-> scr_initRoom for " + string(room_get_name(room)));

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
if (global.loadingRoom && !global.loadedRoom){

    var roomSaveFileName = string(room_get_name(room)) + ".sav";
    
    if (file_exists(roomSaveFileName)) {
        file_delete(roomSaveFileName);
        print("###############################");
        print("###############################");
        print("###############################");
        print(" -> scr_initRoom: Warning: " + string(roomSaveFileName) + " has been deleted!");
    }
    
    var priorityElementList = con_priorityObjectList(); //gets a list of every object in this room sorted by movement priority 
    
    //add layer to layer manager's active layer list if it's not there
    layer = con_layer(room_get_name(room), priorityElementList);
    ds_list_add(obj_layerManager.list_activeLayers, layer);
    print(" -> scr_initRoom: added layer of room " + string(layer.roomName) + " to the global.activeLayers ds list in the layerManager.");
    
    if (obj_layerManager.playerRoom == room) obj_layerManager.playerLayer = layer; //set the correct player layer
    
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
    
    ds_list_destroy(priorityElementList);
    
    /*
        If thehere's a room above us, continue initing each layer.  Otherwise, head to the PlayerLayer and load in the real level.  
    */
    var higherRoomName = get_higherRoomName(room_get_name(room));
    if (higherRoomName != undefined){
        room_goto(get_roomFromString(higherRoomName));
        print("hmm ?");
    }
    else{
        room_goto(obj_layerManager.playerRoom);
        global.loadedRoom = true;
        global.loadingRoom = false;
    }
    
}
else if (global.loadingRoom == false && global.loadedRoom == false){
    global.loadingRoom = true;
}
