///scr_collisionCheck(int posX, int posY)

if (instance_place(argument0, argument1, obj_spike)){
    print("ded player");
    obj_player.isDead = true;
    obj_player.sprite_index = spr_playerDead;
    return true;
}

if (instance_place(argument0, argument1, par_obstacle)){
    var obstacle = instance_place(argument0, argument1, par_obstacle);
    if (!obstacle.isDeactivated) return true; //obstacle will block your path
}

//print("numkeys");
//print(obj_player.numKeys);
if (instance_place(argument0, argument1, obj_door)){
    if (numKeys > 0){ //there's a DOOR here, try to unlock
        door = instance_place(argument0, argument1, obj_door);
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
if (instance_place(argument0, argument1, obj_key)){
    key = instance_place(argument0, argument1, obj_key);
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
if (instance_place(argument0, argument1, par_block)){
    print("There's a block here");
    return true; //there's a block here
}
if (instance_place(argument0, argument1, obj_hole)){
    //print("There's a hole here");
    return true; //there's a block here
}
if (instance_place(argument0, argument1, obj_trigger)){
    //print("There's a trigger here");
    return false; //there's a block here
}
if (instance_place(argument0, argument1, obj_triggerDoor)){
    //print("There's a triggerDoor here");
    var door = instance_place(argument0, argument1, obj_triggerDoor);
    if (!door.isDeactivated) return true; //triggerDoor will block your path
    return false; //there's a block here
}
if (instance_place(argument0, argument1, par_wall)){
    wall = instance_place(argument0, argument1, par_wall);
    if (wall.isDeactivated){
        return false; //there's a wall here but it's deactivated, you may walk
    }
    else{
        return true; //there's a wall here
    }
}
if (instance_place(argument0, argument1, par_platform)){
    var platform = instance_place(argument0, argument1, par_platform);
    if (platform.isFallingPlatform){
        if (platform.stepsLeft <= 0){
            return true; //you can't walk here, the platform has fallen and the city is lost
        }
    }
    if (instance_place(argument0, argument1, obj_dialogueTrigger)){
        var dialogueTrigger = instance_place(argument0, argument1, obj_dialogueTrigger);
        dialogueTrigger.activated = true;
    }
    return false; //there's a platform here, good to take a stroll on
}
if (instance_place(argument0, argument1, par_fallingPlatform)){
    var platform = instance_place(argument0, argument1, par_fallingPlatform);
    if (platform.stepsLeft <= 0){
        return true; //you can't walk here, the platform has fallen and the city is lost
    }
    if (platform.isDeactivated){
        return false;
    }
}

print("cannot move to ");
print(argument0);
print(argument1);

return true; //there's probably something there anyways
