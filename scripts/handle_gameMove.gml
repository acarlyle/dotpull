///handle_gameMove();

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
        }
        else{ 
            justDeactivated = false; 
        }
        //handle falling platforms
        if (isFallingPlatform){
            print("in falling plat");
            print(global.oldPlayerX);
            print(global.oldPlayerY);
            ds_stack_push(stateHistory, stepsLeft);
            if (global.oldPlayerX == x && global.oldPlayerY == y){
                print(stepsLeft);
                stepsLeft--;
                image_index++;
                print(stepsLeft);
                if (stepsLeft == 0){
                    isDeactivated = true;
                }
            }
        }
        
        //this is a trigger being pressed
        if ((instance_place(x, y, par_pullable) || instance_place(x, y, obj_player)) && triggerDoorPtr != undefined){
            object.triggerDoorPtr.image_index = 1;
            object.triggerDoorPtr.isDeactivated = true;
            //print("trigger pressed; trigger door is deactivated");
        }
        
        //this is a trigger not being pressed
        if ((!instance_place(x, y, par_pullable) && !instance_place(x, y, obj_player)) && triggerDoorPtr != undefined){
            object.triggerDoorPtr.image_index = 0;
            object.triggerDoorPtr.isDeactivated = false;
            //print("WARNING!!! TRIGGER DOOR ACTIVATED");
            if (instance_place(obj_player.x, obj_player.y, obj_triggerDoor)){
                //obj_player.isDead = true; //:(
                //obj_player.sprite_index = spr_playerDead;
            } 
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
            if (targetLocked){
                print("TARGET IS LOCKED");
                state = "active";
                switch (targetDirection){
                    case "up": 
                        print("up"); 
                        if (scr_canPullPush(x, y-global.TILE_SIZE, false)){
                            y-=global.TILE_SIZE;
                        }
                        else{
                            sprite_index = spr_spike;
                            targetLocked = false;
                            targetDirection = "idling";
                            state = "idle";
                        }
                        break;
                    case "down": 
                        print("down"); 
                        if (scr_canPullPush(x, y+global.TILE_SIZE, false)){
                            y+=global.TILE_SIZE;
                        }
                        else{
                            sprite_index = spr_spike;
                            targetLocked = false;
                            targetDirection = "idling";
                            state = "idle";
                        }
                        break;
                    case "left": 
                        print("left"); 
                        if (scr_canPullPush(x-global.TILE_SIZE, y, false)){
                            x-=global.TILE_SIZE;
                        }
                        else{
                            sprite_index = spr_spike;
                            targetLocked = false;
                            targetDirection = "idling";
                            state = "idle";
                        }
                        break;
                    case "right": 
                        print("right"); 
                        if (scr_canPullPush(x+global.TILE_SIZE, y, false)){
                            x+=global.TILE_SIZE;
                        }
                        else{
                            sprite_index = spr_spike;
                            targetLocked = false;
                            targetDirection = "idling";
                            state = "idle";
                        }
                        break;
                    case "upright": 
                        print("upright"); 
                        if (scr_canPullPush(x+global.TILE_SIZE, y-global.TILE_SIZE, true)){
                            x+=global.TILE_SIZE;
                            y-=global.TILE_SIZE;
                        }
                        else{
                            sprite_index = spr_spike;
                            targetLocked = false;
                            targetDirection = "idling";
                            state = "idle";
                        }
                        break;
                    case "upleft": 
                        print("upleft"); 
                        if (scr_canPullPush(x-global.TILE_SIZE, y-global.TILE_SIZE, true)){
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
                        break;
                    case "downright": 
                        print("downright"); 
                        if (scr_canPullPush(x+global.TILE_SIZE, y+global.TILE_SIZE, true)){
                            x+=global.TILE_SIZE;
                            y+=global.TILE_SIZE;
                        }
                        else{
                            sprite_index = spr_spike;
                            targetLocked = false;
                            targetDirection = "idling";
                            state = "idle";
                        }
                        break;
                    case "downleft": 
                        print("downleft"); 
                        if (scr_canPullPush(x-global.TILE_SIZE, y+global.TILE_SIZE, true)){
                            x-=global.TILE_SIZE;
                            y+=global.TILE_SIZE;
                        }
                        else{
                            sprite_index = spr_spike;
                            targetLocked = false;
                            targetDirection = "idling";
                            state = "idle";
                        }
                        break;
                }
            }
            else{ //check if player in line for target lock
                //print("checking for player lock");
                state = "idle";
                //print("check for player lock");
                if (obj_player.y == y){
                    if (obj_player.x < x && scr_canPullPush(x - global.TILE_SIZE, y, false)) {
                        state = "active";
                        targetDirection = "left"; 
                        targetLocked = true;
                        sprite_index = spr_spikeActive;
                        print("target just locked");
                    }
                    else if (obj_player.x > x && scr_canPullPush(x + global.TILE_SIZE, y, false)) {
                        state = "active";
                        targetDirection = "right"; 
                        targetLocked = true;
                        sprite_index = spr_spikeActive;
                    }
                }
                else if (obj_player.x == x){
                    if (obj_player.y < y && scr_canPullPush(x, y - global.TILE_SIZE, false)) {
                        state = "active";
                        targetDirection = "up"; 
                        targetLocked = true;
                        sprite_index = spr_spikeActive;
                    }
                    else if (obj_player.y > y && scr_canPullPush(x, y + global.TILE_SIZE, false)) {
                        state = "active";
                        targetDirection = "down"; 
                        targetLocked = true;
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
                    if (obj_player.y < y) objRelYPos *= -1;
                    if (obj_player.x > x) objRelXPos *= -1;
                    
                    if (obj_player.y < y && obj_player.x < x){
                        newObjPosX = x - global.TILE_SIZE;
                        newObjPosY = y - global.TILE_SIZE;
                    }
                    if (obj_player.y > y && obj_player.x < x){
                        newObjPosX = x - global.TILE_SIZE;
                        newObjPosY = y + global.TILE_SIZE;
                    }
                    if (obj_player.y > y && obj_player.x > x){
                        newObjPosX = x + global.TILE_SIZE;
                        newObjPosY = y + global.TILE_SIZE;
                    }
                    if (obj_player.y < y && obj_player.x > x){
                        newObjPosX = x + global.TILE_SIZE;
                        newObjPosY = y - global.TILE_SIZE;
                    }
                
                    if (scr_canPullPush(newObjPosX, newObjPosY, true)
                    && abs((obj_player.y - y) / (obj_player.x - x)) == 1){
                        
                        print("diag lockon baby");
                        //print(obj_player.x - global.oldPlayerX);
                        //print(obj_player.y - global.oldPlayerY);
                    
                        if (obj_player.y < y && obj_player.x > x){ //player is above the obj and to the right
                            //x += global.TILE_SIZE;
                            //y -= global.TILE_SIZE;
                            state = "active";
                            targetDirection = "upright"; 
                            targetLocked = true;
                            sprite_index = spr_spikeActive;
                        }
                        if (obj_player.y < y && obj_player.x < x){ //player is above the obj and to the left
                            //x -= global.TILE_SIZE;
                            //y -= global.TILE_SIZE; 
                            state = "active";
                            targetDirection = "upleft"; 
                            targetLocked = true;
                            sprite_index = spr_spikeActive;
                        }
                        if (obj_player.y > y && obj_player.x > x){ //player is below the obj and to the right
                            //x += global.TILE_SIZE;
                            //y += global.TILE_SIZE; 
                            state = "active";
                            targetDirection = "downright"; 
                            targetLocked = true;
                            sprite_index = spr_spikeActive;
                        }
                        if (obj_player.y > y && obj_player.x < x){ //player is below the obj and to the left
                            //x -= global.TILE_SIZE;
                            //y += global.TILE_SIZE;
                            state = "active";
                            targetDirection = "downleft"; 
                            targetLocked = true;
                            sprite_index = spr_spikeActive;
                        }
                    }
                }
            } //end targetlock check
            
            if (instance_place(x, y, obj_player) && isSpike){
                print("ded player");
                obj_player.isDead = true;
                obj_player.sprite_index = spr_playerDead;
            }
            
            if !targetLocked sprite_index = spr_spike;
            
        } //end spike logic
        
        //handle pushPull blocks
        if (canPull || canPush){
            //print("Pushed onto object's stack !");
            //print(x); print(y);
            var pushPull = 1;
            
            //figure out which way to push/pull
            if (canPush && canPull){
                if (obj_player.y - global.oldPlayerY > 0){ //player moved down
                    if (y > obj_player.y) pushPull *=-1;
                }
                if (obj_player.x - global.oldPlayerX > 0){ //player moved right
                    if (x > obj_player.x) pushPull *=-1;
                }
                if (obj_player.x - global.oldPlayerX < 0){ //player moved left
                    if (x < obj_player.x) pushPull *=-1;
                }
                if (obj_player.y - global.oldPlayerY < 0){ //player moved up
                    if (y < obj_player.y) pushPull *=-1;
                }
            }
            //push only
            else if (canPush) pushPull *= -1;
            if (global.oldPlayerY == y && obj_player.y == y){ //player moved left/right
                print("push/pull left/right");
                print(x - (global.TILE_SIZE*pushPull));
                if (obj_player.x < x && scr_canPullPush(x - (global.TILE_SIZE*pushPull), y, false)) {//player on left side of object 
                    x -= (global.TILE_SIZE*pushPull);
                    objMove = true;
                    print("Move is true");
                }
                else if (obj_player.x > x && scr_canPullPush(x + (global.TILE_SIZE*pushPull), y, false)){//player on right side of object
                    x += (global.TILE_SIZE*pushPull);
                    objMove = true;
                }
            }
            if (global.oldPlayerX == x && obj_player.x == x){ //player moved up/down
                //print("let's pull this shit");
                if (obj_player.y < y && scr_canPullPush(x, y - (global.TILE_SIZE*pushPull), false)){ //player above object 
                    y -= (global.TILE_SIZE*pushPull);
                    objMove = true;
                    //print("pulling");
                }
                else if (obj_player.y > y && scr_canPullPush(x, y + (global.TILE_SIZE*pushPull), false)){//player below object 
                    y += (global.TILE_SIZE*pushPull);
                    objMove = true;
                }
            }
            var objRelYPos = 1;
            var objRelXPos = -1;
            if (obj_player.y < y) objRelYPos *= -1;
            if (obj_player.x > x) objRelXPos *= -1;
            //print(objRelXPos)
            
            var xDiff = obj_player.x - global.oldPlayerX;
            var yDiff = obj_player.y - global.oldPlayerY;
            var newObjPosX = 0; 
            var newObjPosY = 0;
            
            if (canPull && canPush){
                if (obj_player.y < y && obj_player.x > x){ //player is above the obj and to the right
                    //print("up and to the right");
                    if (xDiff < 0) pushPull *= -1;
                }
                if (obj_player.y < y && obj_player.x < x){ //player is above the obj and to the left
                    if (xDiff > 0) pushPull *=-1;
                }
                if (obj_player.y > y && obj_player.x > x){ //player is below the obj and to the right
                    if (yDiff < 0) pushPull *=-1;
                }
                if (obj_player.y > y && obj_player.x < x){ //player is below the obj and to the left
                    if (yDiff < 0) pushPull *=-1;
                }
            }
            
            if (obj_player.y < y && obj_player.x > x){ //player is above the obj and to the right
            //print("up and to the right");
                newObjPosX = x + (global.TILE_SIZE * pushPull);
                newObjPosY = y - (global.TILE_SIZE * pushPull);
            }
            if (obj_player.y < y && obj_player.x < x){ //player is above the obj and to the left
                newObjPosX = x - (global.TILE_SIZE * pushPull);
                newObjPosY = y - (global.TILE_SIZE * pushPull);
            }
            if (obj_player.y > y && obj_player.x > x){ //player is below the obj and to the right
                newObjPosX = x + (global.TILE_SIZE * pushPull);
                newObjPosY = y + (global.TILE_SIZE * pushPull);
            }
            if (obj_player.y > y && obj_player.x < x){ //player is below the obj and to the left
                newObjPosX = x - (global.TILE_SIZE * pushPull);
                newObjPosY = y + (global.TILE_SIZE * pushPull);
            }
            
            print("hur-----");
            //print(obj_player.x)
            //print(obj_player.y)
            //print(global.oldPlayerX);
            //print(global.oldPlayerY);
            print(newObjPosX);
            print(newObjPosY);
            print("-----dur");
            
            
            if (!objMove  
                && (obj_player.x - global.oldPlayerX != 0) 
                && (obj_player.y - global.oldPlayerY != 0) 
                && scr_canPullPush(newObjPosX, newObjPosY, true)
                && abs((obj_player.y - y) / (obj_player.x - x)) == 1
                && abs((global.oldPlayerY - y) / (global.oldPlayerX - x)) == 1){
                    
                //print("diag time baby");
                //print(obj_player.x - global.oldPlayerX);
                //print(obj_player.y - global.oldPlayerY);
                
                if (obj_player.y < y && obj_player.x > x){ //player is above the obj and to the right
                    x += (global.TILE_SIZE * pushPull);
                    y -= (global.TILE_SIZE * pushPull);
                }
                if (obj_player.y < y && obj_player.x < x){ //player is above the obj and to the left
                    x -= (global.TILE_SIZE * pushPull);
                    y -= (global.TILE_SIZE * pushPull); 
                }
                if (obj_player.y > y && obj_player.x > x){ //player is below the obj and to the right
                    x += (global.TILE_SIZE * pushPull);
                    y += (global.TILE_SIZE * pushPull); 
                }
                if (obj_player.y > y && obj_player.x < x){ //player is below the obj and to the left
                    x -= (global.TILE_SIZE * pushPull);
                    y += (global.TILE_SIZE * pushPull);
                }
                objMove = true;
            }
            
            if (!objMove && canFall && instance_place(x, y, obj_hole)){
                //print("and this object falls down");
                sprite_index = spr_key;
                isDeactivated = true;
                justDeactivated = true;
                deactivatedX = x;
                deactivatedY = y;
                ds_stack_push(moveHistory, string(x) + "," + string(y));
                x = 0;
                y = 0;
            }
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

moved = false;
