///handle_undoMove

print("handle_undoMove");

if (isDead){ 
    sprite_index = spr_player;
    isDead = false;
}

if (!ds_stack_empty(obj_player.moveHistory)){
    //handle player's undo
    var objPosStr = ds_stack_pop(obj_player.moveHistory); //string e.g. "64,64"
    print(objPosStr);
    //print(obj_player.x);
    //print(obj_player.y);
    if (objPosStr != undefined){
        var objCoordArr = scr_split(objPosStr);
        //print(objCoordArr[0]);
        //print(objCoordArr[1]);
        obj_player.x = objCoordArr[0];
        obj_player.y = objCoordArr[1];
        global.playerX = obj_player.x;
        global.playerY = obj_player.y;
    }
    //handle player's items on undo
    var items = ds_stack_pop(obj_player.itemHistory);
    obj_player.numKeys = items[0];
    
    //handle every element's 
    for (var i = 0; i < array_length_1d(global.roomContents); i++){
        //print("in loop");
        with(global.roomContents[i]){
            //print("key still here");
            //var obj = global.roomContents[i];
            //print(object_get_name(global.roomContents[i]));
            
            if (isSpike){
                var spikeStateStr = ds_stack_pop(stateHistory);
                if (spikeStateStr != undefined){
                    print ("UNDOING SPIK");
                    print(spikeStateStr);
                    var stateArr = scr_split(spikeStateStr);
                    var stateStr = stateArr[0];
                    var stateDir = stateArr[1];
                    print(stateStr);
                    print(stateDir);
                    if (stateStr == "idle"){
                        targetLocked = false;
                        state = "idle";
                        targetDirection = "idling";
                        sprite_index = spr_spike;
                    }
                    else if (stateStr == "active"){
                        targetLocked = true;
                        state = "active";
                        targetDirection = stateDir;
                        sprite_index = spr_spikeActive;
                    }
                }
            }
            if (isFallingPlatform){
                var fallingPlatformStr = ds_stack_pop(stateHistory);
                if (fallingPlatformStr != undefined){
                    print ("UNDOING FALLING PLATFORM");
                    if ((stepsLeft < fallingPlatformStr)){
                        stepsLeft++;
                        image_index--;
                        if (stepsLeft != 0){
                            isDeactivated = false;
                        }
                    }
                }
            }
            
            var objPosStr = ds_stack_pop(moveHistory); //string e.g. "64,64"
            //print(objPosStr);
            if (objPosStr != undefined){
                var objCoordArr = scr_split(objPosStr);
                x = objCoordArr[0];
                y = objCoordArr[1];
                if ((instance_place(x, y, par_pullable) || instance_place(x, y, obj_player)) && triggerDoorPtr != undefined){ //this is a trigger being pressed
                    self.triggerDoorPtr.image_index = 1;
                    self.triggerDoorPtr.isDeactivated = true;
                }
                if ((!instance_place(x, y, par_pullable) && !instance_place(x, y, obj_player)) && triggerDoorPtr != undefined){ //this is a trigger not being pressed
                    self.triggerDoorPtr.image_index = 0;
                    self.triggerDoorPtr.isDeactivated = false;
                }
            }
        }
    }
}

undo = false;
