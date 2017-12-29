///handle_gameMove();

print("handle game move");
var objMove = false;

for (var i = 0; i < array_length_1d(global.roomContents); i++){
    with(global.roomContents[i]){
        if (global.oldPlayerY == y && obj_player.y == y){ //player moved left/right
            if (obj_player.x < x && scr_canPull(x - 16, y)) //player on left side of object 
                x -= 16;
            else if (obj_player.x > x && scr_canPull(x + 16, y))//player on right side of object
                x += 16;
        }
        if (global.oldPlayerX == x && obj_player.x == x){ //player moved up/down
            if (obj_player.y < y && scr_canPull(x, y - 16)) //player above object 
                y -= 16;
            else if (obj_player.y > y && scr_canPull(x, y + 16))//player below object 
                y += 16;
        }
        if scr_canPull((obj_player.x - global.oldPlayerX) + x, (obj_player.y - global.oldPlayerY) + y){
            print("diag time baby");
            x += (obj_player.x - global.oldPlayerX);
            y += (obj_player.y - global.oldPlayerY);
        }
        if (objMove){ //append new position to obj's stack; we do this if player moves
            ds_stack_push(moveHistory, string(x) + "," + string(y))
        }
    }
}

moved = false;
