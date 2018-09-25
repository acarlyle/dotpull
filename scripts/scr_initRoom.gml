///scr_initRoom

/*
    Called in every room's creation code  
*/

print (" -> scr_initRoom()");

if (!instance_exists(obj_layerManager)) instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, obj_layerManager);

//if (scr_hasVisitedRoom(obj_player, room_get_name(room))){  
//    if (file_exists(room_get_name(room) + ".sav")){ scr_initRoomFromFile(room_get_name(room));}
//}
//else ds_list_add(obj_player.roomsVisited, room_get_name(room));

/*with(obj_roberta){
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
    
}*/

var roomSaveFileName = string(room_get_name(room)) + ".sav";

if (file_exists(roomSaveFileName)) {
    file_delete(roomSaveFileName);
    print("###############################");
    print("###############################");
    print("###############################");
    print("scr_initRoom: Warning: " + string(roomSaveFileName) + " has been deleted!");
}

var priorityElementList = ds_list_create();


//EXTREMELY IMPORTANT THAT OBJ BLOCKS ARE AT THE BEGINING OF THE LIST!!!!!!!  SAME WITH FALLING PLATS!!!
with (all) {
    if (isPuzzleElement){
        //if (instance_place(x, y, obj_block)){
        if (isMovePriority){ 
            ds_list_insert(priorityElementList, 0, self);
            //print(object_index);
        }
        else{
            ds_list_add(priorityElementList, self);
            //print(object_index);
        }
        //print("added this object to ds list");
    }
}

for (var i = 0; i < ds_list_size(priorityElementList); i++){
    var inst = ds_list_find_value(priorityElementList, i);
    if (object_get_name(inst.object_index) == "obj_magneticSnare"){
        ds_list_delete(priorityElementList, i);
        ds_list_insert(priorityElementList, 0, inst);
    }
}

for (var i = 0; i < ds_list_size(priorityElementList); i++){
    var inst = ds_list_find_value(priorityElementList, i);
    if (get_parent(inst) == "par_breakableWall"){
        //print("moving breakableWall up to the tippy top of the priority list");
        ds_list_delete(priorityElementList, i);
        ds_list_insert(priorityElementList, 0, inst);
    }
}
//Cannon objects need to be pushed next because they can break walls
for (var i = 0; i < ds_list_size(priorityElementList); i++){
    var inst = ds_list_find_value(priorityElementList, i);
    if (get_parent(inst) == "par_cannon"){
        //print("moving breakableWall up to the tippy top of the priority list");
        ds_list_delete(priorityElementList, i);
        ds_list_insert(priorityElementList, 0, inst);
    }
}
for (var i = 0; i < ds_list_size(priorityElementList); i++){
    var inst = ds_list_find_value(priorityElementList, i);
    if (get_parent(inst) == "par_fallingPlatform"){
        //print("moving falling platform up to the tippy top of the priority list");
        ds_list_delete(priorityElementList, i);
        ds_list_insert(priorityElementList, 0, inst);
    }
}
for (var i = 0; i < ds_list_size(priorityElementList); i++){
    var inst = ds_list_find_value(priorityElementList, i);
    if (object_get_name(inst.object_index) == "obj_key"){
        ds_list_delete(priorityElementList, i);
        ds_list_insert(priorityElementList, 0, inst);
    }
}

//old way of doing this was ds_list -> 
//var sortedObjArrList = con_roomObjectArrList(priorityElementList);

//handle_activeRooms(); //just draws layer (con_surface) TODO

print("scr_initRoom: priorityElementList size: " + string(ds_list_size(priorityElementList)));

var layer = con_layer(room_get_name(room), priorityElementList);
ds_list_add(global.list_activeLayers, layer); //add layer to layer manager
print("scr_initRoom: added layer of room " + string(layer.roomName) + " to the global.activeLayers ds list in the layerManager.");

with (par_object){
    //if object_index == obj_player continue;
    
    instance_destroy();
}

/*
    Following bits of code cleans up loose memory used on room creation and spawns in objects to use 
    for object_index checks.
*/

var platform = instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, obj_platform);
for (var i = 0; i < ds_list_size(layer.list_objEnums); i++){
    var objEnum = layer.list_objEnums[| i];
    if (!instance_exists(get_objectFromString(objEnum[| OBJECT.NAME]))){ 
        instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, get_objectFromString(objEnum[| OBJECT.NAME]));
        print("scr_initRoom: Created a deactivated " + string(objEnum[| OBJECT.NAME]) + " at " + string(global.DEACTIVATED_X) + "," + string(global.DEACTIVATED_Y));
        print(objEnum[| OBJECT.X]);
        print(objEnum[| OBJECT.Y]);
        print(layer.roomMapArr[16/16, 64/16]);
    }
}

with (all){
    if object_index == obj_player continue; //don't fuck with player's stacks (((yet)))
    
    if (self.isPuzzleElement){
        if (self.moveHistory) ds_stack_destroy(self.moveHistory);
        if (self.stateHistory) ds_stack_destroy(self.stateHistory);
    }
}

ds_list_destroy(priorityElementList);


print("scr_initRoom: END ");
print( "" );


/*//set the state of the object in the list
for (var i = 0; i < ds_list_size(priorityElementList); i++){
    var inst = ds_list_find_value(priorityElementList, i);
    set_objectState(inst);
}

ds_list_destroy(priorityElementList);*/
