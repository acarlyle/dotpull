///scr_collisionCheck(obj_layer layer, int posX, int posY, objEnum robot)

var layer = argument0;
var posX = argument1;
var posY = argument2;
var robot = argument3; 

print("-> scr_collisionCheck(" + string(posX) + "," + string(posY) + ")");

if (map_place(layer, obj_key, posX, posY)){
    key = map_place(layer, obj_key, posX, posY);
    
    if key[| OBJECT.ISACTIVE] {
        
        audio_play_sound(snd_keyPickup, 10, false);
        robot[| ROBOT.NUMKEYS] += 1;
        //key[| OBJECT.STATE] = "inventory";
        key[| OBJECT.ISACTIVE] = false;
        //key[| OBJECT.OLDPOSX] = key[| OBJECT.X];
        //key[| OBJECT.OLDPOSY] = key[| OBJECT.Y];
        //ds_stack_push(moveHistory, string(x) + "," + string(y));
        //ds_stack_push(stateHistory, "ground");
        //key[| OBJECT.X] = global.DEACTIVATED_X;
        //key[| OBJECT.Y] = global.DEACTIVATED_Y;
        
        key[| OBJECT.IMGIND] = 1;
        
        print("scr_collisionCheck: Robot keys now " + string(robot[| ROBOT.NUMKEYS]));
        
        return false;
    }
}

if (map_place(layer, obj_door, posX, posY)){
    door = map_place(layer, obj_door, posX, posY);
    
    if (door[| OBJECT.ISACTIVE]){
        if (robot[| ROBOT.NUMKEYS] > 0){ //there's a DOOR here, try to unlock
        
            robot[| ROBOT.NUMKEYS] -= 1;
            door[| OBJECT.ISACTIVE] = false;
            door[| OBJECT.OLDPOSX] = door[| OBJECT.X];
            door[| OBJECT.OLDPOSY] = door[| OBJECT.Y];
            //ds_stack_push(moveHistory, string(door[| OBJECT.X]) + "," + string(door[| OBJECT.Y]));
            //ds_stack_push(stateHistory, "locked");
            door[| OBJECT.X] = global.DEACTIVATED_X;
            door[| OBJECT.Y] = global.DEACTIVATED_Y;
            door[| OBJECT.STATE] = "unlocked";
            
            door[| OBJECT.ISACTIVE] = false;
            door[| OBJECT.IMGIND] = 1;
            
            return false;
        }
        else{
            door[| OBJECT.STATE] = "locked";
            return true;
        }
    }
}

if (map_place(layer, obj_spike, posX, posY)){
    print("player ded");
    robot[| ROBOT.ISDEAD] = true;
    robot[| OBJECT.IMGIND] = 1; //ded player index
    return true;
}

if (map_place(layer, par_stairs, posX, posY)){ return false; }

if (map_place(layer, par_pusher, posX, posY)){
    move_pusher(layer, robot, map_place(layer, par_pusher, posX, posY));
}

if (map_place(layer, par_pickupable, posX, posY)){
    scr_pickupObject(map_place(layer, par_pickupable, posX, posY));
}

/*if (map_place(layer, obj_mirptr, posX, posY)){
    var mirptr = map_place(layer, obj_mirptr, posX, posY);
    print("old robo x: " + string(robot[| OBJECT.X]));
    var roboXDiff = posX - robot[| OBJECT.OLDPOSX]; 
    var roboYDiff = posY - robot[| OBJECT.OLDPOSY]; 
    if !scr_collisionCheck(layer, mirptr.mirptrPtr.x + roboXDiff, mirptr.mirptrPtr.y + roboYDiff, robot){
        robot[| OBJECT.OLDPOSX] += (mirptr.mirptrPtr.x + roboXDiff) - mirptr.x;
        robot[| OBJECT.OLDPOSY] += (mirptr.mirptrPtr.y + roboYDiff) - mirptr.y;
        print("PROBLEM: Recursive call, new robot x, y: " + string(robot[| OBJECT.OLDPOSX]) + " " + string(robot[| OBJECT.OLDPOSY]));
    }
    else{
        return true;
    }
    
    
    robot[| OBJECT.OLDPOSX] = mirptr.mirptrPtr.x;
    robot[| OBJECT.OLDPOSY] = mirptr.mirptrPtr.y;
    print("mirptr collision in player move");
    print(mirptr.mirptrPtr.x);
}*/

if (map_place(layer, par_obstacle, posX, posY)){
    var obstacle = map_place(layer, par_obstacle, posX, posY);
    print("Obstacle detected");
    if (obstacle[| OBJECT.ISACTIVE]) return true; //obstacle will block your path
}

if (map_place(layer, par_block, posX, posY)){
    print("There's a block here");
    return true; //there's a block here
}

if (map_place(layer, obj_trigger, posX, posY)){
    //print("There's a trigger here");
    return false;
}

if (map_place(layer, obj_triggerDoor, posX, posY)){
    //print("There's a triggerDoor here");
    var door = map_place(layer, obj_triggerDoor, posX, posY);
    if (door[| OBJECT.ISACTIVE]) return true; //triggerDoor will block your path
    return false;
}

if (map_place(layer, par_wall, posX, posY)){
    wall = map_place(layer, par_wall, posX, posY);
    if (wall[| OBJECT.ISACTIVE]){
        return false; //there's a wall here but it's deactivated, you may walk
    }
    else{
        return true; //there's a wall here
    }
}

//falling platform logic only
if (map_place(layer, par_fallingPlatform, posX, posY)){
    var platform = map_place(layer, par_fallingPlatform, posX, posY);
    print("Trying to move to: " + string(platform[| OBJECT.NAME]));
    if (platform[| PLATFORM.STEPSLEFT] <= 0){
        return true; //you can't walk here, the platform has fallen and the city is lost
    }
    if (platform[| OBJECT.ISACTIVE]){
        return false;
    }
}




//NORMAL PLATFORM CHECL
if (map_place(layer, par_platform, posX, posY)){
    var platform = map_place(layer, par_platform, posX, posY);
    if (platform) return false;
}   

print("scr_collisionCheck: cannot move to: " + string(posX) +","+string(posY));

return true; //there's probably something there anyways
