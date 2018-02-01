///handle_gameMove(par_robot robot);

var robot = argument0;

print("HANDLE GAME MOVE");
var objMove = false;

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
                //print("pushed stateHistory");
                //print(state+","+targetDirection);
            }
            if (object_get_name(object_index) == "obj_key" || 
                object_get_name(object_index) == "obj_door"){
                ds_stack_push(stateHistory, currentState);
                
                if (object_get_name(object_index) == "obj_door") && (x == global.DEACTIVATED_X) && (y == global.DEACTIVATED_Y){
                    currentState = "unlocked";
                    print("state now " + string(currentState));
                }
                
                if (object_get_name(object_index) == "obj_key" && (x == global.DEACTIVATED_X) && (y == global.DEACTIVATED_Y))  {
                    currentState = "inventory";
                    print("state now " + string(currentState));
                }
            }
        }
        else{ 
            justDeactivated = false; 
        }
        //handle falling platforms
        if (isFallingPlatform){
            //print("in falling plat");
            //print(robot.oldPlayerX);
            //print(robot.oldPlayerY);
            ds_stack_push(stateHistory, stepsLeft);
            if (robot.oldPlayerX == x && robot.oldPlayerY == y){
                //print(stepsLeft);
                stepsLeft--;
                image_index++;
                //print(stepsLeft);
                if (stepsLeft == 0){
                    isDeactivated = true;
                }
            }
        }
        if (isArrow){
            if (isRotating){
                switch(dir){
                    case "up":
                        dir = "right";
                        break;
                    case "right":
                        dir = "down";
                        break;
                    case "down":
                        dir = "left";
                        break;
                    case "left":
                        dir = "up";
                        break;
                }
                sprite_index = asset_get_index("spr_arrow_" + dir);
                print("done rotate");
            }
        }
        
        //eviscerator check
        if (instance_place(x, y, par_robot) && isEviscerator){
            print("ded player");
            obj_player.isDead = true;
            obj_player.sprite_index = spr_playerDead;
        }
        
        //this is a trigger being pressed
        if ((instance_place(x, y, par_pullable) || instance_place(x, y, par_robot)) && triggerDoorPtr != undefined){
            //object.triggerDoorPtr.image_index = 1;
            if (object.triggerDoorPtr.deactivatedX == undefined &&
                object.triggerDoorPtr.deactivatedY == undefined)
            {
                print("Yeah it's undefined duh");
                object.triggerDoorPtr.deactivatedX = object.triggerDoorPtr.x;
                object.triggerDoorPtr.deactivatedY = object.triggerDoorPtr.y;
                object.triggerDoorPtr.x = global.DEACTIVATED_X;
                object.triggerDoorPtr.y = global.DEACTIVATED_Y;
            } 
            
            object.triggerDoorPtr.isDeactivated = true;
            print("trigger pressed; trigger door is deactivated");
            
            object.triggerDoorPtr.image_index = 1;
        }
        
        //this is a trigger not being pressed
        if ((!instance_place(x, y, par_pullable) && !instance_place(x, y, par_robot)) && triggerDoorPtr != undefined){
            object.triggerDoorPtr.isDeactivated = false;
            if (object.triggerDoorPtr.x == global.DEACTIVATED_X && 
                object.triggerDoorPtr.y == global.DEACTIVATED_Y)
            {
                object.triggerDoorPtr.x = object.triggerDoorPtr.deactivatedX;
                object.triggerDoorPtr.y = object.triggerDoorPtr.deactivatedY;
                object.triggerDoorPtr.deactivatedX = undefined;
                object.triggerDoorPtr.deactivatedY = undefined;
            }
            //print("WARNING!!! TRIGGER DOOR ACTIVATED");
            if (instance_place(robot.x, robot.y, obj_triggerDoor)){
                //obj_player.isDead = true; //:(
                //obj_player.sprite_index = spr_playerDead;
            } 
            object.triggerDoorPtr.image_index = 0;
        }
        
        if (instance_place(x, y, obj_snare)) {
            //isDeactivated = true;
            print("Obj has been deactivated (snared)");
            print(isSpike);
            continue;
        }
        
        
        
// DIFFERENT TYPES OF MOVEMENT BEGIN
        


        //handle movement for spike object
        if (object.isSpike){
            //check if spike has already during player's turn and not roberta's
            if (!object.spikeMoved || object_get_name(robot.object_index) == "obj_player"){
                if (targetLocked){
                    print("TARGET IS LOCKED");
                    state = "active";
                    switch (targetDirection){
                        case "up": 
                            print("up"); 
                            if (scr_canPullPush(x, y-global.TILE_SIZE, false, robot)){
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
                            if (scr_canPullPush(x, y+global.TILE_SIZE, false, robot)){
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
                            if (scr_canPullPush(x-global.TILE_SIZE, y, false, robot)){
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
                            if (scr_canPullPush(x+global.TILE_SIZE, y, false, robot)){
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
                            if (scr_canPullPush(x+global.TILE_SIZE, y-global.TILE_SIZE, true, robot)){
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
                            if (scr_canPullPush(x-global.TILE_SIZE, y-global.TILE_SIZE, true, robot)){
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
                            if (scr_canPullPush(x+global.TILE_SIZE, y+global.TILE_SIZE, true, robot)){
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
                            if (scr_canPullPush(x-global.TILE_SIZE, y+global.TILE_SIZE, true, robot)){
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
                        if (robot.x < x && scr_canPullPush(x - global.TILE_SIZE, y, false, robot)) {
                            state = "active";
                            targetDirection = "left"; 
                            targetLocked = true;
                            sprite_index = spr_spikeActive;
                            object.spikeMoved = true;
                            print("target just locked");
                        }
                        else if (robot.x > x && scr_canPullPush(x + global.TILE_SIZE, y, false, robot)) {
                            state = "active";
                            targetDirection = "right"; 
                            targetLocked = true;
                            object.spikeMoved = true;
                            sprite_index = spr_spikeActive;
                        }
                    }
                    else if (robot.x == x){
                        if (robot.y < y && scr_canPullPush(x, y - global.TILE_SIZE, false, robot)) {
                            state = "active";
                            targetDirection = "up"; 
                            targetLocked = true;
                            object.spikeMoved = true;
                            sprite_index = spr_spikeActive;
                        }
                        else if (robot.y > y && scr_canPullPush(x, y + global.TILE_SIZE, false, robot)) {
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
                    
                        if (scr_canPullPush(newObjPosX, newObjPosY, true, robot)
                        && abs((robot.y - y) / (robot.x - x)) == 1){
                            
                            print("diag lockon baby");
                            //print(obj_player.x - robot.oldPlayerX);
                            //print(obj_player.y - robot.oldPlayerY);
                        
                            if (robot.y < y && robot.x > x){ //player is above the obj and to the right
                                //x += global.TILE_SIZE;
                                //y -= global.TILE_SIZE;
                                state = "active";
                                targetDirection = "upright"; 
                                targetLocked = true;
                                object.spikeMoved = true;
                                sprite_index = spr_spikeActive;
                            }
                            if (robot.y < y && robot.x < x){ //player is above the obj and to the left
                                //x -= global.TILE_SIZE;
                                //y -= global.TILE_SIZE; 
                                state = "active";
                                targetDirection = "upleft"; 
                                targetLocked = true;
                                object.spikeMoved = true;
                                sprite_index = spr_spikeActive;
                            }
                            if (robot.y > y && robot.x > x){ //player is below the obj and to the right
                                //x += global.TILE_SIZE;
                                //y += global.TILE_SIZE; 
                                state = "active";
                                targetDirection = "downright"; 
                                targetLocked = true;
                                object.spikeMoved = true;
                                sprite_index = spr_spikeActive;
                            }
                            if (robot.y > y && robot.x < x){ //player is below the obj and to the left
                                //x -= global.TILE_SIZE;
                                //y += global.TILE_SIZE;
                                state = "active";
                                targetDirection = "downleft"; 
                                targetLocked = true;
                                object.spikeMoved = true;
                                sprite_index = spr_spikeActive;
                            }
                        }
                    }
                } //end targetlock check
                
                //dead check
                if (instance_place(x, y, par_robot) && isSpike){
                    print("ded player");
                    robot.isDead = true;
                    robot.sprite_index = spr_playerDead;
                }
                
                if !targetLocked sprite_index = spr_spike;
            }
            else{
                object.spikeMoved = false; //allow spike to move next handle_gameMove
            }
            
        } //end spike logic
        
        
        
        //handle pushPull blocks
        if ((canPull || canPush) && !isSpike){
            //print("Pushed onto object's stack !");
            //print(x); print(y);
            var pushPull = 1;
            
            //figure out which way to push/pull
            if (canPush && canPull){
                if (robot.y - robot.oldPlayerY > 0){ //player moved down
                    if (y > robot.y) pushPull *=-1;
                }
                if (robot.x - robot.oldPlayerX > 0){ //player moved right
                    if (x > robot.x) pushPull *=-1;
                }
                if (robot.x - robot.oldPlayerX < 0){ //player moved left
                    if (x < robot.x) pushPull *=-1;
                }
                if (robot.y - robot.oldPlayerY < 0){ //player moved up
                    if (y < robot.y) pushPull *=-1;
                }
            }
            //push only
            else if (canPush) pushPull *= -1;
            if (robot.oldPlayerY == y && robot.y == y){ //player moved left/right
                print("push/pull left/right");
                //print(x - (global.TILE_SIZE*pushPull));
                if (robot.x < x && scr_canPullPush(x - (global.TILE_SIZE*pushPull), y, false, robot)) {//player on left side of object 
                    x -= (global.TILE_SIZE*pushPull);
                    objMove = true;
                    print("Move is true left");
                }
                else if (robot.x > x && scr_canPullPush(x + (global.TILE_SIZE*pushPull), y, false, robot)){//player on right side of object
                    x += (global.TILE_SIZE*pushPull);
                    objMove = true;
                    print("Move is true right");
                }
            }
            if (robot.oldPlayerX == x && robot.x == x){ //player moved up/down
                print("let's maybe pull this shit");
                if (robot.y < y && scr_canPullPush(x, y - (global.TILE_SIZE*pushPull), false, robot)){ //player above object 
                    y -= (global.TILE_SIZE*pushPull);
                    objMove = true;
                    print("pulling");
                }
                else if (robot.y > y && scr_canPullPush(x, y + (global.TILE_SIZE*pushPull), false, robot)){//player below object 
                    print("push/pull updown");
                    y += (global.TILE_SIZE*pushPull);
                    objMove = true;
                }
            }
            var objRelYPos = 1;
            var objRelXPos = -1;
            if (robot.y < y) objRelYPos *= -1;
            if (robot.x > x) objRelXPos *= -1;
            //print(objRelXPos)
            
            var xDiff = robot.x - robot.oldPlayerX;
            var yDiff = robot.y - robot.oldPlayerY;
            var newObjPosX = 0; 
            var newObjPosY = 0;
            
            if (canPull && canPush){
                if (robot.y < y && robot.x > x){ //player is above the obj and to the right
                    //print("up and to the right");
                    if (xDiff < 0) pushPull *= -1;
                }
                if (robot.y < y && robot.x < x){ //player is above the obj and to the left
                    if (xDiff > 0) pushPull *=-1;
                }
                if (robot.y > y && robot.x > x){ //player is below the obj and to the right
                    if (yDiff < 0) pushPull *=-1;
                }
                if (robot.y > y && robot.x < x){ //player is below the obj and to the left
                    if (yDiff < 0) pushPull *=-1;
                }
            }
            
            if (robot.y < y && robot.x > x){ //player is above the obj and to the right
            //print("up and to the right");
                newObjPosX = x + (global.TILE_SIZE * pushPull);
                newObjPosY = y - (global.TILE_SIZE * pushPull);
            }
            if (robot.y < y && robot.x < x){ //player is above the obj and to the left
                newObjPosX = x - (global.TILE_SIZE * pushPull);
                newObjPosY = y - (global.TILE_SIZE * pushPull);
            }
            if (robot.y > y && robot.x > x){ //player is below the obj and to the right
                newObjPosX = x + (global.TILE_SIZE * pushPull);
                newObjPosY = y + (global.TILE_SIZE * pushPull);
            }
            if (robot.y > y && robot.x < x){ //player is below the obj and to the left
                newObjPosX = x - (global.TILE_SIZE * pushPull);
                newObjPosY = y + (global.TILE_SIZE * pushPull);
            }
            
            //print("hur-----");
            //print(robot.x)
            //print(robot.y)
            //print(robot.oldPlayerX);
            //print(robot.oldPlayerY);
            //print(newObjPosX);
            //print(newObjPosY);
            //print("-----dur");
            
            
            if (!objMove  
                && (robot.x - robot.oldPlayerX != 0) 
                && (robot.y - robot.oldPlayerY != 0) 
                && scr_canPullPush(newObjPosX, newObjPosY, true, robot)
                && abs((robot.y - y) / (robot.x - x)) == 1
                && abs((robot.oldPlayerY - y) / (robot.oldPlayerX - x)) == 1){
                    
                //print("diag time baby");
                //print(robot.x - robot.oldPlayerX);
                //print(robot.y - robot.oldPlayerY);
                
                if (robot.y < y && robot.x > x){ //player is above the obj and to the right
                    x += (global.TILE_SIZE * pushPull);
                    y -= (global.TILE_SIZE * pushPull);
                }
                if (robot.y < y && robot.x < x){ //player is above the obj and to the left
                    x -= (global.TILE_SIZE * pushPull);
                    y -= (global.TILE_SIZE * pushPull); 
                }
                if (robot.y > y && robot.x > x){ //player is below the obj and to the right
                    x += (global.TILE_SIZE * pushPull);
                    y += (global.TILE_SIZE * pushPull); 
                }
                if (robot.y > y && robot.x < x){ //player is below the obj and to the left
                    x -= (global.TILE_SIZE * pushPull);
                    y += (global.TILE_SIZE * pushPull);
                }
                objMove = true;
            }
            
            /*if (!objMove && canFall && instance_place(x, y, obj_hole)){
                //print("and this object falls down");
                sprite_index = spr_key;
                isDeactivated = true;
                justDeactivated = true;
                deactivatedX = x;
                deactivatedY = y;
                ds_stack_push(moveHistory, string(x) + "," + string(y));
                x = 0;
                y = 0;
            }*/
            //else if (!instance_place(x, y, obj_hole) && canFall){
            //    sprite_index = spr_key;
            //    //print("no hole");
            //}
            else if(instance_place(x, y, obj_hole) && canFall){
                //print("HOLE");
                sprite_index = spr_keyFloating;
                image_speed = .3;
            }
        } //end pull/push check
    }
}

handle_prioritizeItems();

moved = false;
