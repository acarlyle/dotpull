///move_eviscerator(obj_eviscerator eviscerator, par_robot robot)

/*
    This function handles:
        obj_eviscerator
*/

eviscerator = argument0;
robot = argument1;

if (instance_place(eviscerator.x, eviscerator.y, robot)){
    scr_killRobot(robot);          
}
