///move_eviscerator(obj_layer layer, obj_eviscerator eviscerator, par_robot robot)

/*
    This function handles:
        obj_eviscerator
*/

var layer = argument0;
var eviscerator = argument1;
var robot = argument2;

if (instance_place(eviscerator.x, eviscerator.y, robot)){
    scr_killRobot(robot);          
}
