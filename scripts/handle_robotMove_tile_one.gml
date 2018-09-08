///handle_robotMove_tile_one(obj_layer layer, par_robot robot)

var layer = argument0;
var robot = argument1;

print("");
print("HANDLE_ROBOTMOVE_TILE_ONE FOR " + robot[| OBJECT.NAME]);

print("Robot X: " + string(robot[| OBJECT.X]));
print("Robot Y: " + string(robot[| OBJECT.X]));

//handle arrow logic
if (map_place(layer, par_arrow, robot[| OBJECT.X], robot[| OBJECT.Y])){
    var arrow = map_place(layer, par_arrow, robot[| OBJECT.X], robot[| OBJECT.Y]);
        switch(arrow.dir){
            case "up":
                if (!global.key_up && !global.key_upleft && !global.key_upright) robot[| ROBOT.CANMOVE] = false;
                break; 
            case "right":
                if (!global.key_right && !global.key_upright && !global.key_downright) robot[| ROBOT.CANMOVE] = false;
                break; 
            case "left":
                if (!global.key_left && !global.key_upleft && !global.key_downleft) robot[| ROBOT.CANMOVE] = false;
                break; 
            case "down":
                if (!global.key_down && !global.key_downleft && !global.key_downright) robot[| ROBOT.CANMOVE] = false;
                break; 
        }
}

if (robot[| ROBOT.CANMOVE]){
<<<<<<< HEAD
    if ((global.key_left) && !scr_collisionCheck(layer, robot[| ROBOT.NEWX] - global.TILE_SIZE, robot[| ROBOT.NEWY], robot)){
        robot[| ROBOT.NEWX] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "left";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_right) && !scr_collisionCheck(layer, robot[| ROBOT.NEWX] + global.TILE_SIZE, robot[| ROBOT.NEWY], robot)){
        robot[| ROBOT.NEWX] += global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "right";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_up) && !scr_collisionCheck(layer, robot[| ROBOT.NEWX], robot[| ROBOT.NEWY] - global.TILE_SIZE, robot)){
        robot[| ROBOT.NEWY] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "up";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_down) && !scr_collisionCheck(layer, robot[| ROBOT.NEWX], robot[| ROBOT.NEWY] + global.TILE_SIZE, robot)){
        robot[| ROBOT.NEWY] += global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "down";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_upleft) && !scr_collisionCheck(layer, robot[| ROBOT.NEWX] - global.TILE_SIZE, robot[| ROBOT.NEWY] - global.TILE_SIZE, robot)){
        robot[| ROBOT.NEWX] -= global.TILE_SIZE;
        robot[| ROBOT.NEWY] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "upleft";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_upright) && !scr_collisionCheck(layer, robot[| ROBOT.NEWX] + global.TILE_SIZE, robot[| ROBOT.NEWY] - global.TILE_SIZE, robot)){
        robot[| ROBOT.NEWX] += global.TILE_SIZE;
        robot[| ROBOT.NEWY] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "upright";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_downleft) && !scr_collisionCheck(layer, robot[| ROBOT.NEWX] - global.TILE_SIZE, robot[| ROBOT.NEWY] + global.TILE_SIZE, robot)){
        robot[| ROBOT.NEWX] -= global.TILE_SIZE;
        robot[| ROBOT.NEWY] += global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "downleft";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_downright) && !scr_collisionCheck(layer, robot[| ROBOT.NEWX] + global.TILE_SIZE, robot[| ROBOT.NEWY] + global.TILE_SIZE, robot)){
        robot[| ROBOT.NEWX] += global.TILE_SIZE;
        robot[| ROBOT.NEWY] += global.TILE_SIZE;
=======
    if ((global.key_left) && !scr_collisionCheck(layer, robot[| ROBOT.OLDPOSX] - global.TILE_SIZE, robot[| ROBOT.OLDPOSY], robot)){
        robot[| ROBOT.OLDPOSX] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "left";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_right) && !scr_collisionCheck(layer, robot[| ROBOT.OLDPOSX] + global.TILE_SIZE, robot[| ROBOT.OLDPOSY], robot)){
        robot[| ROBOT.OLDPOSX] += global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "right";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_up) && !scr_collisionCheck(layer, robot[| ROBOT.OLDPOSX], robot[| ROBOT.OLDPOSY] - global.TILE_SIZE, robot)){
        robot[| ROBOT.OLDPOSY] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "up";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_down) && !scr_collisionCheck(layer, robot[| ROBOT.OLDPOSX], robot[| ROBOT.OLDPOSY] + global.TILE_SIZE, robot)){
        robot[| ROBOT.OLDPOSY] += global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "down";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_upleft) && !scr_collisionCheck(layer, robot[| ROBOT.OLDPOSX] - global.TILE_SIZE, robot[| ROBOT.OLDPOSY] - global.TILE_SIZE, robot)){
        robot[| ROBOT.OLDPOSX] -= global.TILE_SIZE;
        robot[| ROBOT.OLDPOSY] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "upleft";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_upright) && !scr_collisionCheck(layer, robot[| ROBOT.OLDPOSX] + global.TILE_SIZE, robot[| ROBOT.OLDPOSY] - global.TILE_SIZE, robot)){
        robot[| ROBOT.OLDPOSX] += global.TILE_SIZE;
        robot[| ROBOT.OLDPOSY] -= global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "upright";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_downleft) && !scr_collisionCheck(layer, robot[| ROBOT.OLDPOSX] - global.TILE_SIZE, robot[| ROBOT.OLDPOSY] + global.TILE_SIZE, robot)){
        robot[| ROBOT.OLDPOSX] -= global.TILE_SIZE;
        robot[| ROBOT.OLDPOSY] += global.TILE_SIZE;
        robot[| OBJECT.MOVEDDIR] = "downleft";
        robot[| OBJECT.MOVED] = true;
    }
    if ((global.key_downright) && !scr_collisionCheck(layer, robot[| ROBOT.OLDPOSX] + global.TILE_SIZE, robot[| ROBOT.OLDPOSY] + global.TILE_SIZE, robot)){
        robot[| ROBOT.OLDPOSX] += global.TILE_SIZE;
        robot[| ROBOT.OLDPOSY] += global.TILE_SIZE;
>>>>>>> master
        robot[| OBJECT.MOVEDDIR] = "downright";
        robot[| OBJECT.MOVED] = true;
    }
}
