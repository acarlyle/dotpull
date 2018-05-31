///handle_pushOntoStack(var robot, bool pushCurPos)

print(" -> handle_pushOntoStack ");

var robot = argument0; //could be player or other character 
var pushCurPos = argument1;  //whether to push the cur obj pos or the old one
var pushX = 0;
var pushY = 0;

for (var i = 0; i < array_length_1d(global.roomContents); i++){
    var object = global.roomContents[i];
    with(object){
        
        print("Handling push for " + object_get_name(object.object_index));
        object.oldPosX = object.x;
        object.oldPosY = object.y; 
        //if objectIs(object) == "obj_block" print("_OLD POS oldx, oldy: " + string(object.oldPosX) + ", " + string(object.oldPosY));
        
        //push this objects previous position onto its stack
        //This is true if an object has been moved to the DEACTIVATED_X/Y Zone off screen and was pushed already
        if (object.justDeactivated){
            object.justDeactivated = false; 
            continue;
        }
        
        if (pushCurPos){ pushX = object.x; pushY = object.y; }
        else{ pushX = object.oldPosX; pushY = object.oldPosY; }
        
        //if (objectIs(object) == "obj_block") print("_PUSHING x, y: " + string(pushX) + ", " + string(pushY));
        
        ds_stack_push(object.moveHistory, string(pushX) + "," + string(pushY)); //pushing previous turn's movement
        
        if (objectStr(object) == "obj_spike"){
            ds_stack_push(object.stateHistory, object.state + "," + object.targetDirection);
            //print("pushed spike stateHistory: " + string(object.state) + "," + string(object.targetDirection));
        }
        if (object_get_name(object_index) == "obj_key" || 
            object_get_name(object_index) == "obj_door" ||
            object_get_name(object_index) == "obj_baby") {
            ds_stack_push(object.stateHistory, object.currentState);
            
            if (object_get_name(object_index) == "obj_door") && (object.x == global.DEACTIVATED_X) && (object.y == global.DEACTIVATED_Y){
                object.currentState = "unlocked";
                //print("state now " + string(currentState));
            }
            
            if (object_get_name(object_index) == "obj_key" && (object.x == global.DEACTIVATED_X) && (object.y == global.DEACTIVATED_Y))  {
                object.currentState = "inventory";
                //print("state now " + string(currentState));
            }
        }
        if (parentOf(object) == "par_breakableWall"){
            ds_stack_push(object.stateHistory, object.hitsLeft);
        }
        
        if (object.canPull || object.canPush){
            ds_stack_push(object.movedDirHistory, object.movedDir);
        }
    }
}
