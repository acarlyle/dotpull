///e_fireCannon(obj_layer layer, obj_enum cannon, bool isVert, bool isHorz)

var layer = argument0;
var cannon = argument1;
var isVert = argument2;
var isHorz = argument3;

var endOfTheLine = false;
var createEnergy = false;
var CANNON_DIRECTION = -1;

switch(cannon[| AI.TARGETDIR] ){
    case "down":
        CANNON_DIRECTION *= -1;
        break;
    case "right":
        CANNON_DIRECTION *= -1;
        break;
}

print("dir: " + string(cannon[| AI.TARGETDIR] ) + " " + string(CANNON_DIRECTION));

if (isHorz){ //robot is moving left/right; check for objects towards the player
    var objX = cannon[| OBJECT.X];
    while(!endOfTheLine){
        objX += global.TILE_SIZE * CANNON_DIRECTION;
        if (map_place(layer, par_obstacle, objX, cannon[| OBJECT.Y])){
            var obs = map_place(layer, par_obstacle, objX, cannon[| OBJECT.Y]);
            if (obs[| OBJECT.ISACTIVE]){
                if (get_parentOfEnum(obs) == "par_breakableWall"){
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
        if (createEnergy){
            if (map_place(layer, par_platform, objX, cannon[| OBJECT.Y])){
                instance_create(objX, cannon[| OBJECT.Y], obj_cannonEnergy);
                print("Creating cannon energy at " + string(objX) + " " + string(cannon[| OBJECT.Y]));
            }
            createEnergy = false;
        }
        if (!map_place(layer, objX, cannon[| OBJECT.Y], par_platform)){
            endOfTheLine = true;
        }
    }
}
if (isVert){ //robot is moving up/down; check for objects towards the player
    var objY = cannon[| OBJECT.Y];
    while(!endOfTheLine){
        objY += global.TILE_SIZE * CANNON_DIRECTION;
        print(objY);
        if (map_place(layer, par_obstacle, cannon[| OBJECT.X], objY)){
            var obs = map_place(layer, par_obstacle, cannon[| OBJECT.X], objY);
            if (obs[| OBJECT.ISACTIVE]){
                if (get_parentOfEnum(obs) == "par_breakableWall"){
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
        if (createEnergy){
            if (map_place(layer, par_platform, cannon[| OBJECT.X], objY)){
                instance_create(cannon[| OBJECT.X], objY, obj_cannonEnergy);
                print("Creating cannon energy at " + string(cannon[| OBJECT.X]) + " " + string(objY));
            }
            createEnergy = false;
        }
        if (!map_place(layer, par_platform, cannon[| OBJECT.X], objY)){
            endOfTheLine = true;
        }
    }
}
