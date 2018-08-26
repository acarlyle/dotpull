///handle_robotMove_tile_one(obj_layer layer, par_robot robot)

var layer = argument0;
var robot = argument1;

print("");
print("HANDLE_ROBOTMOVE_TILE_ONE FOR " + object_get_name(robot.object_index));

print("Robot X: " + string(robot.x));
print("Robot Y: " + string(robot.y));

//handle arrow logic
if (instance_place(x, y, par_arrow)){
    var arrow = instance_place(x, y, par_arrow);
    with (arrow){
        switch(dir){
            case "up":
                if (!global.key_up && !global.key_upleft && !global.key_upright) robot.canMove = false;
                break; 
            case "right":
                if (!global.key_right && !global.key_upright && !global.key_downright) robot.canMove = false;
                break; 
            case "left":
                if (!global.key_left && !global.key_upleft && !global.key_downleft) robot.canMove = false;
                break; 
            case "down":
                if (!global.key_down && !global.key_downleft && !global.key_downright) robot.canMove = false;
                break; 
        }
    }
}

if (robot.canMove){
    if ((global.key_left) && !scr_collisionCheck(layer, robot.playerX - global.TILE_SIZE, robot.playerY, robot)){
        robot.playerX -= global.TILE_SIZE;
        robot.movedDir = "left";
        robot.moved = true;
    }
    if ((global.key_right) && !scr_collisionCheck(layer, robot.playerX + global.TILE_SIZE, robot.playerY, robot)){
        robot.playerX += global.TILE_SIZE;
        robot.movedDir = "right";
        robot.moved = true;
    }
    if ((global.key_up) && !scr_collisionCheck(layer, robot.playerX, robot.playerY - global.TILE_SIZE, robot)){
        robot.playerY -= global.TILE_SIZE;
        robot.movedDir = "up";
        robot.moved = true;
    }
    if ((global.key_down) && !scr_collisionCheck(layer, robot.playerX, robot.playerY + global.TILE_SIZE, robot)){
        robot.playerY += global.TILE_SIZE;
        robot.movedDir = "down";
        robot.moved = true;
    }
    if ((global.key_upleft) && !scr_collisionCheck(layer, robot.playerX - global.TILE_SIZE, robot.playerY - global.TILE_SIZE, robot)){
        robot.playerX -= global.TILE_SIZE;
        robot.playerY -= global.TILE_SIZE;
        robot.movedDir = "upleft";
        robot.moved = true;
    }
    if ((global.key_upright) && !scr_collisionCheck(layer, robot.playerX + global.TILE_SIZE, robot.playerY - global.TILE_SIZE, robot)){
        robot.playerX += global.TILE_SIZE;
        robot.playerY -= global.TILE_SIZE;
        robot.movedDir = "upright";
        robot.moved = true;
    }
    if ((global.key_downleft) && !scr_collisionCheck(layer, robot.playerX - global.TILE_SIZE, robot.playerY + global.TILE_SIZE, robot)){
        robot.playerX -= global.TILE_SIZE;
        robot.playerY += global.TILE_SIZE;
        robot.movedDir = "downleft";
        robot.moved = true;
    }
    if ((global.key_downright) && !scr_collisionCheck(layer, robot.playerX + global.TILE_SIZE, robot.playerY + global.TILE_SIZE, robot)){
        robot.playerX += global.TILE_SIZE;
        robot.playerY += global.TILE_SIZE;
        robot.movedDir = "downright";
        robot.moved = true;
    }
}
