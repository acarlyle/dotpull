///undo_cannon(obj_layer layer, obj_enum cannon)

/*
    Handles undo for this cannon obj
*/

var layer = argument0;
var cannon = argument0;

var cannonStateStr = ds_stack_pop(cannon[| OBJECT.STATEHISTORY]);
if (cannonStateStr != undefined){
    print ("UNDOING CANNON");
    var stateArr = scr_split(cannonStateStr, ",");
    var stateStr = stateArr[0];
    var stateDir = stateArr[1];

    cannon[| OBJECT.STATE] = stateStr;
    cannon[| AI.TARGETDIR] = stateDir;
    
    var isVert = false;
    var isHorz = false;
    if (cannon[| AI.TARGETDIR] == "up" || cannon[| AI.TARGETDIR]  == "down"){
        isVert = true;
        isHorz = false;
    }
    else{
        isHorz = true;
        isVert = false;
    }
    if (cannon[| OBJECT.STATE]  == "fired"){
        e_fireCannon(layer, cannon, isVert, isHorz); 
    }
}
