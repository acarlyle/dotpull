///handle_layerObjects(par_robot robot, obj_layer layer);

var robot = argument0;
var thisLayer = argument1;

handle_cleanUpElementEffects();

for (var enumI = 0; enumI < ds_list_size(thisLayer.list_objEnums); enumI++)
{
    var object = thisLayer.list_objEnums[| enumI];
     
    print(" -> handle_layerObjects: Handling " + object[| OBJECT.NAME]);
    
    /*
        HANDLE DIFFERENT TYPES OF OBJECT MOVEMENTS
        
        We have, and need to pass to each move_:
          * 2D Array of room map        -> thisLayer.m_roomMapArr
          * Object asset                -> object
          * Object position in the map  -> objPosStr
    */ 
    
    //Handles: par_cannon
    if (get_parent(get_objectFromString(object[| OBJECT.NAME])) == "par_cannon"){
        //print("handling cannon move");
        move_cannon(object, robot);
    }
    
    //If object is on top of a snare, don't do anything with it
    if (map_place(thisLayer, par_snare, object[| OBJECT.X], objPosY)) { continue; }
    
    //Handles: obj_trigger, obj_triggerDoor
    else if (object[| OBJECT.NAME] == "obj_trigger" || object[| OBJECT.NAME] == "obj_triggerDoor"){
        move_trigger(object, robot);
    }
    //Handles: obj_eviscerator
    else if (object[| OBJECT.NAME] == "obj_eviscerator"){
        move_eviscerator(object, robot);
    }
    //Handles: par_arrow
    else if (get_parent(get_objectFromString(object[| OBJECT.NAME])) == "par_arrow"){
        move_arrow(object);
    }
    //Handles: par_fallingPlatform
    else if (get_parent(get_objectFromString(object[| OBJECT.NAME])) == "par_fallingPlatform"){
        move_fallingPlatform(object, robot);
    }
    //Handles: obj_spike
    else if (object[| OBJECT.NAME] == "obj_spike"){
        move_spike(thisLayer, object);
    }
    //Handles: par_block, obj_key, obj_magneticSnare
    else if ((object[| OBJECT.CANPUSH] || object[| OBJECT.CANPULL])){
        move_pullPushables(thisLayer, object);
    }
    else if (object[| OBJECT.NAME] == "obj_blackHole"){
        move_blackHole(object);
    }  
    else if (object[| OBJECT.NAME] == "obj_baby"){
        move_baby(object, robot);
    }
    
    /*  
        Object's variables have been updated.
        Now we need to update the Layer's object position data based
        on the ObjectEnum.    
    */
    
    //update 
}

handle_prioritizeItems();

moved = false;
