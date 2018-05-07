///handle_undoMove(par_robot robot)

handle_cleanUpElementEffects();

var robot = argument0;

print("HANDLE UNDO MOVE");

//undo player's death
if (robot.isDead){ 
    undo_robotDeath(robot);
}

if (!ds_stack_empty(robot.moveHistory)){
    var continueUndo = undo_robot(robot); //don't undo these objects if we're switching rooms
    if (!continueUndo) handle_pushOntoStack(robot, true); //push every objects' state, even if undoing
    if (continueUndo){
        //handle every puzzle element's stack in this room
        for (var i = 0; i < array_length_1d(global.roomContents); i++){
            var object = global.roomContents[i];
            with(object){
                print("Handling undo for " + string(object_get_name(global.roomContents[i].object_index)));
                
                if (isSpike){
                    undo_spike(object);
                }
                if (parentOf(object) == "par_breakableWall"){
                    undo_breakableWall(object);
                }
                if (isFallingPlatform){
                    undo_fallingPlatform(object);
                }
                if (isArrow){
                    undo_arrow(object);
                }
                
                /*
                    X, Y Position-sensitive objects
                */
                
                if (objectIs(self) == "obj_block") print("_BLOCK stksize befoee pop!: " + string(ds_stack_size(moveHistory)));
                
                var objPosStr = ds_stack_pop(moveHistory); //string e.g. "64,64"
                //print(objPosStr);
                //var objPosStr = ds_stack_pop(moveHistory); //string e.g. "64,64"
                print(objPosStr);
                if (objPosStr != undefined){
                    var objCoordArr = scr_split(objPosStr, ",");
                    object.x = objCoordArr[0];
                    object.y = objCoordArr[1];
                    
                    // set old object pos (this is the val pushed to the obj's stack)
                    var oldObjPosStr = ds_stack_top(moveHistory);
                    if (oldObjPosStr != undefined){
                        var oldObjPosArr = scr_split(oldObjPosStr, ",");
                        object.oldPosX = oldObjPosArr[0];
                        object.oldPosY = oldObjPosArr[1];
                    }
                    else{
                        object.oldPosX = object.x;
                        object.oldPosY = object.y;
                    }
                    //undo trigger
                    if (triggerDoorPtr != undefined){
                        undo_trigger(object);
                    }
                    if (object_get_name(object_index) == "obj_triggerDoor"){
                        undo_triggerDoor(object);
                    }
                    if (object_get_name(object_index) == "obj_key"){
                        undo_key(object);
                    }
                    if (object_get_name(object_index) == "obj_baby"){
                        undo_baby(object);
                    }
                    if (object_get_name(object_index) == "obj_door"){
                        undo_door(object);
                    }
                    if (parentOf(object) == "par_cannon"){
                        undo_cannon(object);
                    }
                    
                    if (object.movedDir != ""){
                        movedDir = ds_stack_pop(object.movedDirHistory); //object last moved in this dir
                    }
                }
            }
        }
    }
}

undo = false;
