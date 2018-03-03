///handle_playerMove(par_robot robot);

var robot = argument0;

print("HANDLE PLAYER MOVE FOR " + object_get_name(robot.object_index));

//ds_stack_push(obj_player.moveHistory, string(x) + "," + string(y)); //pushing previous turn's movement
//ds_stack_push(obj_player.itemHistory, array(obj_player.numKeys));
//print("Pushed onto player's stack !");

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

//print("noMove:");
//print(noMove);

print(robot.playerX);
print(robot.playerY);

if (!noMove){
    if (global.key_left && !scr_collisionCheck(robot.playerX - global.TILE_SIZE, robot.playerY, robot)){
        robot.playerX -= global.TILE_SIZE;
        robot.moved = true;
    }
    if (global.key_right && !scr_collisionCheck(robot.playerX + global.TILE_SIZE, robot.playerY, robot)){
        robot.playerX += global.TILE_SIZE;
        robot.moved = true;
    }
    if (global.key_up && !scr_collisionCheck(robot.playerX, robot.playerY - global.TILE_SIZE, robot)){
        print("you moved!");
        robot.playerY -= global.TILE_SIZE;
        robot.moved = true;
    }
    if (global.key_down && !scr_collisionCheck(robot.playerX, robot.playerY + global.TILE_SIZE, robot)){
        robot.playerY += global.TILE_SIZE;
        robot.moved = true;
    }
    if (global.key_upleft && !scr_collisionCheck(robot.playerX - global.TILE_SIZE, robot.playerY - global.TILE_SIZE, robot)){
        robot.playerX -= global.TILE_SIZE;
        robot.playerY -= global.TILE_SIZE;
        robot.moved = true;
    }
    if (global.key_upright && !scr_collisionCheck(robot.playerX + global.TILE_SIZE, robot.playerY - global.TILE_SIZE, robot)){
        robot.playerX += global.TILE_SIZE;
        robot.playerY -= global.TILE_SIZE;
        robot.moved = true;
    }
    if (global.key_downleft && !scr_collisionCheck(robot.playerX - global.TILE_SIZE, robot.playerY + global.TILE_SIZE, robot)){
        robot.playerX -= global.TILE_SIZE;
        robot.playerY += global.TILE_SIZE;
        robot.moved = true;
    }
    if (global.key_downright && !scr_collisionCheck(robot.playerX + global.TILE_SIZE, robot.playerY + global.TILE_SIZE, robot)){
        robot.playerX += global.TILE_SIZE;
        robot.playerY += global.TILE_SIZE;
        robot.moved = true;
    }
    
    
    //GOTO ROOM
    if (instance_place(robot.playerX, robot.playerY, obj_gotoRoom)){
        robot.x = robot.playerX;
        robot.y = robot.playerY;
        robot.moved = false;
        handle_freeRoomMemory();
    }
    
    if (object_get_name(robot.object_index) == "obj_player" && robot.moved){
        global.playerMoved = true;
        print("PLAYER MOVED");
    }
    
    if (global.playerMoved){ 
        print("pushed: " + string(robot.x) + "," + string(robot.y));
        ds_stack_push(robot.moveHistory, string(robot.x) + "," + string(robot.y)); //pushing previous turn's movement
        ds_stack_push(robot.itemHistory, array(robot.numKeys));
        print("Pushed onto robots's stack: " + string(robot.x) + " " + string(robot.y));
        print("Pushed numKeys onto robots's stack: " + string(obj_player.numKeys));
        robot.oldPlayerX = x;
        robot.oldPlayerY = y;
        robot.x = robot.playerX; 
        robot.y = robot.playerY;
        print("new robo x: " + string(robot.x)); 
    }
}

//print(obj_player.numKeys);

robot.move = false;
