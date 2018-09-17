///scr_tileContains_curRoom(var objPosX, var objPosY, array objectList[])

/*
    Script returns true if the tile specified by the args objPosX and objPosY
    contain one of the objects passed in the objectList.  Otherwise, returns
    false.
*/

var objPosX = argument0;
var objPosY = argument1;
var objectList = argument2; //contains par_robot, par_obstacle

//asset_get_index(object_get_name(object))

/*for (var i = 0; i < array_length_1d(objectList); i++){
    var object = objectList[i];

//print("-> scr_tileContains(" + string(objPosX) + ", " + string(objPosY) + ")"); 

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


//print("scr_tileContains_curRoom(" + string(objPosX) + "," + string(objPosY) + string(object_get_name(objectList[i])) + ")");


for (var i = 0; i < array_length_1d(objectList); i++){
    var object = objectList[i];
    
    var tile = instance_place(objPosX, objPosY, par_platform);
    if (!tile) tile = instance_place(objPosX, objPosY, par_fallingPlatform);
    
    with(tile){ //falling platform is hardcoded below because place_meeting checks for 2 instances
        //print("here1");
        //print("object: " + string(object_get_name(object.object_index)));
        //print("assetIndexName: " + string(object_get_name(asset_get_index(object_get_name(object)).object_index)));
        //print(instance_place(objPosX, objPosY, object).object_index);
        
        //print(object);
        //print(object.id);
        //print(object.object_index);
        //print(obj_block);
        
        //if (objPosX == 112 && objPosY == 176)
            //print("scr_tileContains_curRoom" + string(object_get_name(object)));

        
        //if (place_meeting(objPosX, objPosY, object) || instance_place(objPosX, objPosY, object)){
        if (place_meeting(objPosX, objPosY, object)){
            print(string(object_get_name(object.object_index)) + " contained at: " + string(objPosX) + "," + string(objPosY)); 
            return true;
        }
    }
    //falling platform is not captured in the place_meeting, because that checks for coll. between 2 instances
    //if (object_get_parent(object) == par_fallingPlatform){ 
    //    if instance_place(objPosX, objPosY, par_fallingPlatform){
    //        print("FALLING PLAT!!!!");
    //        return true;
    //    }
    //}
}

if ((objPosY > 200 || objPosY < -200) || (objPosX > 200 || objPosX < -200)){
    print("WARNING WAY THE FUCK OUT OF WHILE LOOP BOUNDS in (par script, now in scr_tileContains)");
    return true; //hardcoded to prevent infinite loop
}

return false;
