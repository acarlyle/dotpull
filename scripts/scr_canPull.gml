///scr_canPull(int objPosX, int objPosY, bool moveDiag)

if (!canPull) return false;

if (!instance_place(argument0, argument1, par_platform)) return false;

//print("well at least we can pull");

if (instance_place(argument0, argument1, obj_player)){
    print("Can't move, player in the way");
    //print(string(argument0)); print(string(argument1)); print(string(obj_player.x)); print(string(obj_player.y));
    //print(string(global.oldPlayerX)); print(string(global.oldPlayerY));
    return false; //there's a player here!!  don't move!
}
if (instance_place(argument0, argument1, obj_hole)){
    print("Can't move, hole in the way");
    if (!canFall) return false; //there's a hole here!!  don't move unless you can go over holes!
}
if (instance_place(argument0, argument1, obj_trigger)){
    print("There's a trigger here.");
    return true;
}

if (isDeactivated == true){
    if (x != 0 && y != 0){
        print("Not deactivated anymore");
        isDeactivated = false;
        //obj_player.numKeys--;
    }
    else{
        print("Obj deactivated"); 
        return false; //do not pull this object
    }
}

//print(string(argument0)); print(string(argument1)); print(string(obj_player.x)); print(string(obj_player.y));
//print(string(global.oldPlayerX)); print(string(global.oldPlayerY));

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
        for (var objX = x + 16; objX < obj_player.x; objX += 16){
            if (instance_place(objX, y, par_obstacle)) return false; //don't pull if anything is in the way
        }
    }
    else{ //player is to the left of the key
        for (var objX = x - 16; objX > obj_player.x; objX -= 16){
            if (instance_place(objX, y, par_obstacle)) return false; //don't pull if anything is in the way
        }
    }
}
if (xDiff == 0){ //player is moving up/down; check for objects towards the player
    if (yDiff < 0){ //player is above the key
        for (var objY = y - 16; objY > obj_player.y; objY -= 16){
            if (instance_place(x, objY, par_obstacle)) return false; //don't pull if anything is in the way
        }
    }
    else{ //player is below the key
        for (var objY = y + 16; objY < obj_player.y; objY += 16){
            if (instance_place(x, objY, par_obstacle)) return false; //don't pull if anything is in the way
        }
    }
}

if (argument2 == true){ //diagonal movement
    if (obj_player.y < y && obj_player.x > x){ //player is above the obj and to the right; pull object upright
        //print("pull object up right");
        var objX = x+16; var objY = y-16;
        //print(objX);
        //print(objY);
        for (objX = x + 16; objX < obj_player.x; objX += 16){
            //print("In that upright loop !");
            //print(objX);
            //print(objY);  
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY -= 16;  
        }
    }
    if (obj_player.y < y && obj_player.x < x){ //player is above the obj and to the left; pull object upleft
        //print("pull object up left");
        var objX = x-16; var objY = y-16;
        //print(objX);
        //print(objY);
        for (objX = x - 16; objX > obj_player.x; objX -= 16){
            //print("In that left loop !");
            //print(objX);
            //print(objY);  
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY -= 16;  
        }
    }
    if (obj_player.y > y && obj_player.x > x){ //player is below the obj and to the right; pull object downright
        //print("pull object down right");
        var objX = x+16; var objY = y+16;
        //print(objX);
        //print(objY);
        for (objX = x + 16; objX < obj_player.x; objX += 16){
            //print("In that downright loop !");
            //print(objX);
            //print(objY);  
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY += 16;  
        }          
    }
    if (obj_player.y > y && obj_player.x < x){ //player is below the obj and to the left; pull object downleft
        //print("pull object down left");
        var objX = x-16; var objY = y+16;
        //print(objX);
        //print(objY);
        for (objX = x - 16; objX > obj_player.x; objX -= 16){
            //print("In that downleft loop !");
            //print(objX);
            //print(objY);  
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY += 16;  
        }    
    }   
}

        



return true;
