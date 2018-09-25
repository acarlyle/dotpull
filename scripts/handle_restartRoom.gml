///handle_restartRoom(obj_layer layer)

var layer = argument0;

/*
    Restarts the stacks to the begining of the current room.  
*/

print(" -> handle_restartRoom() ");

instance_destroy(layer);
room_goto(room);

print("Stacks have been fully popped my liege");
