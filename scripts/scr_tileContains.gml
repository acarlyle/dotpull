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
        print("Tile contains: " + object_get_name(self));
        return true;
    }
}


return true;
