///move_spike(obj_spike spike, par_robot robot)

/*
    This function handles:
    obj_spike
*/

object = argument0;
robot = argument1;

var mirptrExt = false; //TODO

//check if spike has already during player's turn and not roberta's
if (!object.spikeMoved || object_get_name(robot.object_index) == "obj_player"){
    if (targetLocked){
        //print("TARGET IS LOCKED AT " + string(targetDirection));
        state = "active";
        switch (targetDirection){
            case "up": 
                print("up"); 
                if (scr_canPullPush(x, y-global.TILE_SIZE, false, object, robot, mirptrExt)){
                    y-=global.TILE_SIZE;
                }
                else{
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    state = "idle";
                }
                object.spikeMoved = true;
                break;
            case "down": 
                print("down"); 
                if (scr_canPullPush(x, y+global.TILE_SIZE, false, object, robot, mirptrExt)){
                    y+=global.TILE_SIZE;
                }
                else{
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    state = "idle";
                }
                object.spikeMoved = true;
                break;
            case "left": 
                print("left"); 
                if (scr_canPullPush(x-global.TILE_SIZE, y, false, object, robot, mirptrExt)){
                    x-=global.TILE_SIZE;
                }
                else{
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    state = "idle";
                }
                object.spikeMoved = true;
                break;
            case "right": 
                print("right"); 
                if (scr_canPullPush(x+global.TILE_SIZE, y, false, object, robot, mirptrExt)){
                    x+=global.TILE_SIZE;
                }
                else{
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    state = "idle";
                }
                object.spikeMoved = true;
                break;
            case "upright": 
                print("upright"); 
                if (scr_canPullPush(x+global.TILE_SIZE, y-global.TILE_SIZE, true, object, robot, mirptrExt)){
                    x+=global.TILE_SIZE;
                    y-=global.TILE_SIZE;
                }
                else{
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    state = "idle";
                }
                object.spikeMoved = true;
                break;
            case "upleft": 
                print("upleft"); 
                if (scr_canPullPush(x-global.TILE_SIZE, y-global.TILE_SIZE, true, object, robot, mirptrExt)){
                    x-=global.TILE_SIZE;
                    y-=global.TILE_SIZE;
                }
                else{
                    print("could not upleft pull");
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    state = "idle";
                }
                object.spikeMoved = true;
                break;
            case "downright": 
                print("downright"); 
                if (scr_canPullPush(x+global.TILE_SIZE, y+global.TILE_SIZE, true, object, robot, mirptrExt)){
                    x+=global.TILE_SIZE;
                    y+=global.TILE_SIZE;
                }
                else{
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    state = "idle";
                }
                object.spikeMoved = true;
                break;
            case "downleft": 
                print("downleft"); 
                if (scr_canPullPush(x-global.TILE_SIZE, y+global.TILE_SIZE, true, object, robot, mirptrExt)){
                    x-=global.TILE_SIZE;
                    y+=global.TILE_SIZE;
                }
                else{
                    sprite_index = spr_spike;
                    targetLocked = false;
                    targetDirection = "idling";
                    state = "idle";
                }
                object.spikeMoved = true;
                break;
        }
    }
    else{ //check if player in line for target lock
        //print("checking for player lock");
        state = "idle";
        //print("check for player lock");
        if (robot.y == y){
            if (robot.x < x && scr_canPullPush(x - global.TILE_SIZE, y, false, object, robot, mirptrExt)) {
                state = "active";
                targetDirection = "left"; 
                targetLocked = true;
                sprite_index = spr_spikeActive;
                object.spikeMoved = true;
                //print("target just locked");
            }
            else if (robot.x > x && scr_canPullPush(x + global.TILE_SIZE, y, false, object, robot, mirptrExt)) {
                state = "active";
                targetDirection = "right"; 
                targetLocked = true;
                object.spikeMoved = true;
                sprite_index = spr_spikeActive;
            }
        }
        else if (robot.x == x){
            if (robot.y < y && scr_canPullPush(x, y - global.TILE_SIZE, false, object, robot, mirptrExt)) {
                state = "active";
                targetDirection = "up"; 
                targetLocked = true;
                object.spikeMoved = true;
                sprite_index = spr_spikeActive;
            }
            else if (robot.y > y && scr_canPullPush(x, y + global.TILE_SIZE, false, object, robot, mirptrExt)) {
                state = "active";
                targetDirection = "down"; 
                targetLocked = true;
                object.spikeMoved = true;
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
            if (robot.y < y) objRelYPos *= -1;
            if (robot.x > x) objRelXPos *= -1;
            
            if (robot.y < y && robot.x < x){
                newObjPosX = x - global.TILE_SIZE;
                newObjPosY = y - global.TILE_SIZE;
            }
            if (robot.y > y && robot.x < x){
                newObjPosX = x - global.TILE_SIZE;
                newObjPosY = y + global.TILE_SIZE;
            }
            if (robot.y > y && robot.x > x){
                newObjPosX = x + global.TILE_SIZE;
                newObjPosY = y + global.TILE_SIZE;
            }
            if (robot.y < y && robot.x > x){
                newObjPosX = x + global.TILE_SIZE;
                newObjPosY = y - global.TILE_SIZE;
            }
        
            if (scr_canPullPush(newObjPosX, newObjPosY, true, object, robot, mirptrExt)
            && abs((robot.y - y) / (robot.x - x)) == 1){
                
                print("diag lockon baby");

            
                if (robot.y < y && robot.x > x){ //player is above the obj and to the right
                    state = "active";
                    targetDirection = "upright"; 
                    targetLocked = true;
                    object.spikeMoved = true;
                    sprite_index = spr_spikeActive;
                }
                if (robot.y < y && robot.x < x){ //player is above the obj and to the left
                    state = "active";
                    targetDirection = "upleft"; 
                    targetLocked = true;
                    object.spikeMoved = true;
                    sprite_index = spr_spikeActive;
                }
                if (robot.y > y && robot.x > x){ //player is below the obj and to the right
                    state = "active";
                    targetDirection = "downright"; 
                    targetLocked = true;
                    object.spikeMoved = true;
                    sprite_index = spr_spikeActive;
                }
                if (robot.y > y && robot.x < x){ //player is below the obj and to the left
                    state = "active";
                    targetDirection = "downleft"; 
                    targetLocked = true;
                    object.spikeMoved = true;
                    sprite_index = spr_spikeActive;
                }
            }
        }
    } //end targetlock check
    print(obj_spike.targetDirection);
    print(obj_spike.targetLocked);
    print(obj_spike.state);
    print("hereweGO");
    
    //dead check
    if (scr_tileContains(x, y, array(par_robot)) && isSpike){
        print("ded player");
        robot.isDead = true;
        robot.sprite_index = spr_playerDead;
    }
    
    if !targetLocked sprite_index = spr_spike;
}
else{
    object.spikeMoved = false; //allow spike to move next handle_gameMove
}
