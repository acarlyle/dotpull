///undo_baby(obj_enum robotPlayer, obj_enum baby)

/*
    Handles undo for this baby obj
*/

var robot = argument0;
var baby = argument1;

print("UNDO BABY currentState before: " + string(baby[| OBJECT.STATE]));

var state = ds_stack_pop(baby[| OBJECT.STATEHISTORY]);
if (state == "ground" && baby[| OBJECT.STATE] == "ground"){
    baby[| OBJECT.ISACTIVE] = true;
    baby[| OBJECT.STATE] = "ground";
}
else if (state == "ground" && baby.currentState == "inventory"){
    baby[| OBJECT.STATE] = "ground";
    robot[| ROBOT.HASBABY] = false;
    baby[| OBJECT.ISACTIVE] = true;
}
else if (state == "inventory" && baby.currentState == "inventory"){
    baby[| OBJECT.STATE] = "inventory";
    baby[| OBJECT.ISACTIVE] = false;
}
