///undo_baby(obj_baby baby)

/*
    Handles undo for this baby obj
*/

var baby = argument0;

print("UNDO BABY currentState before: " + string(baby.currentState));

var state = ds_stack_pop(baby.stateHistory);
if (state == "ground" && baby.currentState == "ground"){
    baby.isDeactivated = false;
    baby.currentState = "ground";
}
else if (state == "ground" && baby.currentState == "inventory"){
    baby.currentState = "ground";
    obj_player.hasBaby = false;
    baby.isDeactivated = false;
}
else if (state == "inventory" && baby.currentState == "inventory"){
    baby.currentState = "inventory";
    baby.isDeactivated = true;
}

print("UNDO BABY currentState now: " + string(baby.currentState));
