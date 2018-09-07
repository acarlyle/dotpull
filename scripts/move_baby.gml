///move_baby(obj_layer layer, obj_enum baby)

/*
    This function handles:
        obj_baby
*/

var layer = argument0;
var baby = argument1;

var robot = layer.robot;

//WOW this is seriously fucking lazy ..... needs TODO (improvement)
if (scr_tileContains(layer, baby[| OBJECT.X], baby[| OBJECT.Y], array(obj_spike, obj_cannonEnergy))){
    scr_killRobot(robot);
}
