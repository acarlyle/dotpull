///handle_robotMove_tile_slide(par_robot robot)

/*
    Robot is sliding across some ice.  All movement is disabled, and the direction you move is the
    same direction you last moved when you could freely move.
*/

var layer = argument0;
var robot = argument1;

scr_disableMovementKeys();
robot[| ROBOT.CANMOVE] = false;

print("");
print("HANDLE_ROBOTMOVE_TILE_SLIDE FOR " + object_get_name(robot.object_index));

if (!robot[| ROBOT.CANMOVE]){
    if ((robot[| OBJECT.MOVEDDIR] == "left") && !scr_collisionCheck(layer, robot[| ROBOT.NEWX] - global.TILE_SIZE, robot[| ROBOT.NEWY], robot)){
        robot[| ROBOT.NEWX] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "left";
        robot.moved = true;
    }
    if ((robot[| OBJECT.MOVEDDIR] == "right") && !scr_collisionCheck(layer, robot[| ROBOT.NEWX] + global.TILE_SIZE, robot[| ROBOT.NEWY], robot)){
        robot[| ROBOT.NEWX] += global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "right";
        robot.moved = true;
    }
    if ((robot[| OBJECT.MOVEDDIR] == "up") && !scr_collisionCheck(layer, robot[| ROBOT.NEWX], robot[| ROBOT.NEWY] - global.TILE_SIZE, robot)){
        robot[| ROBOT.NEWY] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "up";
        robot.moved = true;
    }
    if ((robot[| OBJECT.MOVEDDIR] == "down") && !scr_collisionCheck(layer, robot[| ROBOT.NEWX], robot[| ROBOT.NEWY] + global.TILE_SIZE, robot)){
        robot[| ROBOT.NEWY] += global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "down";
        robot.moved = true;
    }
    if ((robot[| OBJECT.MOVEDDIR] == "upleft") && !scr_collisionCheck(layer, robot[| ROBOT.NEWX] - global.TILE_SIZE, robot[| ROBOT.NEWY] - global.TILE_SIZE, robot)){
        robot[| ROBOT.NEWX] -= global.TILE_SIZE;
        robot[| ROBOT.NEWY] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "upleft";
        robot.moved = true;
    }
    if ((robot[| OBJECT.MOVEDDIR] == "upright") && !scr_collisionCheck(layer, robot[| ROBOT.NEWX] + global.TILE_SIZE, robot[| ROBOT.NEWY] - global.TILE_SIZE, robot)){
        robot[| ROBOT.NEWX] += global.TILE_SIZE;
        robot[| ROBOT.NEWY] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "upright";
        robot.moved = true;
    }
    if ((robot[| OBJECT.MOVEDDIR] == "downleft") && !scr_collisionCheck(layer, robot[| ROBOT.NEWX] - global.TILE_SIZE, robot[| ROBOT.NEWY] + global.TILE_SIZE, robot)){
        robot[| ROBOT.NEWX] -= global.TILE_SIZE;
        robot[| ROBOT.NEWY] += global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "downleft";
        robot.moved = true;
    }
    if ((robot[| OBJECT.MOVEDDIR] == "downright") && !scr_collisionCheck(layer, robot[| ROBOT.NEWX] + global.TILE_SIZE, robot[| ROBOT.NEWY] + global.TILE_SIZE, robot)){
        robot[| ROBOT.NEWX] += global.TILE_SIZE;
        robot[| ROBOT.NEWY] += global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "downright";
        robot.moved = true;
    }
}
