///move_cannon(obj_layer layer, par_cannon cannon)

/*
    This function handles:
        obj_cannon_vert
        obj_cannon_horz
*/

var layer = argument0;
var cannon = argument1;

var robot = layer.robot;

print("-> move_cannon: cannon state " + string(cannon[| OBJECT.STATE]));

ds_stack_push(cannon[| OBJECT.STATEHISTORY], cannon[| OBJECT.STATE] + "," + cannon[| AI.TARGETDIR]);

var xDiff = -1;
var yDiff = -1;

if (robot[| OBJECT.X] - cannon[| OBJECT.X] > 0){
    xDiff *= -1;
}
if (robot[| OBJECT.Y] - cannon[| OBJECT.Y] > 0){
    yDiff *= -1;
}

var isVert = false;
var isHorz = false;

if (cannon[| OBJECT.NAME] == "obj_cannon_vert")
{
    isVert = true;
}
else if (cannon[| OBJECT.NAME] == "obj_cannon_horz")
{
    isHorz = true;
}

if (cannon[| OBJECT.STATE] == "fired") cannon[| OBJECT.STATE] = "idling";

switch (cannon[| OBJECT.STATE]){
    case "fired":
        cannon[| OBJECT.STATE] = "idling";
        break;

    case "firing":
        print("firing away");
        e_fireCannon(layer, cannon, isVert, isHorz);
        cannon[| OBJECT.STATE] = "fired";
        print("CANNON state now: " + string(cannon.state));
        break;
        
    case "charging":
        print("cannon is now in firing state");
        cannon[| OBJECT.STATE] = "firing";
        break;
        
    case "idling":
        //check if player is in up down line for a blasting
        print("state is idling, checking for player");
        if (isVert){
            if ((robot[| OBJECT.X] == cannon[| OBJECT.X]) && scr_canBlastRobot(cannon, robot)){
                cannon[| OBJECT.STATE] = "charging";
                if (yDiff > 0){
                    cannot[| AI.TARGETDIR] = "down";
                }
                else{
                    cannot[| AI.TARGETDIR] = "up";
                }
                print("cannon is now charging: blast that little shitter");
            } 
        }
        if (isHorz){
            if ((robot[| OBJECT.Y] == cannon[| OBJECT.Y]) && scr_canBlastRobot(cannon, robot)){
                cannon[| OBJECT.STATE] = "charging";
                if (xDiff > 0){
                    cannot[| AI.TARGETDIR] = "right";
                }
                else{
                    cannot[| AI.TARGETDIR] = "left";
                }
                print("blast that little shitter");
            } 
        }
        break;
}
