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
if (!spike.spikeMoved || object_get_name(robot.object_index) == "obj_player"){
    if (targetLocked){
        //print("TARGET IS LOCKED AT " + string(targetDirection));
        spike[| OBJECT.STATE] = "active";
        switch (targetDirection){
            case "up": 
                print("up"); 
                if (scr_canPullPush(spike[| OBJECT.X], spike[| OBJECT.Y]-global.TILE_SIZE, false, spike, robot, mirptrExt, layer)){
                    spike[| OBJECT.Y]-=global.TILE_SIZE;
                }
                else{
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike.spikeMoved = true;
                break;
            case "down": 
                print("down"); 
                if (scr_canPullPush(spike[| OBJECT.X], spike[| OBJECT.Y]+global.TILE_SIZE, false, spike, robot, mirptrExt, layer)){
                    y+=global.TILE_SIZE;
                }
                else{
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike.spikeMoved = true;
                break;
            case "left": 
                print("left"); 
                if (scr_canPullPush(spike[| OBJECT.X]-global.TILE_SIZE, spike[| OBJECT.Y], false, spike, robot, mirptrExt, layer)){
                    spike[| OBJECT.X]-=global.TILE_SIZE;
                }
                else{
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike.spikeMoved = true;
                break;
            case "right": 
                print("right"); 
                if (scr_canPullPush(spike[| OBJECT.X]+global.TILE_SIZE, spike[| OBJECT.Y], false, spike, robot, mirptrExt, layer)){
                    spike[| OBJECT.X]+=global.TILE_SIZE;
                }
                else{
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike.spikeMoved = true;
                break;
            case "upright": 
                print("upright"); 
                if (scr_canPullPush(spike[| OBJECT.X]+global.TILE_SIZE, spike[| OBJECT.Y]-global.TILE_SIZE, true, spike, robot, mirptrExt, layer)){
                    spike[| OBJECT.X]+=global.TILE_SIZE;
                    spike[| OBJECT.Y]-=global.TILE_SIZE;
                }
                else{
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike.spikeMoved = true;
                break;
            case "upleft": 
                print("upleft"); 
                if (scr_canPullPush(spike[| OBJECT.X]-global.TILE_SIZE, spike[| OBJECT.Y]-global.TILE_SIZE, true, spike, robot, mirptrExt, layer)){
                    spike[| OBJECT.X]-=global.TILE_SIZE;
                    spike[| OBJECT.Y]-=global.TILE_SIZE;
                }
                else{
                    print("could not upleft pull");
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike.spikeMoved = true;
                break;
            case "downright": 
                print("downright"); 
                if (scr_canPullPush(spike[| OBJECT.X]+global.TILE_SIZE, spike[| OBJECT.Y]+global.TILE_SIZE, true, spike, robot, mirptrExt, layer)){
                    spike[| OBJECT.X]+=global.TILE_SIZE;
                    spike[| OBJECT.Y]+=global.TILE_SIZE;
                }
                else{
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike.spikeMoved = true;
                break;
            case "downleft": 
                print("downleft"); 
                if (scr_canPullPush(x-global.TILE_SIZE, y+global.TILE_SIZE, true, spike, robot, mirptrExt, layer)){
                    spike[| OBJECT.X]-=global.TILE_SIZE;
                    spike[| OBJECT.Y]+=global.TILE_SIZE;
                }
                else{
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    spike[| OBJECT.STATE] = "idle";
                }
                spike.spikeMoved = true;
                break;
        }
    }
    else{ //check if player in line for target lock
        spike[| OBJECT.STATE] = "idle";
        print("check for player lock");
        if (robot.y == spike[| OBJECT.Y]){
            if (robot.x < spike[| OBJECT.X] && (scr_canPullPush(spike[| OBJECT.X] - global.TILE_SIZE, spike[| OBJECT.Y], false, spike, robot, mirptrExt, layer)
                             || scr_objectsAdjacent(robot, spike))) {
                spike[| OBJECT.STATE] = "active";
                targetDirection = "left"; 
                targetLocked = true;
                sprite_index = spr_spikeActive;
                spike.spikeMoved = true;
            }
            else if (robot.x > spike[| OBJECT.X] && (scr_canPullPush(x + global.TILE_SIZE, spike[| OBJECT.Y], false, spike, robot, mirptrExt, layer)
                                  || scr_objectsAdjacent(robot, spike))) {
                spike[| OBJECT.STATE] = "active";
                targetDirection = "right"; 
                targetLocked = true;
                spike.spikeMoved = true;
                sprite_index = spr_spikeActive;
            }
        }
        else if (robot.x == spike[| OBJECT.X]){
            if (robot.y < spike[| OBJECT.Y] && (scr_canPullPush(spike[| OBJECT.X], spike[| OBJECT.Y] - global.TILE_SIZE, false, spike, robot, mirptrExt, layer)
                             || scr_objectsAdjacent(robot, spike))) {
                spike[| OBJECT.STATE] = "active";
                targetDirection = "up"; 
                targetLocked = true;
                spike.spikeMoved = true;
                sprite_index = spr_spikeActive;
            }
            else if (robot.y > spike[| OBJECT.Y] && (scr_canPullPush(spike[| OBJECT.X], spike[| OBJECT.Y] + global.TILE_SIZE, false, spike, robot, mirptrExt, layer)
                                  || scr_objectsAdjacent(robot, spike))) {
                spike[| OBJECT.STATE] = "active";
                targetDirection = "down"; 
                targetLocked = true;
                spike.spikeMoved = true;
                sprite_index = spr_spikeActive;
            }
        }
        if (canPull){
            //diag checking
            var objRelYPos = 1;
            var objRelXPos = -1;
            var newObjPosX = 0;
            var newObjPosY = 0;
            //print("diag checking");
            if (robot.y < spike[| OBJECT.Y]) objRelYPos *= -1;
            if (robot.x > spike[| OBJECT.X]) objRelXPos *= -1;
            
            if (robot.y < spike[| OBJECT.Y] && robot.x < spike[| OBJECT.X]){
                newObjPosX = spike[| OBJECT.X] - global.TILE_SIZE;
                newObjPosY = spike[| OBJECT.Y] - global.TILE_SIZE;
            }
            if (robot.y > spike[| OBJECT.Y] && robot.x < spike[| OBJECT.X]){
                newObjPosX = spike[| OBJECT.X] - global.TILE_SIZE;
                newObjPosY = spike[| OBJECT.Y] + global.TILE_SIZE;
            }
            if (robot.y > spike[| OBJECT.Y] && robot.x > spike[| OBJECT.X]){
                newObjPosX = spike[| OBJECT.X] + global.TILE_SIZE;
                newObjPosY = spike[| OBJECT.Y] + global.TILE_SIZE;
            }
            if (robot.y < spike[| OBJECT.Y] && robot.x > spike[| OBJECT.X]){
                newObjPosX = spike[| OBJECT.X] + global.TILE_SIZE;
                newObjPosY = spike[| OBJECT.Y] - global.TILE_SIZE;
            }
        
            if (scr_canPullPush(newObjPosX, newObjPosY, true, spike, robot, mirptrExt, layer)
            && abs((robot.y - spike[| OBJECT.Y]) / (robot.x - spike[| OBJECT.X])) == 1){
                
                print("diag lockon baby");

            
                if (robot.y < spike[| OBJECT.Y] && robot.x > spike[| OBJECT.X]){ //player is above the obj and to the right
                    spike[| OBJECT.STATE] = "active";
                    targetDirection = "upright"; 
                    targetLocked = true;
                    spike.spikeMoved = true;
                    sprite_index = spr_spikeActive;
                }
                if (robot.y < spike[| OBJECT.Y] && robot.x < spike[| OBJECT.X]){ //player is above the obj and to the left
                    spike[| OBJECT.STATE] = "active";
                    targetDirection = "upleft"; 
                    targetLocked = true;
                    spike.spikeMoved = true;
                    sprite_index = spr_spikeActive;
                }
                if (robot.y > spike[| OBJECT.Y] && robot.x > spike[| OBJECT.X]){ //player is below the obj and to the right
                    spike[| OBJECT.STATE] = "active";
                    targetDirection = "downright"; 
                    targetLocked = true;
                    spike.spikeMoved = true;
                    sprite_index = spr_spikeActive;
                }
                if (robot.y > spike[| OBJECT.Y] && robot.x < spike[| OBJECT.X]){ //player is below the obj and to the left
                    spike[| OBJECT.STATE] = "active";
                    targetDirection = "downleft"; 
                    targetLocked = true;
                    spike.spikeMoved = true;
                    sprite_index = spr_spikeActive;
                }
            }
        }
    } //end targetlock check
    print("spike_targetDir: " + string(obj_spike.targetDirection));
    print("spike_targetLocked: " + string(obj_spike.targetLocked));
    print("spike_state: " + string(obj_spike.state));
    
    //dead check
    if (scr_tileContains(layer, x, y, array(par_robot)) && objectStr(self) == "obj_spike"){
        print("ded player");
        robot.isDead = true;
        robot.sprite_index = spr_playerDead;
    }
    
    if !targetLocked sprite_index = spr_spike;
}
else{
    spike.spikeMoved = false; //allow spike to move next handle_gameMove
}
