///undo_door(obj_layer layer, obj_enum triggerDoor)

/*
    Handles undo for this triggerDoor obj
*/

var layer = argument0;
var triggerDoor = argument1;

// Door is not activated; something is on the switch
if (!triggerDoor[| OBJECT.ISACTIVE])
{
    if (!scr_tileContains(layer, triggerDoor[| OBJECT.X], triggerDoor[! OBJECT.Y], array(par_pullable, par_robot)))
    {  
        triggerDoor[| OBJECT.ISACTIVE] = true;
    }
}
