///handle_restartRoom()

var layer = argument0;

/*
    Restarts the stacks to the begining of the current room.  
*/

print(" -> handle_restartRoom() ");

instance_destroy(layer);
room_goto(room);

global.restartRoom = true;

print("Stacks have been fully popped my liege");
