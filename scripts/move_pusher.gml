///move_pusher(obj_layer layer, par_robot robot, par_object object)

/*
    Initial object passed to this function is a pusher.
    After this, it's every object lined up to be pushed with the pusher. 
*/

print("-> movePusher(");

var layer = argument0;
var robot = argument1;
var object = argument2;

var posX = object.x;
var posY = object.y;

if (global.key_left){
    posX = posX - global.TILE_SIZE;
}
else if (global.key_right){
    posX = posX + global.TILE_SIZE;
}
else if (global.key_up){
    posY = posY - global.TILE_SIZE;
}
else if (global.key_down){
    posY = posY + global.TILE_SIZE;
}
else if (global.key_upleft){
    posX = posX - global.TILE_SIZE;
    posY = posY - global.TILE_SIZE;
}
else if (global.key_downleft){
    posX = posX - global.TILE_SIZE;
    posY = posY + global.TILE_SIZE;
}
else if (global.key_upright){
    posX = posX + global.TILE_SIZE;
    posY = posY - global.TILE_SIZE;
}
else if (global.key_downright){
    posX = posX + global.TILE_SIZE;
    posY = posY + global.TILE_SIZE;
}

//print("PosX, PosY: " + string(posX) + ", " + string(posY));

if (scr_tileContains(layer, posX, posY, array(par_obstacle))){
    var obs = instance_place(posX, posY, par_obstacle);
    if (obs){
        if (obs.canPull || obs.canPush){
            if (move_pusher(layer, robot, obs)){
                obs = object;
                obs.x = posX;
                obs.y = posY;
                //print("1: " + string(object_get_name(obs.object_index) + " now at: " + string(posX) + " " + string(posY)));
                return true;
            }
            else{
                return false;
            }
        }
        else{
           return false; 
        }
    }
    else if (scr_platformIsWalkable(posX, posY)){
        return true;
    }
}
else if (scr_platformIsWalkable(posX, posY)){
    object.x = posX;
    object.y = posY;
    //print("2: " + string(object_get_name(object.object_index) + " now at: " + string(posX) + " " + string(posY)));
    return true;
}
