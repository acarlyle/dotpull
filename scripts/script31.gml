///undo_spike(par_robot robot)

/*
    Handles undo for this spike obj
*/

spike = argument0;

var spikeStateStr = ds_stack_pop(stateHistory);
if (spikeStateStr != undefined){
    print ("UNDOING SPIK");
    print(spikeStateStr);
    var stateArr = scr_split(spikeStateStr);
    var stateStr = stateArr[0];
    var stateDir = stateArr[1];
    if (stateStr == "idle"){
        targetLocked = false;
        self.state = stateStr;
        targetDirection = "idling";
        sprite_index = spr_spike;
    }
    else if (stateStr == "active"){
        print("Statestr was active ... ??");
        targetLocked = true;
        self.state = "active";
        targetDirection = stateDir;
        sprite_index = spr_spikeActive;
    }
}
//print("self state: " + string(self.state));
//print("obj state: " + string(obj.state));
//print("self direction: " + string(self.targetDirection));
//print("obj direction: " + string(obj.targetDirection));
