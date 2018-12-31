///undo_door(obj_enum door)

/*
    Handles undo for this door obj
*/

var door = argument0;

var state = ds_stack_pop(door[| OBJECT.STATEHISTORY]);
if (state == "locked" && door[| OBJECT.STATE] == "locked"){
    door[| OBJECT.ISACTIVE] = true;
    door[| OBJECT.STATE] = "locked";
}
else if (state == "locked" && door[| OBJECT.STATE] == "unlocked"){
    door[| OBJECT.STATE] = "locked";
    obj_player.numKeys++; // TODO -> How to do this correctly? tricky...
    door[| OBJECT.ISACTIVE] = true;
}
else if (state == "unlocked" && door[| OBJECT.STATE] == "unlocked"){
    door[| OBJECT.STATE] = "unlocked";
}
