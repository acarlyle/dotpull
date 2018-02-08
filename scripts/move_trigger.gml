///move_trigger(obj_trigger trigger, par_robot robot)

/*
    This function handles:
        obj_trigger
        obj_triggerDoor //via this object's triggerDoorPtr
*/

trigger = argument0;
robot = argument1;

//this is a trigger being pressed
if ((instance_place(trigger.x, trigger.y, par_pullable) || instance_place(trigger.x, trigger.y, par_robot)) && trigger.triggerDoorPtr != undefined){
    //object.triggerDoorPtr.image_index = 1;
    if (trigger.triggerDoorPtr.deactivatedX == undefined &&
        trigger.triggerDoorPtr.deactivatedY == undefined)
    {
        //print("Yeah it's undefined duh");
        trigger.triggerDoorPtr.deactivatedX = trigger.triggerDoorPtr.x;
        trigger.triggerDoorPtr.deactivatedY = trigger.triggerDoorPtr.y;
        trigger.triggerDoorPtr.x = global.DEACTIVATED_X;
        trigger.triggerDoorPtr.y = global.DEACTIVATED_Y;
    } 
    
    trigger.triggerDoorPtr.isDeactivated = true;
    //print("TRIGGERDOOR IS DEACTIVATED VALUE: " + string(object.triggerDoorPtr.isDeactivated));
    print("trigger pressed; trigger door is deactivated");
    
    trigger.triggerDoorPtr.image_index = 1;
}

//this is a trigger not being pressed
if ((!instance_place(trigger.x, trigger.y, par_pullable) && !instance_place(trigger.x, trigger.y, par_robot)) && trigger.triggerDoorPtr != undefined){
    trigger.triggerDoorPtr.isDeactivated = false;
    print("TRIGGERDOOR IS DEACTIVATED VALUE: " + string(object.triggerDoorPtr.isDeactivated));
    if (trigger.triggerDoorPtr.x == global.DEACTIVATED_X && 
        trigger.triggerDoorPtr.y == global.DEACTIVATED_Y)
    {
        trigger.triggerDoorPtr.x = trigger.triggerDoorPtr.deactivatedX;
        trigger.triggerDoorPtr.y = trigger.triggerDoorPtr.deactivatedY;
        trigger.triggerDoorPtr.deactivatedX = undefined;
        trigger.triggerDoorPtr.deactivatedY = undefined;
    }
    print("TRIGGER DOOR NOT BEING PRESSED,  TRIGGER DOOR ACTIVATED");
    trigger.triggerDoorPtr.image_index = 0;
}
