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
        
        //push this objects previous position onto its stack
        if (!justDeactivated){
            handle_pushOntoStack(object);
        }
        else{ 
            object.justDeactivated = false; 
        } 
        
        
        /*
            HANDLE DIFFERENT TYPES OF OBJECT MOVEMENTS
        */


        //If object is on top of a snare, don't do anything with it
        if (instance_place(x, y, obj_snare)) {
            continue;
        }
        //Handles: obj_trigger, obj_triggerDoor
        if (triggerDoorPtr != undefined){
            move_trigger(object, robot);
        }
        //Handles: obj_eviscerator
        if (isEviscerator){
            move_eviscerator(object, robot);
        }
        //Handles: par_arrow
        if (isArrow){
            move_arrow(object);
        }
        //Handles: par_fallingPlatform
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
