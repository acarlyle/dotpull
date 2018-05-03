///scr_initRoom

/*
    Called in every room's creation code  
*/

if (scr_hasVisitedRoom(obj_player, room_get_name(room))){  
    if (file_exists(room_get_name(room) + ".sav")){ scr_initRoomFromFile(room_get_name(room));}
}
else ds_list_add(obj_player.roomsVisited, room_get_name(room));

with(obj_roberta){
    print("init roberta");
    playerX = x; //set player x and y position
    playerY = y; 
    
    //robot = instance_create(playerX, playerY, obj_roberta);
    x = playerX;
    y = playerY;
    var initPos = string(x) + "," + (string(y));
    print("initPos:" + initPos);
    ds_stack_push(moveHistory, initPos);
    ds_stack_push(itemHistory, array(numKeys));
    
}

var list = ds_list_create();


//EXTREMELY IMPORTANT THAT OBJ BLOCKS ARE AT THE BEGINING OF THE LIST!!!!!!!  SAME WITH FALLING PLATS!!!
with (all) {
    if (isPuzzleElement){
        //if (instance_place(x, y, obj_block)){
        if (isMovePriority){ 
            ds_list_insert(list, 0, self);
            //print(object_index);
        }
        else{
            ds_list_add(list, self);
            //print(object_index);
        }
        //if (isSpike) print("is spike");
        //print("added this object to ds list");
    }
}

for (var i = 0; i < ds_list_size(list); i++){
    var inst = ds_list_find_value(list, i);
    if (object_get_name(inst.object_index) == "obj_magneticSnare"){
        ds_list_delete(list, i);
        ds_list_insert(list, 0, inst);
    }
}

for (var i = 0; i < ds_list_size(list); i++){
    var inst = ds_list_find_value(list, i);
    if (parentOf(inst) == "par_breakableWall"){
        //print("moving breakableWall up to the tippy top of the priority list");
        ds_list_delete(list, i);
        ds_list_insert(list, 0, inst);
    }
}
//Cannon objects need to be pushed nexgt because they can break walls
for (var i = 0; i < ds_list_size(list); i++){
    var inst = ds_list_find_value(list, i);
    if (parentOf(inst) == "par_cannon"){
        //print("moving breakableWall up to the tippy top of the priority list");
        ds_list_delete(list, i);
        ds_list_insert(list, 0, inst);
    }
}
for (var i = 0; i < ds_list_size(list); i++){
    var inst = ds_list_find_value(list, i);
    if (inst.isFallingPlatform){
        //print("moving falling platform up to the tippy top of the priority list");
        ds_list_delete(list, i);
        ds_list_insert(list, 0, inst);
    }
}


//ds_list_sort(list, true);

//print("finished creating list");

var arr = roomObjectArrayList(list);

//print("checking array x values");

ds_list_destroy(list);
return arr;
