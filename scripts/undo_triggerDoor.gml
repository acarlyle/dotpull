///undo_door(obj_triggerDoor triggerDoor)

/*
    Handles undo for this triggerDoor obj
*/

triggerDoor = argument0;

// if door is deactivated and nothing is on the trigger, activate door
//print(deactivatedX);
//print(deactivatedY);
if (triggerDoor.deactivatedX != undefined && triggerDoor.deactivatedY != undefined){
    if (triggerDoor.x == global.DEACTIVATED_X && triggerDoor.y == global.DEACTIVATED_Y && 
       !instance_place(triggerDoor.x, triggerDoor.y, par_pullable) && 
       !instance_place(triggerDoor.deactivatedX, triggerDoor.deactivatedY, par_robot)){
       
        triggerDoor.x = triggerDoor.deactivatedX;
        triggerDoor.y = triggerDoor.deactivatedY;
        triggerDoor.deactivatedX = undefined;
        triggerDoor.deactivatedY = undefined;
        print("setting deactivated door back to undefined");
    }
}
