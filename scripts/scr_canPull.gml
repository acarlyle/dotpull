///scr_canPull(int objPosX, int objPosY, bool moveDiag)

if (!canPull) return false;

if (instance_place(x, y, obj_triggerDoor) && !instance_place(argument0, argument1, obj_wall)){
    print("obj trapped above");
    return false; //can't move if above
}

if (!instance_place(argument0, argument1, par_platform)) return false;

//print("well at least we can pull");

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

var xDiff = obj_player.x - x;
var yDiff = obj_player.y - y;

if (yDiff == 0){ //player is moving left/right; check for objects towards the player
    if (xDiff > 0){ //player is to the right of the obj
        for (var objX = x + 16; objX < obj_player.x; objX += 16){
            if (instance_place(objX, y, par_obstacle)){
                var obs = instance_place(objX, y, par_obstacle);
                if (isActivated(obs)){
                    return false; //don't pull if anything is in the way
                }
            }
        }
    }
    else{ //player is to the left of the obj
        for (var objX = x - 16; objX > obj_player.x; objX -= 16){
            if (instance_place(objX, y, par_obstacle)){
                var obs = instance_place(objX, y, par_obstacle);
                if (isActivated(obs)){
                    return false; //don't pull if anything is in the way
                }
            }
        }
    }
}
if (xDiff == 0){ //player is moving up/down; check for objects towards the player
    if (yDiff < 0){ //player is above the obj
        for (var objY = y - 16; objY > obj_player.y; objY -= 16){
            if (instance_place(x, objY, par_obstacle)){
                var obs = instance_place(x, objY, par_obstacle);
                print("isDeactived?");
                if (isActivated(obs)){
                    return false; //don't pull if anything is in the way
                }
            }
        }
    }
    else{ //player is below the obj
        for (var objY = y + 16; objY < obj_player.y; objY += 16){
            if (instance_place(x, objY, par_obstacle)){
                var obs = instance_place(x, objY, par_obstacle);
                print(obs.isDeactivated);
                if (!obs.isDeactivated){
                    print("oh no it is activated");
                    return false; //don't pull if anything is in the way
                }
            }
        }
    }
}

if (instance_place(argument0, argument1, obj_trigger)){
    print("There's a trigger here.");
    return true;
}
if (instance_place(argument0, argument1, obj_triggerDoor)){
    print("There's a triggerDoor here.");
    var triggerDoor = instance_place(argument0, argument1, obj_triggerDoor);
    if (triggerDoor.isDeactivated) return true;
    return false;
}

//diagonal movement
if (argument2 == true){
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
