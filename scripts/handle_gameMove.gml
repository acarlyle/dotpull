///handle_gameMove(par_robot robot);

var robot = argument0;

print("HANDLE GAME MOVE");

//for (var i = 0; i < array_length_1d(global.roomContents); i++){
//    var object = global.roomContents[i];
//    print(object_get_name(object.object_index));
//}

for (var i = 0; i < array_length_1d(global.roomContents); i++){
    var object = global.roomContents[i];
    with(object){
        
        print("Handling " + object_get_name(object.object_index));
        if (!justDeactivated){ // ACTUALLY NOT JUST DEACTIVATED !!!
            ds_stack_push(moveHistory, string(x) + "," + string(y)); //pushing previous turn's movement
            //print("pushed");
            if (isSpike){
                ds_stack_push(stateHistory, state + "," + targetDirection);
                print("pushed spike stateHistory: " + string(state) + "," + string(targetDirection));
            }
            if (object_get_name(object_index) == "obj_key" || 
                object_get_name(object_index) == "obj_door"){
                ds_stack_push(stateHistory, currentState);
                
                if (object_get_name(object_index) == "obj_door") && (x == global.DEACTIVATED_X) && (y == global.DEACTIVATED_Y){
                    currentState = "unlocked";
                    //print("state now " + string(currentState));
                }
                
                if (object_get_name(object_index) == "obj_key" && (x == global.DEACTIVATED_X) && (y == global.DEACTIVATED_Y))  {
                    currentState = "inventory";
                    //print("state now " + string(currentState));
                }
            }
        }
        else{ 
            justDeactivated = false; 
        }
        
        //this is a trigger being pressed
        if ((instance_place(x, y, par_pullable) || instance_place(x, y, par_robot)) && triggerDoorPtr != undefined){
            //object.triggerDoorPtr.image_index = 1;
            if (object.triggerDoorPtr.deactivatedX == undefined &&
                object.triggerDoorPtr.deactivatedY == undefined)
            {
                //print("Yeah it's undefined duh");
                object.triggerDoorPtr.deactivatedX = object.triggerDoorPtr.x;
                object.triggerDoorPtr.deactivatedY = object.triggerDoorPtr.y;
                object.triggerDoorPtr.x = global.DEACTIVATED_X;
                object.triggerDoorPtr.y = global.DEACTIVATED_Y;
            } 
            
            object.triggerDoorPtr.isDeactivated = true;
            //print("TRIGGERDOOR IS DEACTIVATED VALUE: " + string(object.triggerDoorPtr.isDeactivated));
            print("trigger pressed; trigger door is deactivated");
            
            object.triggerDoorPtr.image_index = 1;
        }
        
        //this is a trigger not being pressed
        if ((!instance_place(x, y, par_pullable) && !instance_place(x, y, par_robot)) && triggerDoorPtr != undefined){
            object.triggerDoorPtr.isDeactivated = false;
            print("TRIGGERDOOR IS DEACTIVATED VALUE: " + string(object.triggerDoorPtr.isDeactivated));
            if (object.triggerDoorPtr.x == global.DEACTIVATED_X && 
                object.triggerDoorPtr.y == global.DEACTIVATED_Y)
            {
                object.triggerDoorPtr.x = object.triggerDoorPtr.deactivatedX;
                object.triggerDoorPtr.y = object.triggerDoorPtr.deactivatedY;
                object.triggerDoorPtr.deactivatedX = undefined;
                object.triggerDoorPtr.deactivatedY = undefined;
            }
            print("TRIGGER DOOR NOT BEING PRESSED,  TRIGGER DOOR ACTIVATED");
            object.triggerDoorPtr.image_index = 0;
        }
        
// DIFFERENT TYPES OF MOVEMENT BEGIN

        //If object is on top of a snare, don't do anything with it
        if (instance_place(x, y, obj_snare)) {
            continue;
        }
        //eviscerator check
        if (isEviscerator){
            move_eviscerator(object, robot);
        }
        //Handles: par_arrow
        if (isArrow){
           move_arrow(object);
        }
        //Handles: falling platforms
        if (isFallingPlatform){
            move_fallingPlatform(object, robot);
        }
        //Handles: obj_spike
        if (object.isSpike){
            move_spike(object, robot);
        }
        //Handles: par_block, obj_key
        if ((canPull || canPush) && !isSpike){
            move_pullPushables(object, robot);
        }
    }
}

handle_prioritizeItems();

moved = false;
