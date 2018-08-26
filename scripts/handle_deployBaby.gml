///handle_deployBaby(par_robot robot)

var robot = argument0;

print("has baby: " + string(robot.hasBaby));

var posX = robot.x;
var posY = robot.y;

if (global.key_space && robot.hasBaby){
    print("HANDLE DEPLOY_BABY !!! robot moved dir: " + string(robot.movedDir));
    var baby = instance_place(global.DEACTIVATED_X, global.DEACTIVATED_Y, obj_baby);
    if(baby){
        switch(robot.movedDir){
            case "up":
                posY = robot.y - global.TILE_SIZE;
                break;
            case "down":
                posY = robot.y + global.TILE_SIZE;
                break;
            case "left":
                posX = robot.x - global.TILE_SIZE;
                break;
            case "right":
                posX = robot.x + global.TILE_SIZE;
                break;
            case "upleft":
                posX = robot.x - global.TILE_SIZE;
                posY = robot.y - global.TILE_SIZE;
                break;
            case "upright":
                posX = robot.x + global.TILE_SIZE;
                posY = robot.y - global.TILE_SIZE;
                break;
            case "downleft":
                posX = robot.x - global.TILE_SIZE;
                posY = robot.y + global.TILE_SIZE;
                break;
            case "downright":
                posX = robot.x + global.TILE_SIZE;
                posY = robot.y + global.TILE_SIZE;
                break;
        }
        print("Baby potential x,y: " + string(posX) + ", " + string(posY));
        if (!scr_tileContains(layer, posX, posY, array(par_obstacle)) && scr_tileIsOpen(posX, posY)){
            baby.x = posX;
            baby.y = posY;
            baby.currentState = "ground";
            print("Baby moved to x,y: " + string(baby.x) + ", " + string(baby.y));
            robot.hasBaby = false;
            robot.moved = true;
        }
    }
}
