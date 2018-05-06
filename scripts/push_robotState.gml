///push_robotState(var robot, bool pushCurState, var pushXVal, var PushYVal)

var robot = argument0;
var pushCurState = argument1; //push previous turn or this current one
var pushXOntoStack = argument2; //default to robot's previous turn
var pushYOntoStack = argument3; //default to robot's previous turn

if (pushCurState){ pushXOntoStack = robot.x; pushYOntoStack = robot.y; }

//print("pushed: " + string(pushXOntoStack) + "," + string(pushYOntoStack));
ds_stack_push(robot.moveHistory, string(room_get_name(room)) + ";" + string(pushXOntoStack) + "," + string(pushYOntoStack));
ds_stack_push(robot.itemHistory, array(robot.numKeys, robot.hasBaby));
ds_stack_push(robot.movedDirHistory, robot.movedDir);
print("robo-pushed " + string(pushXOntoStack) + ", " + string(pushYOntoStack)); 

robot.oldPlayerX = x;
robot.oldPlayerY = y;
robot.x = robot.playerX; 
robot.y = robot.playerY;

if (instance_place(robot.x, robot.y, obj_slideTile)){
    robot.canMove = false;
}
