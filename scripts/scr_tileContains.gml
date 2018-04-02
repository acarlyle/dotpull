///scr_tileContains(var objPosX, var objPosY, array objectList[])

/*
    Script returns true if the tile specified by the args objPosX and objPosY
    contain one of the objects passed in the objectList.  Otherwise, returns
    false.
*/

var objPosX = argument0;
var objPosY = argument1;
var objectList = argument2; //contains par_robot, par_obstacle

//print("-> scr_tileContains(" + string(objPosX) + ", " + string(objPosY) + ")"); 

//asset_get_index(object_get_name(object))

/*for (var i = 0; i < array_length_1d(objectList); i++){
    var object = objectList[i];
    with(object){
        print("here1");
        print("object: " + string(object_get_name(object.object_index)));
        print("assetIndexName: " + string(object_get_name(asset_get_index(object_get_name(object)).object_index)));
        //print(instance_place(objPosX, objPosY, object).object_index);
        
        print(object);
        print(object.id);
        print(object.object_index);
        print(obj_block);
        if (instance_place(objPosX, objPosY, obj_block)){
            print("obj block here: "); 
            print(instance_place(objPosX, objPosY, obj_block));
        }
    }
}*/

for (var i = 0; i < array_length_1d(objectList); i++){
    var object = objectList[i];
    with(instance_place(objPosX, objPosY, par_platform)){
        //print("here1");
        //print("object: " + string(object_get_name(object.object_index)));
        //print("assetIndexName: " + string(object_get_name(asset_get_index(object_get_name(object)).object_index)));
        //print(instance_place(objPosX, objPosY, object).object_index);
        
        //print(object);
        //print(object.id);
        //print(object.object_index);
        //print(obj_block);
        if (place_meeting(objPosX, objPosY, object)){
            //print(string(object_get_name(object.object_index)) + " contaiend in this tile !! "); 
            return true;
        }
    }
}

if ((objPosY > 200 || objPosY < -200) || (objPosX > 200 || objPosX < -200)){
    print("WARNING WAY THE FUCK OUT OF WHILE LOOP BOUNDS in (par script, now in scr_tileContains)");
    return true; //hardcoded to prevent infinite loop
}

return false;
