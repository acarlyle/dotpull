///undo_cannon(par_cannon cannon)

/*
    Handles undo for this cannon obj
*/

cannon = argument0;

var cannonStateStr = ds_stack_pop(cannon.stateHistory);
if (cannonStateStr != undefined){
    print ("UNDOING CANNON");
    print(cannonStateStr);
    var stateArr = scr_split(cannonStateStr);
    var stateStr = stateArr[0];
    var stateDir = stateArr[1];
    
    /*switch(stateStr){
        case "idling":
            cannon.state = "idling";
            break;
        case "charging":
            cannon.state = "charging";
            break;
        case "firing":
            cannon.state = "charging";
            break;
    }*/
    cannon.state = stateStr;
    cannon.shotDirection = stateDir;
    var isVert = false;
    var isHorz = false;
    if (cannon.shotDirection == "up" || cannon.shotDirection == "down"){
        isVert = true;
        isHorz = false;
    }
    else{
        isHorz = true;
        isVert = false;
    }
    if (cannon.state == "firing"){
        e_fireCannon(cannon, isVert, isHorz); 
    }
}
