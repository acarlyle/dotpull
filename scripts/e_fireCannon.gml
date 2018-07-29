///e_fireCannon(par_cannon cannon, bool isVert, bool isHorz)

cannon = argument0;
var isVert = argument1;
var isHorz = argument2;

//var xDiff = robot.x - cannon.x;
//var yDiff = robot.y - cannon.y;

var endOfTheLine = false;
var createEnergy = false;
var CANNON_DIRECTION = -1;

switch(cannon.shotDirection){
    case "down":
        CANNON_DIRECTION *= -1;
        break;
    case "right":
        CANNON_DIRECTION *= -1;
        break;
}

print("dir: " + string(cannon.shotDirection) + " " + string(CANNON_DIRECTION));

if (isHorz){ //robot is moving left/right; check for objects towards the player
    var objX = cannon.x;
    while(!endOfTheLine){
        objX += global.TILE_SIZE * CANNON_DIRECTION;
        if (instance_place(objX, cannon.y, par_obstacle)){
            //print(objY);
            var obs = instance_place(objX, cannon.y, par_obstacle);
            //print(obs.isDeactivated);
            if (!obs.isDeactivated){
                if (get_parent(obs) == "par_breakableWall"){
                    e_damageBreakableWall(obs);
                    createEnergy = true;
                }
                endOfTheLine = true; //don't blast if anything is in the way
            }
            else{
                createEnergy = true;
            }
        }
        else{
            createEnergy = true;
        }
        //print("nothing here: " + string(objY));
        if (createEnergy){
            if (instance_place(objX, cannon.y, par_platform)){
                instance_create(objX, cannon.y, obj_cannonEnergy);
                print("Creating cannon energy at " + string(objX) + " " + string(cannon.y));
            }
            createEnergy = false;
        }
        if (!instance_place(objX, cannon.y, par_platform)){
            endOfTheLine = true;
        }
    }
}
if (isVert){ //robot is moving up/down; check for objects towards the player
    var objY = cannon.y;
    while(!endOfTheLine){
        objY += global.TILE_SIZE * CANNON_DIRECTION;
        print(objY);
        if (instance_place(cannon.x, objY, par_obstacle)){
            //print(objY);
            var obs = instance_place(cannon.x, objY, par_obstacle);
            //print(obs.isDeactivated);
            if (!obs.isDeactivated){
                if (get_parent(obs) == "par_breakableWall"){
                    e_damageBreakableWall(obs);
                    createEnergy = true;
                }
                endOfTheLine = true; //don't blast if anything is in the way
            }
            else{
                createEnergy = true;
            }
        }
        else{
            createEnergy = true;
        }
        //print("nothing here: " + string(objY));
        if (createEnergy){
            if (instance_place(cannon.x, objY, par_platform)){
                instance_create(cannon.x, objY, obj_cannonEnergy);
                print("Creating cannon energy at " + string(cannon.x) + " " + string(objY));
            }
            createEnergy = false;
        }
        if (!instance_place(cannon.x, objY, par_platform)){
            endOfTheLine = true;
        }
    }
}
