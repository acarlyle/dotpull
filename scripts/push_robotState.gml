///push_robotState(var robot, bool pushCurState, var pushXVal, var PushYVal)

var layer = argument0;
var robot = argument1;
var pushCurState = argument2; //push previous turn or this current one
var pushXOntoStack = argument3; //default to robot's previous turn
var pushYOntoStack = argument4; //default to robot's previous turn

if (pushCurState){ pushXOntoStack = robot[| OBJECT.X]; pushYOntoStack = robot[| OBJECT.Y]; }

print("-> DISABLED push_robotState(" + string(pushXOntoStack) + "," + string(pushYOntoStack) + ")");

ds_stack_push(robot[| OBJECT.MOVEHISTORY], string(layer.roomName) + ";" + string(pushXOntoStack) + "," + string(pushYOntoStack));
ds_stack_push(robot[| OBJECT.MOVEDDIRHISTORY], robot[| OBJECT.MOVEDDIR]);
ds_stack_push(robot[| ROBOT.ITEMHISTORY], array(robot[| ROBOT.NUMKEYS], robot[| ROBOT.HASBABY]));

//robot[| OBJECT.X] = robot[| ROBOT.NEWX]; 
//robot[| OBJECT.Y] = robot[| ROBOT.NEWY];

if (map_place(layer, obj_slideTile, robot[| OBJECT.X], robot[| OBJECT.Y])){
    robot[| ROBOT.CANMOVE] = false;
}
