///handle_pushOntoStack(object obj)

for (var i = 0; i < array_length_1d(global.roomContents); i++){
    var object = global.roomContents[i];
    with(object){
        
        print("Handling push for " + object_get_name(object.object_index));
        
        //push this objects previous position onto its stack
        if (justDeactivated){
            continue;
        }
        else{ 
            object.justDeactivated = false; 
        } 
        ds_stack_push(object.moveHistory, string(object.x) + "," + string(object.y)); //pushing previous turn's movement
        //print("pushed");
        
        if (object.isSpike){
            ds_stack_push(object.stateHistory, object.state + "," + object.targetDirection);
            print("pushed spike stateHistory: " + string(object.state) + "," + string(object.targetDirection));
        }
        if (object_get_name(object_index) == "obj_key" || 
            object_get_name(object_index) == "obj_door"){
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
        /*if (parentOf(object) == "par_cannon"){
            print(object.state);
            print(object.shotDirection);
            ds_stack_push(object.stateHistory, object.state + "," + object.shotDirection);
            print("pushed cannon stateHistory: " + string(object.state) + "," + string(object.shotDirection));
        }*/
    }
}
