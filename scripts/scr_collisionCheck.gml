///scr_collisionCheck(int posX, int posY)

if (instance_place(argument0, argument1, obj_door)){
    if (numKeys > 0){ //there's a DOOR here, try to unlock
        door = instance_place(argument0, argument1, obj_door);
        with (door){
            instance_destroy(); //unlock door by removing it woah
        }
        return false;
    }
}
if (instance_place(argument0, argument1, obj_key)){
    key = instance_place(argument0, argument1, obj_key);
    with (key){
        obj_player.numKeys++;
        instance_destroy(); //remove key because you have it now :)
    }
    return false;
}
if (instance_place(argument0, argument1, par_wall)){
    return true; //there's a wall here
}
if (instance_place(argument0, argument1, par_platform)){
    return false; //there's a platform here, good to take a stroll on
}

print("cannot move to ");
print(argument0);
print(argument1);

return true; //there's probably something there anyways
