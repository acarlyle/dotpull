///move_baby(obj_layer layer, obj_baby baby, par_robot robot)

/*
    This function handles:
        obj_baby
*/

var layer = argument0;
var baby = argument1;
var robot = argument2;

//WOW this is seriously fucking lazy ..... needs TODO (improvement)
if (scr_tileContains(layer, baby.x, baby.y, array(obj_spike, obj_cannonEnergy))){
    scr_killRobot(robot);
}
