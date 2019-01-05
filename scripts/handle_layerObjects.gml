///handle_layerObjects(obj_layer layer);

/*
    If this script is called, it means that the player has moved somewhere so this object is free to move/push
    its state onto a stack.  
*/

var layer = argument0;
var robot = layer.robot;

handle_cleanUpElementEffects();

print(" ");
print("-> handle_layerObjects()");

for (var enumI = 0; enumI < ds_list_size(layer.list_objEnums); enumI++)
{

    print(" -> handle_layerObjects: list_objEnums size: " + string(ds_list_size(layer.list_objEnums)));    

    var object = layer.list_objEnums[| enumI];

    /* Push previous object's state before new turn happens. */ 
    push_objectState(object, true);  
    
    object[| OBJECT.OLDPOSX] = object[| OBJECT.X];
    object[| OBJECT.OLDPOSY] = object[| OBJECT.Y];

    //print("Layer size list: " + string(ds_list_size(layer.list_objEnums)));
    
    if (get_parent(get_objectFromString(object[| OBJECT.NAME])) == "par_fallingPlatform"){
        continue;
    }
         
    print("-> handle_layerObjects: Handling  " + string(object[| OBJECT.NAME]) + " at: " + string(object[| OBJECT.X]) + "," + string(object[| OBJECT.Y]));
    
    /*
        HANDLE DIFFERENT TYPES OF OBJECT MOVEMENTS
        
        We have, and need to pass to each move_:
          * 2D Array of room map        -> layer.m_roomMapArr
          * Object asset                -> object
          * Object position in the map  -> objPosStr
    */ 
    
    //Handles: par_cannon
    if (get_parent(get_objectFromString(object[| OBJECT.NAME])) == "par_cannon"){
        move_cannon(layer, object);
    }
    
    //If object is on top of a snare, don't do anything with it
    if (map_place(layer, par_snare, object[| OBJECT.X], object[| OBJECT.Y])) { print("Snare here!  Cannot move"); continue; }
    
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
        
    /*
      #######################
      #######################
      #######################
    */  
    
    //UPDATE PLAYER LAYER ACTUAL POSITIONS
    /*if (robot[| OBJECT.NAME] == "obj_player"){
    
        print("old enum objectX: " + string(object[| OBJECT.OLDPOSX]));
        print("old enum objectY: " + string(object[| OBJECT.OLDPOSY]));
        print("cur enum objectX: " + string(object[| OBJECT.X]));
        print("cur enum objectY: " + string(object[| OBJECT.Y]));
        
        with(obj_trigger) {
            print("BEFORE: woo it's a trigger at: " + string(x) + "," + string(y));
        }
    
        var objInst = instance_place(object[| OBJECT.OLDPOSX], object[| OBJECT.OLDPOSY], get_objectFromString(object[| OBJECT.NAME]));
        if (!objInst){
            //print("This instance doesn't exist.  Continuing...."); 
            continue;
        }
        
        //it should be, so why the fuck isn't it??
        //if (objInst.x != object[| OBJECT.OLDPOSX] || objInst.y != object[| OBJECT.OLDPOSY]){
        //    continue;
        //}
        
        print("old enum objectX: " + string(object[| OBJECT.OLDPOSX]));
        print("old enum objectY: " + string(object[| OBJECT.OLDPOSY]));
        print("cur enum objectX: " + string(object[| OBJECT.X]));
        print("cur enum objectY: " + string(object[| OBJECT.Y]));
        
        print("inst Obj: " + string(object_get_name(objInst.object_index)));
        print("inst objX: " + string(objInst.x));
        print("inst objY: " + string(objInst.y));
        
        //var stoopidTrigger = instance_place(16, 112, obj_trigger);
        //if (stoopidTrigger) print("STOOOOPID STOOPID 5!!!");
        
        /*if (object[| OBJECT.X] == global.DEACTIVATED_X || object[| OBJECT.Y] == global.DEACTIVATED_Y){
            print(object[| OBJECT.NAME] + " is disabled, cannot map_place deactivated tilePos.");
            
            print(objInst.x);
            print(objInst.y);
            objInst.x = global.DEACTIVATED_X;
            objInst.y = global.DEACTIVATED_Y;
            continue;
        }*/
        
        /*objInst.x = real(object[| OBJECT.X]);
        objInst.y = real(object[| OBJECT.Y]);
        objInst.image_index = real(object[| OBJECT.IMGIND]);
        
        with(obj_trigger) {
            print("AFTER: woo it's a trigger at: " + string(x) + "," + string(y));
        }
    }*/
        
    //update layer's arrMap if object moved
    //TODO need to update obj stacks insteading of copying over the previous turn's stack
    if (object[| OBJECT.MOVED])
    {
    
        layer_updateObjAtTile(layer, object, object[| OBJECT.OLDPOSX], object[| OBJECT.OLDPOSY]);
        
        layer.isActive = true; // TODO not used (I think)
        
        // Update Layer's object position to obj enum Map
        if (layer.objNameAndPosToEnumMap){
            ds_map_delete(layer.objNameAndPosToEnumMap, 
                            object[| OBJECT.NAME] + ":" + string(object[| OBJECT.OLDPOSX]) + "," + string(object[| OBJECT.OLDPOSY]));
                            
            ds_map_add(layer.objNameAndPosToEnumMap, 
                            object[| OBJECT.NAME] + ":" + string(object[| OBJECT.X]) + "," + string(object[| OBJECT.Y]), 
                            object);
        }
        
        object[| OBJECT.MOVED] = false;
        
        handle_checkForFallingPlatform(layer, object); //if moved off a falling platform
        
    } // if object moved   
    
    
} // foreach objEnum in this layer

//handle_prioritizeItems(); TODO
