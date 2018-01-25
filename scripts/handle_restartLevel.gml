///handle_restartLevel()

print("Handling restart level...");

while (!ds_stack_empty(obj_player.moveHistory)){
    handle_undoMove();
    print("POPPED!!!");
}   

print("Stacks have been fully popped my liege");
