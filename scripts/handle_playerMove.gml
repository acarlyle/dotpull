///handle_playerMove

print("handle player move");

//ds_stack_push(obj_player.moveHistory, string(x) + "," + string(y)); //pushing previous turn's movement
//ds_stack_push(obj_player.itemHistory, array(obj_player.numKeys));
//print("Pushed onto player's stack !");

if (key_left && !scr_collisionCheck(global.playerX - global.TILE_SIZE, global.playerY)){
    global.playerX -= global.TILE_SIZE;
    moved = true;
}
if (key_right && !scr_collisionCheck(global.playerX + global.TILE_SIZE, global.playerY)){
    global.playerX += global.TILE_SIZE;
    moved = true;
}
if (key_up && !scr_collisionCheck(global.playerX, global.playerY - global.TILE_SIZE)){
    global.playerY -= global.TILE_SIZE;
    moved = true;
}
if (key_down && !scr_collisionCheck(global.playerX, global.playerY + global.TILE_SIZE)){
    global.playerY += global.TILE_SIZE;
    moved = true;
}
if (key_upleft && !scr_collisionCheck(global.playerX - global.TILE_SIZE, global.playerY - global.TILE_SIZE)){
    global.playerX -= global.TILE_SIZE;
    global.playerY -= global.TILE_SIZE;
    moved = true;
}
if (key_upright && !scr_collisionCheck(global.playerX + global.TILE_SIZE, global.playerY - global.TILE_SIZE)){
    global.playerX += global.TILE_SIZE;
    global.playerY -= global.TILE_SIZE;
    moved = true;
}
if (key_downleft && !scr_collisionCheck(global.playerX - global.TILE_SIZE, global.playerY + global.TILE_SIZE)){
    global.playerX -= global.TILE_SIZE;
    global.playerY += global.TILE_SIZE;
    moved = true;
}
if (key_downright && !scr_collisionCheck(global.playerX + global.TILE_SIZE, global.playerY + global.TILE_SIZE)){
    global.playerX += global.TILE_SIZE;
    global.playerY += global.TILE_SIZE;
    moved = true;
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

//print(obj_player.numKeys);

move = false;
