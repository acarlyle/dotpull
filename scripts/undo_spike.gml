///undo_spike(obj_enum spike)

/*
    Handles undo for this spike obj
*/

var spike = argument0;

var spikeStateStr = ds_stack_pop(spike[| OBJECT.STATEHISTORY]);
if (spikeStateStr != undefined){
    print ("UNDOING SPIK");
    print(spikeStateStr);
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
    else if (stateStr == "active"){
        print("Statestr was active ... ??");
        spike.targetLocked = true;
        spike.state = "active";
        spike.targetDirection = stateDir;
        sprite_index = spr_spikeActive;
    }
}
//print("self state: " + string(self.state));
//print("obj state: " + string(obj.state));
//print("self direction: " + string(self.targetDirection));
//print("obj direction: " + string(obj.targetDirection));
