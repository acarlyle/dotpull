///move_cannon(par_cannon cannon, par_robot robot)

/*
    This function handles:
        obj_cannon_vert
        obj_cannon_horz
*/

cannon = argument0;
robot = argument1;

print(object.state);
print(object.shotDirection);
ds_stack_push(object.stateHistory, object.state + "," + object.shotDirection);
print("pushed cannon stateHistory: " + string(object.state) + "," + string(object.shotDirection));

var xDiff = -1;
var yDiff = -1;

if (robot.x - cannon.x > 0){
    xDiff *= -1;
}
if (robot.y - cannon.y > 0){
    yDiff *= -1;
}

print("handling" + object_get_name(cannon.object_index));

var isVert = false;
var isHorz = false;
if (object_get_name(cannon.object_index) == "obj_cannon_vert"){
    isVert = true;
    print("isVert");
}
else if (object_get_name(cannon.object_index) == "obj_cannon_horz"){
    isHorz = true;
    print("isHorz");
}

switch (state){
    case "firing":
        print("firing away");
        e_fireCannon(cannon, isVert, isHorz);
        cannon.state = "idling";
        break;
    case "charging":
        print("state charging");
        cannon.state = "firing";
        break;
        
    case "idling":
        //check if player is in up down line for a blasting
        if (isVert){
            if ((robot.x == cannon.x) && scr_canBlastRobot(cannon, robot)){
                cannon.state = "charging";
                if (yDiff > 0){
                    cannon.shotDirection = "down";
                    print("down");
                }
                else{
                    cannon.shotDirection = "up";
                    print("up");
                }
                print("blast that little shitter");
            } 
        }
        if (isHorz){
            if ((robot.y == cannon.y) && scr_canBlastRobot(cannon, robot)){
                cannon.state = "charging";
                if (xDiff > 0){
                    cannon.shotDirection = "right";
                }
                else{
                    cannon.shotDirection = "left";
                }
                print("blast that little shitter");
            } 
        }
        break;
}
