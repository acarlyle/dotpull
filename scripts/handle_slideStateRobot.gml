///handle_slideStateRobot(par_robot robot)

//handle this object's/robot's undo
/*with(argument0){
    var moveHistoryTopStr = ds_stack_top(self.moveHistory); //string e.g. "64,64"
    if (moveHistoryTopStr != undefined){
        var objCoordArr = scr_split(moveHistoryTopStr);
        var oldPosX = objCoordArr[0];
        var oldPosY = objCoordArr[1];

    }
}*/
/*
var robot = argument0;

switch (robot.movedDir){
    case "up":
        if (!scr_collisionCheck(robot.playerX, robot.playerY - global.TILE_SIZE, robot)){
            robot.playerY -= global.TILE_SIZE;
            robot.movedDir = "up";
            robot.moved = true;
        }
        break;
    case "down":
        if (!scr_collisionCheck(robot.playerX, robot.playerY + global.TILE_SIZE, robot)){
            robot.playerY += global.TILE_SIZE;
            robot.movedDir = "down";
            robot.moved = true;
        }
        break;
    case "left":
        if (!scr_collisionCheck(robot.playerX - global.TILE_SIZE, robot.playerY, robot)){
            robot.playerX -= global.TILE_SIZE;
            robot.movedDir = "left";
            robot.moved = true;
        }
        break;
    case "right":
        if (!scr_collisionCheck(robot.playerX + global.TILE_SIZE, robot.playerY, robot)){
            robot.playerX += global.TILE_SIZE;
            robot.movedDir = "right";
            robot.moved = true;
        }
        break;
    case "upright":
        if (!scr_collisionCheck(robot.playerX + global.TILE_SIZE, robot.playerY - global.TILE_SIZE, robot)){
            robot.playerX += global.TILE_SIZE;
            robot.playerY -= global.TILE_SIZE;
            robot.movedDir = "upright";
            robot.moved = true;
        }
        break;
    case "upleft":
        if (!scr_collisionCheck(robot.playerX - global.TILE_SIZE, robot.playerY - global.TILE_SIZE, robot)){
            robot.playerX -= global.TILE_SIZE;
            robot.playerY -= global.TILE_SIZE;
            robot.movedDir = "upleft";
            robot.moved = true;
        }
        break;
    case "downright":
        if (!scr_collisionCheck(robot.playerX + global.TILE_SIZE, robot.playerY + global.TILE_SIZE, robot)){
            robot.playerX += global.TILE_SIZE;
            robot.playerY += global.TILE_SIZE;
            robot.movedDir = "downright";
            robot.moved = true;
        }
        break;
    case "downleft":
        if (!scr_collisionCheck(robot.playerX - global.TILE_SIZE, robot.playerY + global.TILE_SIZE, robot)){
            robot.playerX -= global.TILE_SIZE;
            robot.playerY += global.TILE_SIZE;
            robot.movedDir = "downleft";
            robot.moved = true;
        }
        break;
}
*/
