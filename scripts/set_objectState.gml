///set_objectState()

/*
    Set the objects to the state that they should be in,
    based on the other objects/working systems around
    them.  
*/

var object = argument0;

print("set_objState(" + string(object_get_name(object.object_index)) + ")");
//print(string(object.x) + ", " + string(object.y));

switch (object_get_name(object.object_index)){
    case "obj_trigger": //if there's an obj on this trigger, the door shouldn't be visible
        //if (scr_tileContains(object.x, object.y, array(par_obstacle, par_robot, par_pullable)) && object.triggerDoorPtr != undefined){
        if (scr_tileContains(object.x, object.y, array(par_obstacle, par_robot, par_pullable))){  
            object.triggerDoorPtr.image_index = TRIGGER_PRESSED;
            //print("TRIGGER PRESSED");
        }
        else{
            object.triggerDoorPtr.image_index = TRIGGER_NOT_PRESSED;
            //print("TRIGGER NOT PRESSED");
        }
        break;
}
