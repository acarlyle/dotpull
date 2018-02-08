///undo_key(obj_key key)

/*
    Handles undo for this key obj
*/

key = argument0;

var state = ds_stack_pop(key.stateHistory);
//print("Key current state (1): " + currentState)
//print("Key popped state (1): " + state);
if (state == "ground" && key.currentState == "ground"){
    key.isDeactivated = false;
    key.currentState = "ground";
    //image_index = 0;
}
else if (state == "ground" && key.currentState == "inventory"){
    key.currentState = "ground";
    obj_player.numKeys--;
    key.isDeactivated = false;
    print("Key is activated");
    //image_index = 0;
}
else if (state == "inventory" && key.currentState == "inventory"){
    //image_index = 1;
    key.currentState = "inventory";
    key.isDeactivated = true;
}

//print("Key current state (2): " + currentState)
//print("Key popped state (2): " + state);
