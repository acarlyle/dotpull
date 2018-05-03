///handle_gotoRoom(room rmName)

var rm = argument0;

print("handle_gotoRoom(" + string(room_get_name(rm)) + ")");

var saveFileName = string(rm) + ".sav";

//if (file_exists(saveFileName)){
//    room_goto(rm);
//    with(all) instance_destroy(self);
//}

with (par_robot) handle_pushOntoStack(self); //push final state of room
handle_roomSave(); //TODO - rm arg/replace obj_player arg

room_goto(rm);

//print("we went to room !");
