///handle_layerObjects(obj_layer layer);

var layer = argument0;

var robot = layer.robot;

handle_cleanUpElementEffects();

for (var enumI = 0; enumI < ds_list_size(layer.list_objEnums); enumI++)
{
    var object = layer.list_objEnums[| enumI];
    var oldObjX = object[| OBJECT.X];
    var oldObjY = object[| OBJECT.Y];

    print("Layer size list: " + string(ds_list_size(layer.list_objEnums)));
         
    print("-> handle_layerObjects: Handling  " + object[| OBJECT.NAME]);
    
    /*
        HANDLE DIFFERENT TYPES OF OBJECT MOVEMENTS
        
        We have, and need to pass to each move_:
          * 2D Array of room map        -> layer.m_roomMapArr
          * Object asset                -> object
          * Object position in the map  -> objPosStr
    */ 
    
    //Handles: par_cannon
    if (get_parent(get_objectFromString(object[| OBJECT.NAME])) == "par_cannon"){
        //print("handling cannon move");
        move_cannon(layer, object);
    }
    
    //If object is on top of a snare, don't do anything with it
    if (map_place(layer, par_snare, object[| OBJECT.X], object[| OBJECT.Y])) { continue; }
    
    //Handles: obj_trigger, obj_triggerDoor
    else if (object[| OBJECT.NAME] == "obj_trigger" || object[| OBJECT.NAME] == "obj_triggerDoor"){
        move_trigger(layer, object);
    }
    //Handles: obj_eviscerator
    else if (object[| OBJECT.NAME] == "obj_eviscerator"){
        move_eviscerator(layer, object);
    }
    //Handles: par_arrow
    else if (get_parent(get_objectFromString(object[| OBJECT.NAME])) == "par_arrow"){
        move_arrow(layer, object);
    }
    //Handles: par_fallingPlatform
    else if (get_parent(get_objectFromString(object[| OBJECT.NAME])) == "par_fallingPlatform"){
        move_fallingPlatform(layer, object);
    }
    //Handles: obj_spike
    else if (object[| OBJECT.NAME] == "obj_spike"){
        move_spike(layer, object);
    }
    //Handles: par_block, obj_key, obj_magneticSnare
    else if ((object[| OBJECT.CANPUSH] || object[| OBJECT.CANPULL])){
        move_pullPushables(layer, object);
    }
    else if (object[| OBJECT.NAME] == "obj_blackHole"){
        move_blackHole(layer, object);
    }  
    else if (object[| OBJECT.NAME] == "obj_baby"){
        move_baby(layer, object);
    }
    
    /*  
        Object's variables have been updated.
        Now we need to update the Layer's object position data based
        on the ObjectEnum.    
    */
    
    if (object[| OBJECT.NAME] == "obj_block")
        print("BLOCK: " + string(object[| OBJECT.X]) + "," + string(object[| OBJECT.Y]));
        
        
        
    /*
      #######################
      #######################
      #######################
    */  
    
    
        
    //update layer's arrMap if object moved
    //TODO need to update obj stacks insteading of copying over the previous turn's stack
    if (object[| OBJECT.MOVED]){
    
        layer_updateObjAtTile(layer, object, oldObjX, oldObjY);
        
        layer.updateLayer = true; //flag to draw new position to the screen
        
        /* 
            TODO needs better implemenation rather than this hackish workaround 
            Handle updating fake layer
            If obj_player is this layer's robot, this is the fake layer (real objects are in the room) 
        */
        if (robot[| OBJECT.NAME] == "obj_player"){
            var objInst = instance_place(oldObjX, oldObjY, get_objectFromString(object[| OBJECT.NAME]));
            objInst.x = object[| OBJECT.X];
            objInst.y = object[| OBJECT.Y];
        }
        
        // Update Layer's object position to obj enum Map
        if (layer.objNameAndPosToEnumMap){
            ds_map_delete(layer.objNameAndPosToEnumMap, 
                            object[| OBJECT.NAME] + ":" + string(oldObjX) + "," + string(oldObjY));
                            
            ds_map_add(layer.objNameAndPosToEnumMap, 
                            object[| OBJECT.NAME] + ":" + string(object[| OBJECT.X]) + "," + string(object[| OBJECT.Y]), 
                            object);
        }
        
        object[| OBJECT.MOVED] = false;
        
    } // if object moved   
} // foreach objEnum in this layer

handle_prioritizeItems();

robot[| OBJECT.MOVED] = false;
