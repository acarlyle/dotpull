///scr_killRobot(par_robot robot)

var robot = argument0;

print(" -> scr_killRobot(" + string(object_get_name(argument0) + ")"));

robot.isDead = true;
robot.sprite_index = spr_playerDead;
