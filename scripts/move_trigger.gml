///move_trigger(obj_layer layer, obj_trigger trigger)

/*
    This function handles:
        obj_trigger
        obj_triggerDoor //via this object's triggerDoorPtr
*/

var layer = argument0;
var trigger = argument1;

if (!trigger[| TRIGGER.DOORPTR]) return false;

var triggerDoorPtr = trigger[| TRIGGER.DOORPTR];

print("move_trigger: TiggerDoorPtr of: " + string(triggerDoorPtr[| OBJECT.NAME]));
print("move_trigger: TriggerDoor X: " + string(triggerDoorPtr[| OBJECT.X]));
print("move_trigger: TriggerDoor Y: " + string(triggerDoorPtr[| OBJECT.Y]));

//this is a trigger being pressed
//if ((instance_place(trigger[| OBJECT.X], trigger[| OBJECT.Y], par_pullable) || instance_place(trigger[| OBJECT.X], trigger[| OBJECT.Y], par_robot)) && triggerDoorPtr != undefined){
if (scr_tileContains(layer, trigger[| OBJECT.X], trigger[| OBJECT.Y], array(par_obstacle, par_robot, par_pullable)) && triggerDoorPtr != undefined){    
    //object.triggerDoorPtr.image_index = 1;
    //if (triggerDoorPtr[| OBJECT.OLDPOSX] == undefined &&
    //    triggerDoorPtr[| OBJECT.OLDPOSY] == undefined)
    //{
    
    //triggerDoorPtr[| OBJECT.OLDPOSX] = triggerDoorPtr[| OBJECT.X];
    //triggerDoorPtr[| OBJECT.OLDPOSY] = triggerDoorPtr[| OBJECT.Y];
    //triggerDoorPtr[| OBJECT.X] = global.DEACTIVATED_X;
    //triggerDoorPtr[| OBJECT.Y] = global.DEACTIVATED_Y;
        
    //} 
    
    print("move_trigger: trigger pressed; trigger door is deactivated");
    triggerDoorPtr[| OBJECT.ISACTIVE] = false;
    triggerDoorPtr[| OBJECT.IMGIND] = 1;
}
else{
    print("move_trigger: Nothing is being detected as pressed");
    triggerDoorPtr[| OBJECT.ISACTIVE] = true;
    triggerDoorPtr[| OBJECT.IMGIND] = 0;
}

//this is a trigger not being pressed
//if ((!instance_place(trigger[| OBJECT.X], trigger[| OBJECT.Y], par_pullable) && !instance_place(trigger[| OBJECT.X], trigger[| OBJECT.Y], par_robot)) && triggerDoorPtr != undefined){
//if (!scr_tileContains(layer, trigger[| OBJECT.X], trigger[| OBJECT.Y], array(par_obstacle, par_robot, par_pullable)) && triggerDoorPtr != undefined){ 
    //if (triggerDoorPtr[| OBJECT.X] == global.DEACTIVATED_X && 
    //    triggerDoorPtr[| OBJECT.Y] == global.DEACTIVATED_X)
    //{
    //    triggerDoorPtr[| OBJECT.X] = triggerDoorPtr[| OBJECT.OLDPOSX];
    //    triggerDoorPtr[| OBJECT.Y] = triggerDoorPtr[| OBJECT.OLDPOSY];
    //    triggerDoorPtr[| OBJECT.OLDPOSX] = undefined;
    //    triggerDoorPtr[| OBJECT.OLDPOSY] = undefined;
    //}
//    print("move_trigger: TRIGGER NOT BEING PRESSED,  TRIGGER DOOR is ACTIVATED");
//    triggerDoorPtr[| OBJECT.ISACTIVE] = true;
//    triggerDoorPtr[| OBJECT.IMGIND] = 0;
//}
