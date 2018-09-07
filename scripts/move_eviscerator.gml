///move_eviscerator(obj_layer layer, obj_eviscerator eviscerator,)

/*
    This function handles:
        obj_eviscerator
*/

var layer = argument0;
var eviscerator = argument1;

var robot = layer.robot;

if (instance_place(eviscerator.x, eviscerator.y, robot)){
    scr_killRobot(robot);          
}
