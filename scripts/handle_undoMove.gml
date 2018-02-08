///handle_undoMove(par_robot robot)

var robot = argument0;

print("HANDLE UNDO MOVE");

//undo player's death
if (robot.isDead){ 
    undo_robotDeath(robot);
}

if (!ds_stack_empty(robot.moveHistory)){
    undo_robot(robot);
    
    //handle every puzzle element's stack in this room
    for (var i = 0; i < array_length_1d(global.roomContents); i++){
        var object = global.roomContents[i];
        with(object){
            print("Handling undo for " + string(object_get_name(global.roomContents[i].object_index)));
            
            if (isSpike){
                undo_spike(object);
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
            var objPosStr = ds_stack_pop(moveHistory); //string e.g. "64,64"
            //print(objPosStr);
            //var objPosStr = ds_stack_pop(moveHistory); //string e.g. "64,64"
            print(objPosStr);
            if (objPosStr != undefined){
                var objCoordArr = scr_split(objPosStr);
                x = objCoordArr[0];
                y = objCoordArr[1];
                
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
                if (object_get_name(object_index) == "obj_door"){
                    undo_door(object);
                }
            }
        }
    }
}

undo = false;
