///move_trigger(obj_layer layer, obj_trigger trigger)

/*
    This function handles:
        obj_trigger
        obj_triggerDoor //via this object's triggerDoorPtr
*/

var layer = argument0;
var trigger = argument1;

if (!trigger[| TRIGGER.TRIGGERDOORPTR]) return false;

var triggerDoorPtr = trigger[| TRIGGER.TRIGGERDOORPTR];

//this is a trigger being pressed
//if ((instance_place(trigger[| OBJECT.X], trigger[| OBJECT.Y], par_pullable) || instance_place(trigger[| OBJECT.X], trigger[| OBJECT.Y], par_robot)) && triggerDoorPtr != undefined){
if (scr_tileContains(layer, trigger[| OBJECT.X], trigger[| OBJECT.Y], array(par_obstacle, par_robot, par_pullable)) && triggerDoorPtr != undefined){    
    //object.triggerDoorPtr.image_index = 1;
    if (triggerDoorPtr.deactivatedX == undefined &&
        triggerDoorPtr.deactivatedY == undefined)
    {
        //print("Yeah it's undefined duh");
        triggerDoorPtr.deactivatedX = triggerDoorPtr.x;
        triggerDoorPtr.deactivatedY = triggerDoorPtr.y;
        triggerDoorPtr.x = global.DEACTIVATED_X;
        triggerDoorPtr.y = global.DEACTIVATED_Y;
    } 
    
    triggerDoorPtr.isDeactivated = true;
    //print("TRIGGERDOOR IS DEACTIVATED VALUE: " + string(object.triggerDoorPtr.isDeactivated));
    print("trigger pressed; trigger door is deactivated");
    
    triggerDoorPtr.image_index = 1;
}
else{
    print("Nothing is being detected as pressed");
}

//this is a trigger not being pressed
//if ((!instance_place(trigger[| OBJECT.X], trigger[| OBJECT.Y], par_pullable) && !instance_place(trigger[| OBJECT.X], trigger[| OBJECT.Y], par_robot)) && triggerDoorPtr != undefined){
if (!scr_tileContains(layer, trigger[| OBJECT.X], trigger[| OBJECT.Y], array(par_obstacle, par_robot, par_pullable)) && triggerDoorPtr != undefined){ 
    triggerDoorPtr.isDeactivated = false;
    print("TRIGGERDOOR IS DEACTIVATED VALUE: " + string(object.triggerDoorPtr.isDeactivated));
    if (triggerDoorPtr.x == global.DEACTIVATED_X && 
        triggerDoorPtr.y == global.DEACTIVATED_Y)
    {
        triggerDoorPtr.x = triggerDoorPtr.deactivatedX;
        triggerDoorPtr.y = triggerDoorPtr.deactivatedY;
        triggerDoorPtr.deactivatedX = undefined;
        triggerDoorPtr.deactivatedY = undefined;
    }
    print("TRIGGER DOOR NOT BEING PRESSED,  TRIGGER DOOR ACTIVATED");
    triggerDoorPtr.image_index = 0;
}
