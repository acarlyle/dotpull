///handle_freeRoomMemory()

print("Handling free room memory");

//clear player memory
ds_stack_clear(obj_player.moveHistory);
ds_stack_clear(obj_player.itemHistory);

//clear room contents memory
for (var i = 0; i < array_length_1d(global.roomContents); i++){
    with(global.roomContents[i]){
        print("Handling " + object_get_name(global.roomContents[i].object_index));
        if (stateHistory){
            print("Destroying State history");
            ds_stack_destroy(stateHistory);
        }
        print("Destroying moveHistory");
        ds_stack_destroy(moveHistory);
    }
}

print("Allocated memory has been freed woopidy woo!");
