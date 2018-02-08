///undo_door(obj_door door)

/*
    Handles undo for this door obj
*/

door = argument0;

var state = ds_stack_pop(door.stateHistory);
if (state == "locked" && door.currentState == "locked"){
    door.isDeactivated = false;
    door.currentState = "locked";
}
else if (state == "locked" && door.currentState == "unlocked"){
    door.currentState = "locked";
    obj_player.numKeys++;
    door.isDeactivated = false;
    //print("Door deactivated");
}
else if (state == "unlocked" && door.currentState == "unlocked"){
    door.currentState = "unlocked";
}

//print("Door current state: " + currentState)
//print("Door popped state: " + state);
