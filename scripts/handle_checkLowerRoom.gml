///handle_checkLowerRoom(var robot)

/*
    Check if there's an object on the floor below that Robot can move to.  
*/

var robot = argument0;


if (robot.canMove){
    if ((global.key_left && scr_steppingStoneBelow(robot.playerX - global.TILE_SIZE, robot.playerY, get_lowerRoomName(room_get_name(room))))){
        robot.playerX -= global.TILE_SIZE;
        robot.movedDir = "left";
        robot.moved = true;
    }
    if ((global.key_right && scr_steppingStoneBelow(robot.playerX + global.TILE_SIZE, robot.playerY, get_lowerRoomName(room_get_name(room))))){
        robot.playerX += global.TILE_SIZE;
        robot.movedDir = "right";
        robot.moved = true;
    }
    if ((global.key_up && scr_steppingStoneBelow(robot.playerX, robot.playerY - global.TILE_SIZE, get_lowerRoomName(room_get_name(room))))){
        robot.playerY -= global.TILE_SIZE;
        robot.movedDir = "up";
        robot.moved = true;
    }
    if ((global.key_down && scr_steppingStoneBelow(robot.playerX, robot.playerY + global.TILE_SIZE, get_lowerRoomName(room_get_name(room))))){
        robot.playerY += global.TILE_SIZE;
        robot.movedDir = "down";
        robot.moved = true;
    }
    if ((global.key_upleft && scr_steppingStoneBelow(robot.playerX - global.TILE_SIZE, robot.playerY - global.TILE_SIZE, get_lowerRoomName(room_get_name(room))))){
        robot.playerX -= global.TILE_SIZE;
        robot.playerY -= global.TILE_SIZE;
        robot.movedDir = "upleft";
        robot.moved = true;
    }
    if ((global.key_upright && scr_steppingStoneBelow(robot.playerX + global.TILE_SIZE, robot.playerY - global.TILE_SIZE, get_lowerRoomName(room_get_name(room))))){
        robot.playerX += global.TILE_SIZE;
        robot.playerY -= global.TILE_SIZE;
        robot.movedDir = "upright";
        robot.moved = true;
    }
    if ((global.key_downleft && scr_steppingStoneBelow(robot.playerX - global.TILE_SIZE, robot.playerY + global.TILE_SIZE, get_lowerRoomName(room_get_name(room))))){
        robot.playerX -= global.TILE_SIZE;
        robot.playerY += global.TILE_SIZE;
        robot.movedDir = "downleft";
        robot.moved = true;
    }
    if ((global.key_downright && scr_steppingStoneBelow(robot.playerX - global.TILE_SIZE, robot.playerY + global.TILE_SIZE, get_lowerRoomName(room_get_name(room))))){
        robot.playerX += global.TILE_SIZE;
        robot.playerY += global.TILE_SIZE;
        robot.movedDir = "downright";
        robot.moved = true;
    }
}
