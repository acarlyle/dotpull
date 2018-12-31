///undo_trigger(obj_enum trigger)

/*
    Handles undo for this trigger obj
*/

var trigger = argument0;

//this is a trigger being pressed
if ((map_place(layer, par_pullable, trigger[| OBJECT.X], trigger[| OBJECT.Y]) || map_place(layer, par_robot, trigger[| OBJECT.X], trigger[| OBJECT.Y])) && 
    trigger[| TRIGGER.DOORPTR] != undefined)
{
    var doorPtr = trigger[| DOORPTR];
    doorPtr[| OBJECT.IMGIND] = 1;
    doorPtr[| OBJECT.ISACTIVE] = false;
}
//this is a trigger not being pressed
if ((!map_place(layer, par_pullable, trigger[| OBJECT.X], trigger[| OBJECT.Y]) && !map_place(layer, par_robot, trigger[| OBJECT.X], trigger[| OBJECT.Y])) && 
    trigger[| TRIGGER.DOORPTR] != undefined)
    { 
    var doorPtr = trigger[| DOORPTR];
    doorPtr[| OBJECT.IMGIND] = 0;
    doorPtr[| OBJECT.ISACTIVE] = true;
}
