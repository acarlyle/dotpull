///scr_collisionCheck(int posX, int posY)

if (instance_place(argument0, argument1, obj_spike)){
    print("ded player");
    obj_player.isDead = true;
    obj_player.sprite_index = spr_playerDead;
    return true;
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
            x = 0;
            y = 0;
        }
        return false;
    }
}
//print("numnkeys end");
if (instance_place(argument0, argument1, obj_key)){
    key = instance_place(argument0, argument1, obj_key);
    with (key){
        obj_player.numKeys++;
        //instance_destroy();
        //instance_deactivate_object(self); //deactivate key because you have it now :)
        isDeactivated = true;
        justDeactivated = true;
        deactivatedX = x;
        deactivatedY = y;
        ds_stack_push(moveHistory, string(x) + "," + string(y));
        x = 0;
        y = 0;
        //ds_stack_pop(moveHistory);
        //ds_stack_pop(moveHistory);
    }
    return false;
}
if (instance_place(argument0, argument1, obj_block) || 
    instance_place(argument0, argument1, obj_blockPush) ||
    instance_place(argument0, argument1, obj_blockPushPull)){
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
    return true; //there's a wall here
}
if (instance_place(argument0, argument1, par_platform)){
    var platform = instance_place(argument0, argument1, par_platform);
    if (platform.isFallingPlatform){
        if (platform.stepsLeft <= 0){
            return true; //you can't walk here, the platform has fallen and the city is lost
        }
    }
    return false; //there's a platform here, good to take a stroll on
}
if (instance_place(argument0, argument1, obj_fallingPlatform)){
    var platform = instance_place(argument0, argument1, obj_fallingPlatform);
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
