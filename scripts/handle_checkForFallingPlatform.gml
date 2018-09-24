///handle_checkForFallingPlatform(obj_layer, obj_enum object)

var layer = argument0;
var object = argument1;

//print("handle_checkForFallingPlatform()"); 

if (map_place(layer, par_fallingPlatform, object[| OBJECT.OLDPOSX], object[| OBJECT.OLDPOSY])){
    var fallingPlatform = map_place(layer, par_fallingPlatform, object[| OBJECT.OLDPOSX], object[| OBJECT.OLDPOSY]);
    fallingPlatform[| PLATFORM.STEPSLEFT] -= 1;
    fallingPlatform[| OBJECT.IMGIND] += 1;
    
    //print("handle_checkForFallingPlatform: Falling platform steps left now: " + string(fallingPlatform[| PLATFORM.STEPSLEFT]));
    
    if (fallingPlatform[| PLATFORM.STEPSLEFT] == 0){
        fallingPlatform[| OBJECT.ISACTIVE] = false;
        
        //print("handle_checkForFallingPlatform obj_fallingPlatform no longer active!"); 
    }
}
