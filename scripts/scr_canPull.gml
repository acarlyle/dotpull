///scr_canPull(int objPosX, int objPosY)

if (instance_place(argument0, argument1, obj_player)){
    print("Can't move, player in the way");
    return false; //there's a player here!!  don't move!
}

//checks if there's an object in between this object and the player
//to see if the object's pull is getting blocked by that object.  if it is, return false

//obj_player.x
//obj_player.y
//x
//y
var xDiff = obj_player.x - x;
var yDiff = obj_player.y - y;

if (yDiff == 0){ //player is moving left/right; check for objects towards the player
    if (xDiff > 0){ //player is to the right of the key
        for (var objX = x; objX < obj_player.x; objX += 16){
            if (instance_place(objX, y, par_obstacle)) return false; //don't pull if anything is in the way
        }
    }
    else{ //player is to the left of the key
        for (var objX = x; objX > obj_player.x; objX -= 16){
            if (instance_place(objX, y, par_obstacle)) return false; //don't pull if anything is in the way
        }
    }
}
if (xDiff == 0){ //player is moving up/down; check for objects towards the player
    if (yDiff < 0){ //player is above the key
        for (var objY = y; objY > obj_player.y; objY -= 16){
            if (instance_place(x, objY, par_obstacle)) return false; //don't pull if anything is in the way
        }
    }
    else{ //player is below the key
        for (var objY = y; objY < obj_player.y; objY += 16){
            if (instance_place(x, objY, par_obstacle)) return false; //don't pull if anything is in the way
        }
    }
}
if (xDiff < 0 && yDiff < 0){ //upleft
    var objX = x; var objY = y;
    print(objX);
    print(objY);
    for (objX = x; objX > obj_player.x; objX += xDiff){
        if (instance_place(x, objY+yDiff, par_obstacle)) return false; //don't pull if anything is in the way
        objY += yDiff;    
    }
}
if (xDiff > 0 && yDiff < 0){ //upright

}
if (xDiff < 0 && yDiff > 0){ //downleft

}
if (xDiff < 0 && yDiff < 0){ //downright

}


return true;
