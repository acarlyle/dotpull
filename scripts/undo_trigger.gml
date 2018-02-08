///undo_trigger(obj_trigger door)

/*
    Handles undo for this trigger obj
*/

trigger = argument0;

//this is a trigger being pressed
if ((instance_place(trigger.x, trigger.y, par_pullable) || instance_place(trigger.x, trigger.y, par_robot)) && trigger.triggerDoorPtr != undefined){
    self.triggerDoorPtr.image_index = 1;
    self.triggerDoorPtr.isDeactivated = true;
    
    if (trigger.triggerDoorPtr.deactivatedX == undefined &&
        trigger.triggerDoorPtr.deactivatedY == undefined)
    {
        print("Yeah it's undefined duh");
        trigger.triggerDoorPtr.deactivatedX = trigger.triggerDoorPtr.x;
        trigger.triggerDoorPtr.deactivatedY = trigger.triggerDoorPtr.y;
        trigger.triggerDoorPtr.x = global.DEACTIVATED_X;
        trigger.triggerDoorPtr.y = global.DEACTIVATED_Y;
    }
}
//this is a trigger not being pressed
if ((!instance_place(trigger.x, trigger.y, par_pullable) && !instance_place(trigger.x, trigger.y, par_robot)) && trigger.triggerDoorPtr != undefined){ 
    if (trigger.triggerDoorPtr.x == global.DEACTIVATED_X && 
        trigger.triggerDoorPtr.y == global.DEACTIVATED_Y)
    {
        print("where we should be");
        //triggerDoorPtr.x = triggerDoorPtr.deactivatedX;
        //triggerDoorPtr.y = triggerDoorPtr.deactivatedY;
        //triggerDoorPtr.deactivatedX = undefined;
        //triggerDoorPtr.deactivatedY = undefined;
        print("x value: " + string(trigger.triggerDoorPtr.x))
        print("y value: " + string(trigger.triggerDoorPtr.y))
    }
    trigger.triggerDoorPtr.image_index = 0;
    trigger.triggerDoorPtr.isDeactivated = false;
}
