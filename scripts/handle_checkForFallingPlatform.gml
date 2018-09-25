///handle_checkForFallingPlatform(obj_layer, obj_enum object)

var layer = argument0;
var object = argument1;

//print("handle_checkForFallingPlatform()"); 

if (object[| OBJECT.X] == object[| OBJECT.OLDPOSX]) &&
   (object[| OBJECT.Y] == object[| OBJECT.OLDPOSY])
{
    print("handle_checkForFallingPlatforrm x,y: " + string(object[| OBJECT.X]) + "," +  string(object[| OBJECT.Y]) + "; old x,y: " + string(object[| OBJECT.OLDPOSX]) + "," +  string(object[| OBJECT.OLDPOSY]));
    return false; // don't update falling platform status until rob/obj has moved off the tile
}

if (map_place(layer, par_fallingPlatform, object[| OBJECT.OLDPOSX], object[| OBJECT.OLDPOSY])){
    var fallingPlatform = map_place(layer, par_fallingPlatform, object[| OBJECT.OLDPOSX], object[| OBJECT.OLDPOSY]);
    
    fallingPlatform[| PLATFORM.STEPSLEFT] -= 1;
    if (fallingPlatform[| OBJECT.IMGIND] != 0){
        fallingPlatform[| OBJECT.IMGIND] -= 1;
    }
    
    //print("handle_checkForFallingPlatform: Falling platform steps left now: " + string(fallingPlatform[| PLATFORM.STEPSLEFT]));
    
    if (fallingPlatform[| PLATFORM.STEPSLEFT] == 0){
        fallingPlatform[| OBJECT.ISACTIVE] = false;
        
        //print("handle_checkForFallingPlatform obj_fallingPlatform no longer active!"); 
    }
}
