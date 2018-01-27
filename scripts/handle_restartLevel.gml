///handle_restartLevel()

print("Handling restart level...");

with (par_robot){
    while (!ds_stack_empty(moveHistory)){
        handle_undoMove(self);
        print("POPPED!!!");
    }
}   

print("Stacks have been fully popped my liege");
