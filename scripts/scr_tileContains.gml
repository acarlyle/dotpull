///scr_tileContains(var objPosX, var objPosY, array objectList[])

/*
    Script returns true if the tile specified by the args objPosX and objPosY
    contain one of the objects passed in the objectList.  Otherwise, returns
    false.
*/

var objPosX = argument0;
var objPosY = argument1;
var objectList = argument2; //contains par_robot, par_obstacle

print("-> scr_tileContains(" + string(objPosX) + ", " + string(objPosY) + ")"); 

for (var i = 0; i < array_length_1d(objectList); i++){
    var object = objectList[i];
        if (instance_place(objPosX, objPosY, object)){
            if (instance_place(objPosX, objPosY, par_obstacle)){
                var obs = instance_place(objPosX, objPosY, par_obstacle);
                if (isActivated(obs)){
                    print("Tile contains an activated: " + object_get_name(obs));
                    return true;
                }
        }
        print("Tile contains: " + object_get_name(object));
        return true;
    }
}

if ((objPosY > 1000 || objPosY < -1000) || (objPosX > 1000 || objPosX < -1000)){
    print("WARNING WAY OUT OF WHILE LOOP BOUNDS in scr_tileContains");
    return true; //hardcoded to prevent infinite loop
}

return false;
