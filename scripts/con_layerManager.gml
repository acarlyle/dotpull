///con_layerManager()

/*
    Grabs the lowest room in this layer (rm_*NAME*_*BASEMENTorFLOOR*_*NUM*) and constructs
    and appends each rm_ in this layer to this layerManager.  
*/

instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, obj_layerManager);
obj_layerManager.playerRoom = room; //we can return here after we've finished initing the layer
obj_layerManager.list_activeLayers = ds_list_create();
//now create every layer in this rm_ starting at the lowest floor

var lowestRoom = get_lowestRoomInLayer(room);

print("-> con_layerManager: lowestRoomName in layer: " + string(room_get_name(lowestRoom)));

room_goto(lowestRoom); //begin constructing each layer by loading in each room; work continues in scr_initRoom

print(" -> con_layerManager: roomGoto(" + string(room_get_name(lowestRoom)) + ")");
