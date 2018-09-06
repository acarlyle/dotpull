///handle_deployBaby(obj_layer layer, par_robot robot)

var layer = argument0;
var robot = argument1;

print("has baby: " + string(robot[| ROBOT.HASBABY]));

var posX = robot[| OBJECT.X];
var posY = robot[| OBJECT.Y];

if (global.key_space && robot[| ROBOT.HASBABY]){
    print("HANDLE DEPLOY_BABY !!! robot moved dir: " + string(robot[| OBJECT.MOVEDDIR]));
    var baby = map_place(layer, obj_baby, global.DEACTIVATED_X, global.DEACTIVATED_Y);
    if(baby){
        switch(robot[| OBJECT.MOVEDDIR]){
            case "up":
                posY = robot[| OBJECT.Y] - global.TILE_SIZE;
                break;
            case "down":
                posY = robot[| OBJECT.Y]+ global.TILE_SIZE;
                break;
            case "left":
                posX = robot[| OBJECT.X] - global.TILE_SIZE;
                break;
            case "right":
                posX = robot[| OBJECT.X] + global.TILE_SIZE;
                break;
            case "upleft":
                posX = robot[| OBJECT.X] - global.TILE_SIZE;
                posY = robot[| OBJECT.Y] - global.TILE_SIZE;
                break;
            case "upright":
                posX = robot[| OBJECT.X] + global.TILE_SIZE;
                posY = robot[| OBJECT.Y] - global.TILE_SIZE;
                break;
            case "downleft":
                posX = robot[| OBJECT.X] - global.TILE_SIZE;
                posY = robot[| OBJECT.Y]+ global.TILE_SIZE;
                break;
            case "downright":
                posX = robot[| OBJECT.X] + global.TILE_SIZE;
                posY = robot[| OBJECT.Y]+ global.TILE_SIZE;
                break;
        }
        print("Baby potential x,y: " + string(posX) + ", " + string(posY));
        if (!scr_tileContains(layer, posX, posY, array(par_obstacle)) && scr_tileIsOpen(posX, posY)){
            baby[| OBJECT.X] = posX;
            baby[| OBJECT.Y] = posY;
            //baby.currentState = "ground"; //TODO
            robot[| ROBOT.HASBABY] = false;
            robot[| OBJECT.MOVED] = true;
        }
    }
}
