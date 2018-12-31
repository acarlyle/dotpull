///undo_spike(obj_enum spike)

/*
    Handles undo for this spike obj
*/

var spike = argument0;

var spikeStateStr = ds_stack_pop(spike[| OBJECT.STATEHISTORY]);
if (spikeStateStr != undefined){
    var stateArr = scr_split(spikeStateStr, ",");
    var stateStr = stateArr[0];
    var stateDir = stateArr[1];
    if (stateStr == "idle")
    {
        spike[| OBJECT.STATE] = stateStr;
        spike[| AI.TARGETLOCKED] = false;
        spike[| AI.TARGETDIR] = "idling";
        spike[| OBJECT.IMGIND] = 0;
    }
    else if (stateStr == "active")
    {
        spike[| AI.TARGETLOCKED] = true;
        spike[| OBJECT.STATE] = "active";
        spike[| AI.TARGETDIR]  = stateDir;
        spike[| OBJECT.IMGIND] = 1;
    }
}
