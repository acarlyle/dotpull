///move_pusher(obj_layer layer, par_robot robot, obj_enum object)

/*
    Recursive function. 
    Initial object passed to this function is a pusher.
    After this, it's every object lined up to be pushed with the pusher.  
*/

print("->move_pusher()");

var layer = argument0;
var robot = argument1;
var object = argument2;

var posX = object[| OBJECT.X];
var posY = object[| OBJECT.Y];

if (global.key_left)
{
    posX = posX - global.TILE_SIZE;
}
else if (global.key_right)
{
    posX = posX + global.TILE_SIZE;
}
else if (global.key_up)
{
    posY = posY - global.TILE_SIZE;
}
else if (global.key_down)
{
    posY = posY + global.TILE_SIZE;
}
else if (global.key_upleft)
{
    posX = posX - global.TILE_SIZE;
    posY = posY - global.TILE_SIZE;
}
else if (global.key_downleft)
{
    posX = posX - global.TILE_SIZE;
    posY = posY + global.TILE_SIZE;
}
else if (global.key_upright
){
    posX = posX + global.TILE_SIZE;
    posY = posY - global.TILE_SIZE;
}
else if (global.key_downright)
{
    posX = posX + global.TILE_SIZE;
    posY = posY + global.TILE_SIZE;
}

if (scr_tileContains(layer, posX, posY, array(par_obstacle))){
    var obs = map_place(layer, par_obstacle, posX, posY);
    if (obs){
        if (obs[| OBJECT.PULL] || obs[| OBJECT.CANPUSH]){
            if (move_pusher(layer, robot, obs))
            {
                obs = object;
                obs[| OBJECT.X] = posX;
                obs[| OBJECT.Y] = posY;
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
           return false; 
        }
    }
    else if (scr_platformIsWalkable(layer, posX, posY))
    {
        return true;
    }
}
else if (scr_platformIsWalkable(posX, posY)){
    object.x = posX;
    object.y = posY;
    //print("2: " + string(object_get_name(object.object_index) + " now at: " + string(posX) + " " + string(posY)));
    return true;
}
