///move_pusher(par_robot robot, par_pusher pusher)

print("-> movePusher(");

var robot = argument0;
var pusher = argument1;

var posX = 0;
var posY = 0;

if (global.key_left){
    posX = -global.TILE_SIZE;
}
else if (global.key_right){
    posX = global.TILE_SIZE;
}
else if (global.key_up){
    posY = -global.TILE_SIZE;
}
else if (global.key_down){
    posY = global.TILE_SIZE;
}
else if (global.key_upleft){
    posX = -global.TILE_SIZE;
    posY = -global.TILE_SIZE;
}
else if (global.key_downleft){
    posX = -global.TILE_SIZE;
    posY = global.TILE_SIZE;
}
else if (global.key_upright){
    posX = global.TILE_SIZE;
    posY = -global.TILE_SIZE;
}
else if (global.key_downright){
    posX = global.TILE_SIZE;
    posY = global.TILE_SIZE;
}

print("PosX, PosY: " + string(posX) + ", " + string(posY));

if (scr_tileContains(posX, posY, array(par_obstacle))){
    var obs = instance_place(posX, posY, par_obstacle);
    if (obs){
        if (obs.canPull || obs.canPush){
            if (move_pusher(robot, pusher)){
                obs = instance_place(posX, posY, par_obstacle);
                obs.x = posX;
                obs.y = posY;
            }
            else{
                return false;
            }
        }
        else{
           return false; 
        }
    }
    else if (tile_hasMovablePlatform(posX, posY)){
        return true;
    }
}
else if (tile_hasMovablePlatform(posX, posY)){
    return true;
}
