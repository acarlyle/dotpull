///handle_prioritizeItems()

print("Handling prioritize items");
//create list to prioritze items
list = ds_list_create();

for (var i = 0; i < array_length_1d(global.roomContents); i++){
    ds_list_add(list, global.roomContents[i]);
}

//if we have active spikes, we need them to move before idle ones
for (var i = 0; i < ds_list_size(list); i++){
    var inst = ds_list_find_value(list, i);
    if (objectStr(inst) == "obj_spike"){
        if (inst.targetLocked){
            //print("target locked, shuffling list");
            print(inst.state);
            print(inst.targetDirection);
            ds_list_delete(list, i);
            ds_list_insert(list, 0, inst);
        }
        //else{
        //    print("target not locked, not prioritized");
        //}
    }
}
//Magnetic Snares super important too
for (var i = 0; i < ds_list_size(list); i++){
    var inst = ds_list_find_value(list, i);
    if (object_get_name(inst.object_index) == "obj_magneticSnare"){
        ds_list_delete(list, i);
        ds_list_insert(list, 0, inst);
    }
}
//Breakable walls next highest priority
for (var i = 0; i < ds_list_size(list); i++){
    var inst = ds_list_find_value(list, i);
    if (get_parent(inst) == "par_breakableWall"){
        //print("moving breakableWall up to the tippy top of the priority list");
        ds_list_delete(list, i);
        ds_list_insert(list, 0, inst);
    }
}
//Cannon objects need to be pushed nexgt because they can break walls walls
for (var i = 0; i < ds_list_size(list); i++){
    var inst = ds_list_find_value(list, i);
    if (get_parent(inst) == "par_cannon"){
        //print("moving breakableWall up to the tippy top of the priority list");
        ds_list_delete(list, i);
        ds_list_insert(list, 0, inst);
    }
}
//falling platforms are still tiptop priority
for (var i = 0; i < ds_list_size(list); i++){
    var inst = ds_list_find_value(list, i);
    if (get_parent(inst) == "par_fallingPlatform"){
        ds_list_delete(list, i);
        ds_list_insert(list, 0, inst);
    }
}

//assign new priorities to the global.roomContents array
for (var i = 0; i < array_length_1d(global.roomContents); i++){
    global.roomContents[i] = ds_list_find_value(list, i);
}
//destory allocated list now that shuffling is complete
ds_list_destroy(list);
