//pre-roberta abstraction

///handle_playerMove

print("handle player move");

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
                if (!obj_player.key_up && !obj_player.key_upleft && !obj_player.key_upright) noMove = true;
                break; 
            case "right":
                if (!obj_player.key_right && !obj_player.key_upright && !obj_player.key_downright) noMove = true;
                break; 
            case "left":
                if (!obj_player.key_left && !obj_player.key_upleft && !obj_player.key_downleft) noMove = true;
                break; 
            case "down":
                if (!obj_player.key_down && !obj_player.key_downleft && !obj_player.key_downright) noMove = true;
                break; 
        }
    }
}

//print("noMove:");
//print(noMove);

if (!noMove){
    if (key_left && !scr_collisionCheck(global.playerX - global.TILE_SIZE, global.playerY, robot)){
        global.playerX -= global.TILE_SIZE;
        moved = true;
    }
    if (key_right && !scr_collisionCheck(global.playerX + global.TILE_SIZE, global.playerY, robot)){
        global.playerX += global.TILE_SIZE;
        moved = true;
    }
    if (key_up && !scr_collisionCheck(global.playerX, global.playerY - global.TILE_SIZE, robot)){
        global.playerY -= global.TILE_SIZE;
        moved = true;
    }
    if (key_down && !scr_collisionCheck(global.playerX, global.playerY + global.TILE_SIZE, robot)){
        global.playerY += global.TILE_SIZE;
        moved = true;
    }
    if (key_upleft && !scr_collisionCheck(global.playerX - global.TILE_SIZE, global.playerY - global.TILE_SIZE, robot)){
        global.playerX -= global.TILE_SIZE;
        global.playerY -= global.TILE_SIZE;
        moved = true;
    }
    if (key_upright && !scr_collisionCheck(global.playerX + global.TILE_SIZE, global.playerY - global.TILE_SIZE, robot)){
        global.playerX += global.TILE_SIZE;
        global.playerY -= global.TILE_SIZE;
        moved = true;
    }
    if (key_downleft && !scr_collisionCheck(global.playerX - global.TILE_SIZE, global.playerY + global.TILE_SIZE, robot)){
        global.playerX -= global.TILE_SIZE;
        global.playerY += global.TILE_SIZE;
        moved = true;
    }
    if (key_downright && !scr_collisionCheck(global.playerX + global.TILE_SIZE, global.playerY + global.TILE_SIZE, robot)){
        global.playerX += global.TILE_SIZE;
        global.playerY += global.TILE_SIZE;
        moved = true;
    }
    
    //GOTO ROOM
    if (instance_place(global.playerX, global.playerY, obj_gotoRoom)){
        x = global.playerX;
        y = global.playerY;
        moved = false;
        handle_freeRoomMemory();
    }
    
    if (moved){ 
        ds_stack_push(obj_player.moveHistory, string(x) + "," + string(y)); //pushing previous turn's movement
        ds_stack_push(obj_player.itemHistory, array(obj_player.numKeys));
        print("Pushed onto player's stack !");
        global.oldPlayerX = x;
        global.oldPlayerY = y;
        x = global.playerX; 
        y = global.playerY; 
    }
}

//print(obj_player.numKeys);

move = false;
