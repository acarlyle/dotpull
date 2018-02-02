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
    if (inst.isSpike){
        if (inst.targetLocked){
            print("target locked, shuffling list");
            print(inst.state);
            print(inst.targetDirection);
            ds_list_insert(list, 0, inst);
            ds_list_delete(list, i);
        }
    }
}

//falling platforms are still tiptop priority
for (var i = 0; i < ds_list_size(list); i++){
    var inst = ds_list_find_value(list, i);
    if (inst.isFallingPlatform){
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
