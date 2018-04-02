///handle_robotMove_tile_slide(par_robot robot)

/*
    Robot is sliding across some ice.  All movement is disabled, and the direction you move is the
    same direction you last moved when you could freely move.
*/

var robot = argument0;

scr_disableMovementKeys();
robot.canMove = false;

print("");
print("HANDLE_ROBOTMOVE_TILE_SLIDE FOR " + object_get_name(robot.object_index));

if (!robot.canMove){
    if ((robot.movedDir == "left") && !scr_collisionCheck(robot.playerX - global.TILE_SIZE, robot.playerY, robot)){
        robot.playerX -= global.TILE_SIZE;
        robot.movedDir = "left";
        robot.moved = true;
    }
    if ((robot.movedDir == "right") && !scr_collisionCheck(robot.playerX + global.TILE_SIZE, robot.playerY, robot)){
        robot.playerX += global.TILE_SIZE;
        robot.movedDir = "right";
        robot.moved = true;
    }
    if ((robot.movedDir == "up") && !scr_collisionCheck(robot.playerX, robot.playerY - global.TILE_SIZE, robot)){
        robot.playerY -= global.TILE_SIZE;
        robot.movedDir = "up";
        robot.moved = true;
    }
    if ((robot.movedDir == "down") && !scr_collisionCheck(robot.playerX, robot.playerY + global.TILE_SIZE, robot)){
        robot.playerY += global.TILE_SIZE;
        robot.movedDir = "down";
        robot.moved = true;
    }
    if ((robot.movedDir == "upleft") && !scr_collisionCheck(robot.playerX - global.TILE_SIZE, robot.playerY - global.TILE_SIZE, robot)){
        robot.playerX -= global.TILE_SIZE;
        robot.playerY -= global.TILE_SIZE;
        robot.movedDir = "upleft";
        robot.moved = true;
    }
    if ((robot.movedDir == "upright") && !scr_collisionCheck(robot.playerX + global.TILE_SIZE, robot.playerY - global.TILE_SIZE, robot)){
        robot.playerX += global.TILE_SIZE;
        robot.playerY -= global.TILE_SIZE;
        robot.movedDir = "upright";
        robot.moved = true;
    }
    if ((robot.movedDir == "downleft") && !scr_collisionCheck(robot.playerX - global.TILE_SIZE, robot.playerY + global.TILE_SIZE, robot)){
        robot.playerX -= global.TILE_SIZE;
        robot.playerY += global.TILE_SIZE;
        robot.movedDir = "downleft";
        robot.moved = true;
    }
    if ((robot.movedDir == "downright") && !scr_collisionCheck(robot.playerX + global.TILE_SIZE, robot.playerY + global.TILE_SIZE, robot)){
        robot.playerX += global.TILE_SIZE;
        robot.playerY += global.TILE_SIZE;
        robot.movedDir = "downright";
        robot.moved = true;
    }
}
