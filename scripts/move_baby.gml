///move_baby(obj_baby baby, par_robot robot)

/*
    This function handles:
        obj_baby
*/

baby = argument0;
robot = argument1;

//WOW this is seriously fucking lazy ..... needs TODO (improvement)
if (scr_tileContains(baby.x, baby.y, array(obj_spike, obj_cannonEnergy))){
    scr_killRobot(robot);
}
