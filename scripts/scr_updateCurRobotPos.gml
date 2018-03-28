///scr_updateCurRobotPos(par_robot robot)

/*
    This script updates the robots's current position without affecting the stack.
*/

var obj = argument0;

print(" -> scr_updateCurRobotPos(" + string(object_get_name(obj.object_index)));

if (parentOf(obj) == "par_robot"){
    obj.oldPlayerX = x;
    obj.oldPlayerY = y;
    obj.playerX = x;
    obj.playerY = y;
}
