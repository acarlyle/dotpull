///handle_checkLowerRoom(obj_layer layer, var robot)

/*
    Check if there's an object on the floor below that Robot can move to.  
*/

var layer = argument0;
var robot = argument1;


if (robot[| ROBOT.CANMOVE]){
    if ((global.key_left && scr_steppingStoneBelow(robot[| ROBOT.NEWX] - global.TILE_SIZE, robot[| ROBOT.NEWY], get_lowerRoomName(room_get_name(room))))){
        robot[| ROBOT.NEWX] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "left";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_right && scr_steppingStoneBelow(robot[| ROBOT.NEWX] + global.TILE_SIZE, robot[| ROBOT.NEWY], get_lowerRoomName(room_get_name(room))))){
        robot[| ROBOT.NEWX] += global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "right";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_up && scr_steppingStoneBelow(robot[| ROBOT.NEWX], robot[| ROBOT.NEWY] - global.TILE_SIZE, get_lowerRoomName(room_get_name(room))))){
        robot[| ROBOT.NEWY] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "up";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_down && scr_steppingStoneBelow(robot[| ROBOT.NEWX], robot[| ROBOT.NEWY] + global.TILE_SIZE, get_lowerRoomName(room_get_name(room))))){
        robot[| ROBOT.NEWY] += global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "down";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_upleft && scr_steppingStoneBelow(robot[| ROBOT.NEWX] - global.TILE_SIZE, robot[| ROBOT.NEWY] - global.TILE_SIZE, get_lowerRoomName(room_get_name(room))))){
        robot[| ROBOT.NEWX] -= global.TILE_SIZE;
        robot[| ROBOT.NEWY] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "upleft";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_upright && scr_steppingStoneBelow(robot[| ROBOT.NEWX] + global.TILE_SIZE, robot[| ROBOT.NEWY] - global.TILE_SIZE, get_lowerRoomName(room_get_name(room))))){
        robot[| ROBOT.NEWX] += global.TILE_SIZE;
        robot[| ROBOT.NEWY] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "upright";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_downleft && scr_steppingStoneBelow(robot[| ROBOT.NEWX] - global.TILE_SIZE, robot[| ROBOT.NEWY] + global.TILE_SIZE, get_lowerRoomName(room_get_name(room))))){
        robot[| ROBOT.NEWX] -= global.TILE_SIZE;
        robot[| ROBOT.NEWY] += global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "downleft";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_downright && scr_steppingStoneBelow(robot[| ROBOT.NEWX] - global.TILE_SIZE, robot[| ROBOT.NEWY] + global.TILE_SIZE, get_lowerRoomName(room_get_name(room))))){
        robot[| ROBOT.NEWX] += global.TILE_SIZE;
        robot[| ROBOT.NEWY] += global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "downright";
        robot[| OBJECT.MOVED] = true;
    }
}
