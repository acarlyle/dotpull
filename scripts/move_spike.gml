///move_spike(obj_layer layer, par_layer layer, enum spikeObj)

/*
    This function handles:
    obj_spike
*/

var layer = argument0;
var spike = argument1;

var robot = layer.robot;

var mirptrExt = false; //TODO -> haven't implemented spike logic w/ mirptrs yet

//check if spike has already during player's turn and not roberta's
if (!spike[| OBJECT.MOVED] || robot[| OBJECT.NAME] == "obj_player"){
    if (spike[| AI.TARGETLOCKED]){
        //print("TARGET IS LOCKED AT " + string(spike[| OBJECT.MOVEDDIR]));
        spike[| OBJECT.STATE] = "active";
        switch (spike[| OBJECT.MOVEDDIR]){
            case "up": 
                print("up"); 
                if (scr_canPullPush(spike[| OBJECT.X], spike[| OBJECT.Y]-global.TILE_SIZE, false, spike, robot, mirptrExt, layer)){
                    spike[| OBJECT.Y] -= global.TILE_SIZE;
                }
                else{
                    spike[| OBJECT.IMGIND] = 0;
                    spike[| AI.TARGETLOCKED] = false;
                    spike[| OBJECT.MOVEDDIR] = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike[| OBJECT.MOVED] = true;
                break;
            case "down": 
                print("down"); 
                if (scr_canPullPush(spike[| OBJECT.X], spike[| OBJECT.Y]+global.TILE_SIZE, false, spike, robot, mirptrExt, layer)){
                    spike[| OBJECT.Y]+=global.TILE_SIZE;
                }
                else{
                    spike[| OBJECT.IMGIND] = 0;
                    spike[| AI.TARGETLOCKED] = false;
                    spike[| OBJECT.MOVEDDIR] = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike[| OBJECT.MOVED] = true;
                break;
            case "left": 
                print("left"); 
                if (scr_canPullPush(spike[| OBJECT.X]-global.TILE_SIZE, spike[| OBJECT.Y], false, spike, robot, mirptrExt, layer)){
                    spike[| OBJECT.X]-=global.TILE_SIZE;
                }
                else{
                    spike[| OBJECT.IMGIND] = 0;
                    spike[| AI.TARGETLOCKED] = false;
                    spike[| OBJECT.MOVEDDIR] = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike[| OBJECT.MOVED] = true;
                break;
            case "right": 
                print("right"); 
                if (scr_canPullPush(spike[| OBJECT.X]+global.TILE_SIZE, spike[| OBJECT.Y], false, spike, robot, mirptrExt, layer)){
                    spike[| OBJECT.X]+=global.TILE_SIZE;
                }
                else{
                    spike[| OBJECT.IMGIND] = 0;
                    spike[| AI.TARGETLOCKED] = false;
                    spike[| OBJECT.MOVEDDIR] = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike[| OBJECT.MOVED] = true;
                break;
            case "upright": 
                print("upright"); 
                if (scr_canPullPush(spike[| OBJECT.X]+global.TILE_SIZE, spike[| OBJECT.Y]-global.TILE_SIZE, true, spike, robot, mirptrExt, layer)){
                    spike[| OBJECT.X]+=global.TILE_SIZE;
                    spike[| OBJECT.Y]-=global.TILE_SIZE;
                }
                else{
                    spike[| OBJECT.IMGIND] = 0;
                    spike[| AI.TARGETLOCKED] = false;
                    spike[| OBJECT.MOVEDDIR] = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike[| OBJECT.MOVED] = true;
                break;
            case "upleft": 
                print("upleft"); 
                if (scr_canPullPush(spike[| OBJECT.X]-global.TILE_SIZE, spike[| OBJECT.Y]-global.TILE_SIZE, true, spike, robot, mirptrExt, layer)){
                    spike[| OBJECT.X]-=global.TILE_SIZE;
                    spike[| OBJECT.Y]-=global.TILE_SIZE;
                }
                else{
                    print("could not upleft pull");
                    spike[| OBJECT.IMGIND] = 0;
                    spike[| AI.TARGETLOCKED] = false;
                    spike[| OBJECT.MOVEDDIR] = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike[| OBJECT.MOVED] = true;
                break;
            case "downright": 
                print("downright"); 
                if (scr_canPullPush(spike[| OBJECT.X]+global.TILE_SIZE, spike[| OBJECT.Y]+global.TILE_SIZE, true, spike, robot, mirptrExt, layer)){
                    spike[| OBJECT.X]+=global.TILE_SIZE;
                    spike[| OBJECT.Y]+=global.TILE_SIZE;
                }
                else{
                    spike[| OBJECT.IMGIND] = 0;
                    spike[| AI.TARGETLOCKED] = false;
                    spike[| OBJECT.MOVEDDIR] = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike[| OBJECT.MOVED] = true;
                break;
            case "downleft": 
                print("downleft"); 
                if (scr_canPullPush(spike[| OBJECT.X]-global.TILE_SIZE, spike[| OBJECT.Y]+global.TILE_SIZE, true, spike, robot, mirptrExt, layer)){
                    spike[| OBJECT.X]-=global.TILE_SIZE;
                    spike[| OBJECT.Y]+=global.TILE_SIZE;
                }
                else{
                    spike[| OBJECT.IMGIND] = 0;
                    spike[| AI.TARGETLOCKED] = false;
                    spike[| OBJECT.MOVEDDIR] = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike[| OBJECT.MOVED] = true;
                break;
        }
    }
    else{ //check if player in line for target lock
        spike[| OBJECT.STATE] = "idle";
        print("check for player lock");
        if (robot[| OBJECT.Y] == spike[| OBJECT.Y]){
            if (robot[| OBJECT.X] < spike[| OBJECT.X] && (scr_canPullPush(spike[| OBJECT.X] - global.TILE_SIZE, spike[| OBJECT.Y], false, spike, robot, mirptrExt, layer)
                             || scr_objectsAdjacent(robot, spike))) {
                spike[| OBJECT.STATE] = "active";
                spike[| OBJECT.MOVEDDIR] = "left"; 
                spike[| AI.TARGETLOCKED] = true;
                spike[| OBJECT.IMGIND] = 1;
                spike[| OBJECT.MOVED] = true;
            }
            else if (robot[| OBJECT.X] > spike[| OBJECT.X] && (scr_canPullPush(spike[| OBJECT.X] + global.TILE_SIZE, spike[| OBJECT.Y], false, spike, robot, mirptrExt, layer)
                                  || scr_objectsAdjacent(robot, spike))) {
                spike[| OBJECT.STATE] = "active";
                spike[| OBJECT.MOVEDDIR] = "right"; 
                spike[| AI.TARGETLOCKED] = true;
                spike[| OBJECT.MOVED] = true;
                spike[| OBJECT.IMGIND] = 1;
            }
        }
        else if (robot[| OBJECT.X] == spike[| OBJECT.X]){
            if (robot[| OBJECT.Y] < spike[| OBJECT.Y] && (scr_canPullPush(spike[| OBJECT.X], spike[| OBJECT.Y] - global.TILE_SIZE, false, spike, robot, mirptrExt, layer)
                             || scr_objectsAdjacent(robot, spike))) {
                spike[| OBJECT.STATE] = "active";
                spike[| OBJECT.MOVEDDIR] = "up"; 
                spike[| AI.TARGETLOCKED] = true;
                spike[| OBJECT.MOVED] = true;
                spike[| OBJECT.IMGIND] = 1;
            }
            else if (robot[| OBJECT.Y] > spike[| OBJECT.Y] && (scr_canPullPush(spike[| OBJECT.X], spike[| OBJECT.Y] + global.TILE_SIZE, false, spike, robot, mirptrExt, layer)
                                  || scr_objectsAdjacent(robot, spike))) {
                spike[| OBJECT.STATE] = "active";
                spike[| OBJECT.MOVEDDIR] = "down"; 
                spike[| AI.TARGETLOCKED] = true;
                spike[| OBJECT.MOVED] = true;
                spike[| OBJECT.IMGIND] = 1;
            }
        }
        if (spike[| OBJECT.CANPULL]){
            //diag checking
            var objRelYPos = 1;
            var objRelXPos = -1;
            var newObjPosX = 0;
            var newObjPosY = 0;
            //print("diag checking");
            if (robot[| OBJECT.Y] < spike[| OBJECT.Y]) objRelYPos *= -1;
            if (robot[| OBJECT.X] > spike[| OBJECT.X]) objRelXPos *= -1;
            
            if (robot[| OBJECT.Y] < spike[| OBJECT.Y] && robot[| OBJECT.X] < spike[| OBJECT.X]){
                newObjPosX = spike[| OBJECT.X] - global.TILE_SIZE;
                newObjPosY = spike[| OBJECT.Y] - global.TILE_SIZE;
            }
            if (robot[| OBJECT.Y] > spike[| OBJECT.Y] && robot[| OBJECT.X] < spike[| OBJECT.X]){
                newObjPosX = spike[| OBJECT.X] - global.TILE_SIZE;
                newObjPosY = spike[| OBJECT.Y] + global.TILE_SIZE;
            }
            if (robot[| OBJECT.Y] > spike[| OBJECT.Y] && robot[| OBJECT.X] > spike[| OBJECT.X]){
                newObjPosX = spike[| OBJECT.X] + global.TILE_SIZE;
                newObjPosY = spike[| OBJECT.Y] + global.TILE_SIZE;
            }
            if (robot[| OBJECT.Y] < spike[| OBJECT.Y] && robot[| OBJECT.X] > spike[| OBJECT.X]){
                newObjPosX = spike[| OBJECT.X] + global.TILE_SIZE;
                newObjPosY = spike[| OBJECT.Y] - global.TILE_SIZE;
            }
        
            if ((scr_canPullPush(newObjPosX, newObjPosY, true, spike, robot, mirptrExt, layer) || scr_objectsAdjacent(robot, spike))
            && abs((robot[| OBJECT.Y] - spike[| OBJECT.Y]) / (robot[| OBJECT.X] - spike[| OBJECT.X])) == 1){
                
                print("diag lockon baby");

            
                if (robot[| OBJECT.Y] < spike[| OBJECT.Y] && robot[| OBJECT.X] > spike[| OBJECT.X]){ //player is above the obj and to the right
                    spike[| OBJECT.STATE] = "active";
                    spike[| OBJECT.MOVEDDIR] = "upright"; 
                    spike[| AI.TARGETLOCKED] = true;
                    spike[| OBJECT.MOVED] = true;
                    spike[| OBJECT.IMGIND] = 1;
                }
                if (robot[| OBJECT.Y] < spike[| OBJECT.Y] && robot[| OBJECT.X] < spike[| OBJECT.X]){ //player is above the obj and to the left
                    spike[| OBJECT.STATE] = "active";
                    spike[| OBJECT.MOVEDDIR] = "upleft"; 
                    spike[| AI.TARGETLOCKED] = true;
                    spike[| OBJECT.MOVED] = true;
                    spike[| OBJECT.IMGIND] = 1;
                }
                if (robot[| OBJECT.Y] > spike[| OBJECT.Y] && robot[| OBJECT.X] > spike[| OBJECT.X]){ //player is below the obj and to the right
                    spike[| OBJECT.STATE] = "active";
                    spike[| OBJECT.MOVEDDIR] = "downright"; 
                    spike[| AI.TARGETLOCKED] = true;
                    spike[| OBJECT.MOVED] = true;
                    spike[| OBJECT.IMGIND] = 1;
                }
                if (robot[| OBJECT.Y] > spike[| OBJECT.Y] && robot[| OBJECT.X] < spike[| OBJECT.X]){ //player is below the obj and to the left
                    spike[| OBJECT.STATE] = "active";
                    spike[| OBJECT.MOVEDDIR] = "downleft"; 
                    spike[| AI.TARGETLOCKED] = true;
                    spike[| OBJECT.MOVED] = true;
                    spike[| OBJECT.IMGIND] = 1;
                }
            }
        }
    } //end targetlock check
    print("spike_targetDir: " + string(spike[| OBJECT.MOVEDDIR]));
    print("spike_spike[| AI.TARGETLOCKED]: " + string(spike[| AI.TARGETLOCKED]));
    print("spike_state: " + string(spike[| OBJECT.STATE]));
    
    if !spike[| AI.TARGETLOCKED] spike[| OBJECT.IMGIND] = 0; //passive img index
}
else{
    spike[| OBJECT.MOVED] = false; //allow spike to move next handle_gameMove
}
