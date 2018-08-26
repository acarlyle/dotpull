///scr_collisionCheck(obj_layer layer, int posX, int posY, par_robot robot)

var layer = argument0;
var posX = argument1;
var posY = argument2;
var robot = argument3; 

if (map_place(layer, obj_spike, posX, posY)){
    print("ded player");
    obj_player.isDead = true;
    obj_player.sprite_index = spr_playerDead;
    return true;
}

if (map_place(layer, par_stairs, posX, posY)){ return false; }

if (map_place(layer, par_pusher, posX, posY)){
    move_pusher(layer, robot, map_place(layer, par_pusher, posX, posY));
}

if (map_place(layer, posX, posY, par_pickupable)){
    scr_pickupObject(map_place(layer, par_pickupable, posX, posY));
}

if (map_place(layer, obj_mirptr, posX, posY)){
    var mirptr = map_place(layer, obj_mirptr, posX, posY);
    print("old robo x: " + string(robot.x));
    var roboXDiff = posX - robot.playerX; 
    var roboYDiff = posY - robot.playerY; 
    if !scr_collisionCheck(layer, mirptr.mirptrPtr.x + roboXDiff, mirptr.mirptrPtr.y + roboYDiff, robot){
        robot.playerX += (mirptr.mirptrPtr.x + roboXDiff) - mirptr.x;
        robot.playerY += (mirptr.mirptrPtr.y + roboYDiff) - mirptr.y;
        print("PROBLEM: Recursive call, new robot x, y: " + string(robot.playerX) + " " + string(robot.playerY));
    }
    else{
        return true;
    }
    
    
    robot.playerX = mirptr.mirptrPtr.x;
    robot.playerY = mirptr.mirptrPtr.y;
    print("mirptr collision in player move");
    print(mirptr.mirptrPtr.x);
}

if (map_place(layer, par_obstacle, posX, posY)){
    var obstacle = map_place(layer, par_obstacle, posX, posY);
    if (!obstacle.isDeactivated) return true; //obstacle will block your path
}

//print("numkeys");
//print(obj_player.numKeys);
if (map_place(layer, obj_door, posX, posY)){
    if (numKeys > 0){ //there's a DOOR here, try to unlock
        door = map_place(layer, obj_door, posX, posY);
        with (door){
            //instance_destroy(); //unlock door by removing it woah
            obj_player.numKeys--;
            //print(obj_player.numKeys);
            isDeactivated = true;
            justDeactivated = true;
            deactivatedX = x;
            deactivatedY = y;
            ds_stack_push(moveHistory, string(x) + "," + string(y));
            ds_stack_push(stateHistory, "locked");
            x = global.DEACTIVATED_X;
            y = global.DEACTIVATED_Y;
            currentState = "unlocked";
        }
        return false;
    }
    else{
        currentState = "locked";
        print("No keys: " + string(obj_player.numKeys));
        return true;
    }
}
//print("numnkeys end");
if (map_place(layer, obj_key, posX, posY)){
    key = map_place(layer, obj_key, posX, posY);
    with (key){
        audio_play_sound(snd_keyPickup, 10, false);
        obj_player.numKeys++;
        currentState = "inventory";
        isDeactivated = true;
        justDeactivated = true;
        deactivatedX = x;
        deactivatedY = y;
        ds_stack_push(moveHistory, string(x) + "," + string(y));
        ds_stack_push(stateHistory, "ground");
        //ds_stack_push(obj_player.itemHistory, array(obj_player.numKeys - 1));
        x = global.DEACTIVATED_X;
        y = global.DEACTIVATED_Y;
        //image_index = 1;
        //ds_stack_pop(moveHistory);
        //ds_stack_pop(moveHistory);
    }
    return false;
}

print("numkeys: " + string(obj_player.numKeys));
if (map_place(layer, par_block, posX, posY)){
    print("There's a block here");
    return true; //there's a block here
}
if (map_place(layer, obj_hole, posX, posY)){
    //print("There's a hole here");
    return true; //there's a block here
}
if (map_place(layer, obj_trigger, posX, posY)){
    //print("There's a trigger here");
    return false; //there's a block here
}
if (map_place(layer, obj_triggerDoor, posX, posY)){
    //print("There's a triggerDoor here");
    var door = map_place(layer, obj_triggerDoor, posX, posY);
    if (!door.isDeactivated) return true; //triggerDoor will block your path
    return false; //there's a block here
}
if (map_place(layer, par_wall, posX, posY)){
    wall = map_place(layer, par_wall, posX, posY);
    if (wall.isDeactivated){
        return false; //there's a wall here but it's deactivated, you may walk
    }
    else{
        return true; //there's a wall here
    }
}
if (map_place(layer, par_platform, posX, posY)){
    var platform = map_place(layer, par_platform, posX, posY);
    if (platform.isFallingPlatform){
        if (platform.stepsLeft <= 0){
            return true; //you can't walk here, the platform has fallen and the city is lost
        }
    }
    if (map_place(layer, obj_dialogueTrigger, posX, posY)){
        var dialogueTrigger = map_place(layer, obj_dialogueTrigger, posX, posY);
        dialogueTrigger.activated = true;
    }
    return false; //there's a platform here, good to take a stroll on
}
if (map_place(layer, par_fallingPlatform, posX, posY)){
    var platform = map_place(layer, par_fallingPlatform, posX, posY);
    if (platform.stepsLeft <= 0){
        return true; //you can't walk here, the platform has fallen and the city is lost
    }
    if (platform.isDeactivated){
        return false;
    }
}

print("scr_collisionCheck: cannot move to: " + string(posX) +","+string(posY));

return true; //there's probably something there anyways
