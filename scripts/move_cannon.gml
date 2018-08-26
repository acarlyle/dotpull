///move_cannon(obj_layer layer, par_cannon cannon, par_robot robot)

/*
    This function handles:
        obj_cannon_vert
        obj_cannon_horz
*/

var layer = argument0;
var cannon = argument1;
var robot = argument2;

//switch(cannon.state){
    
//}

print("CANNON_MOVE: " + string(cannon.state));

print(cannon.state);
print(cannon.shotDirection);
ds_stack_push(cannon.stateHistory, cannon.state + "," + cannon.shotDirection);
print("pushed cannon stateHistory: " + string(cannon.state) + "," + string(cannon.shotDirection));

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

if (cannon.state == "fired") cannon.state = "idling";

switch (cannon.state){
    case "fired":
        cannon.state = "idling";
        break;

    case "firing":
        print("firing away");
        e_fireCannon(cannon, isVert, isHorz);
        cannon.state = "fired";
        print("CANNON state now: " + string(cannon.state));
        break;
        
    case "charging":
        print("cannon is now in firing state");
        cannon.state = "firing";
        break;
        
    case "idling":
        //check if player is in up down line for a blasting
        print("state is idling, checking for player");
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
                print("cannon is now charging: blast that little shitter");
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
