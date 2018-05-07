///handle_restartRoom()

/*
    Restarts the stacks to the begining of the current room.  
*/

print(" -> handle_restartRoom() ");

with (par_robot){
    while (!ds_stack_empty(moveHistory)){
        var robot_moveTop = ds_stack_top(moveHistory);
        var robot_roomAndPos =  scr_split(robot_moveTop, ";");
        if (robot_roomAndPos[0] != room_get_name(room)) break;
        handle_undoMove(self);
        //print("POPPED!!!");
    }
}   

print("Stacks have been fully popped my liege");
