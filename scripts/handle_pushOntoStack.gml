///handle_pushOntoStack(object obj)

for (var i = 0; i < array_length_1d(global.roomContents); i++){
    var object = global.roomContents[i];
    with(object){
        
        print("Handling push for " + object_get_name(object.object_index));
        //print(string(object.justDeactivated));
        
        //push this objects previous position onto its stack
        //This is true if an object has been moved to the DEACITVATED_X/Y Zone off screen and was pushed already
        if (object.justDeactivated){
            object.justDeactivated = false; 
            continue;
        }
        //ds_stack_push(object.moveHistory, string(object.x) + "," + string(object.y)); //pushing previous turn's movement
        ds_stack_push(object.moveHistory, string(object.oldPosX) + "," + string(object.oldPosY)); //pushing previous turn's movement
        
        if (object.isSpike){
            ds_stack_push(object.stateHistory, object.state + "," + object.targetDirection);
            print("pushed spike stateHistory: " + string(object.state) + "," + string(object.targetDirection));
        }
        if (object_get_name(object_index) == "obj_key" || 
            object_get_name(object_index) == "obj_door" ||
            object_get_name(object_index) == "obj_baby") {
            ds_stack_push(object.stateHistory, object.currentState);
            
            if (object_get_name(object_index) == "obj_door") && (object.x == global.DEACTIVATED_X) && (object.y == global.DEACTIVATED_Y){
                object.currentState = "unlocked";
                //print("state now " + string(currentState));
            }
            
            if (object_get_name(object_index) == "obj_key" && (object.x == global.DEACTIVATED_X) && (object.y == global.DEACTIVATED_Y))  {
                object.currentState = "inventory";
                //print("state now " + string(currentState));
            }
        }
        if (parentOf(object) == "par_breakableWall"){
            ds_stack_push(object.stateHistory, object.hitsLeft);
        }
        
        if (object.canPull || object.canPush){
            ds_stack_push(object.movedDirHistory, object.movedDir);
        }
    }
}
