///handle_playerMove(par_robot robot);

var robot = argument0;

print("");
print("HANDLE PLAYER MOVE FOR " + object_get_name(robot.object_index));

//if on a slideTile, disable player input keys
if (instance_place(robot.x, robot.y, obj_slideTile)){
    scr_disableMovementKeys();
    robot.canMove = false;
}

//handle arrow logic
var noMove = false;
    if (instance_place(x, y, par_arrow)){
        var arrow = instance_place(x, y, par_arrow);
        //if arrow.isArrow
        with (arrow){
            switch(dir){
                case "up":
                    if (!global.key_up && !global.key_upleft && !global.key_upright) noMove = true;
                    break; 
                case "right":
                    if (!global.key_right && !global.key_upright && !global.key_downright) noMove = true;
                    break; 
                case "left":
                    if (!global.key_left && !global.key_upleft && !global.key_downleft) noMove = true;
                    break; 
                case "down":
                    if (!global.key_down && !global.key_downleft && !global.key_downright) noMove = true;
                    break; 
            }
        }
    }

print(robot.playerX);
print(robot.playerY);

var pushXOntoStack = robot.playerX;
var pushYOntoStack = robot.playerY;

if (!noMove){
    if ((global.key_left || robot.movedDir == "left") && !scr_collisionCheck(robot.playerX - global.TILE_SIZE, robot.playerY, robot)){
        robot.playerX -= global.TILE_SIZE;
        robot.movedDir = "left";
        robot.moved = true;
    }
    if ((global.key_right || robot.movedDir == "right") && !scr_collisionCheck(robot.playerX + global.TILE_SIZE, robot.playerY, robot)){
        robot.playerX += global.TILE_SIZE;
        robot.movedDir = "right";
        robot.moved = true;
    }
    if ((global.key_up || robot.movedDir == "up") && !scr_collisionCheck(robot.playerX, robot.playerY - global.TILE_SIZE, robot)){
        robot.playerY -= global.TILE_SIZE;
        robot.movedDir = "up";
        robot.moved = true;
    }
    if ((global.key_down || robot.movedDir == "down") && !scr_collisionCheck(robot.playerX, robot.playerY + global.TILE_SIZE, robot)){
        robot.playerY += global.TILE_SIZE;
        robot.movedDir = "down";
        robot.moved = true;
    }
    if ((global.key_upleft || robot.movedDir == "upleft") && !scr_collisionCheck(robot.playerX - global.TILE_SIZE, robot.playerY - global.TILE_SIZE, robot)){
        robot.playerX -= global.TILE_SIZE;
        robot.playerY -= global.TILE_SIZE;
        robot.movedDir = "upleft";
        robot.moved = true;
    }
    if ((global.key_upright || robot.movedDir == "upright") && !scr_collisionCheck(robot.playerX + global.TILE_SIZE, robot.playerY - global.TILE_SIZE, robot)){
        robot.playerX += global.TILE_SIZE;
        robot.playerY -= global.TILE_SIZE;
        robot.movedDir = "upright";
        robot.moved = true;
    }
    if ((global.key_downleft || robot.movedDir == "downleft") && !scr_collisionCheck(robot.playerX - global.TILE_SIZE, robot.playerY + global.TILE_SIZE, robot)){
        robot.playerX -= global.TILE_SIZE;
        robot.playerY += global.TILE_SIZE;
        robot.movedDir = "downleft";
        robot.moved = true;
    }
    if ((global.key_downright || robot.movedDir == "downright") && !scr_collisionCheck(robot.playerX + global.TILE_SIZE, robot.playerY + global.TILE_SIZE, robot)){
        robot.playerX += global.TILE_SIZE;
        robot.playerY += global.TILE_SIZE;
        robot.movedDir = "downright";
        robot.moved = true;
    }
    
    
    //GOTO ROOM
    if (instance_place(robot.playerX, robot.playerY, obj_gotoRoom)){
        robot.x = robot.playerX;
        robot.y = robot.playerY;
        robot.movedDir = "";
        robot.moved = false;
        handle_freeRoomMemory();
    }
    
    if (object_get_name(robot.object_index) == "obj_player" && robot.moved){
        global.playerMoved = true;
        print("PLAYER MOVED");
    }
    
    if (global.playerMoved){ 
        print("pushed: " + string(robot.x) + "," + string(robot.y));
        ds_stack_push(robot.moveHistory, string(pushXOntoStack) + "," + string(pushYOntoStack)); //pushing previous turn's movement
        ds_stack_push(robot.itemHistory, array(robot.numKeys));
        print("Pushed onto robots's stack: " + string(robot.x) + " " + string(robot.y));
        print("Pushed numKeys onto robots's stack: " + string(obj_player.numKeys));
        robot.oldPlayerX = x;
        robot.oldPlayerY = y;
        print("robot oldPlayerX set to " + string(robot.oldPlayerX));
        print("robot oldPlayerY set to " + string(robot.oldPlayerY));
        robot.x = robot.playerX; 
        robot.y = robot.playerY;
        print("new robo x: " + string(robot.x)); 
        if (instance_place(robot.x, robot.y, obj_slideTile)){
            robot.canMove = false;
        }
    }
    else{
        robot.movedDir = "";
    }
}
robot.move = false;
robot.canMove = true;
