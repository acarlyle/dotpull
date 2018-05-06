///handle_gotoRoom(room rmName, var state)

var rm = argument0;
var state = argument1; // { gotoRoom, undoRoom }

print("handle_gotoRoom(" + string(rm) + ", " + string(state) + ");");

var saveFileName = string(rm) + ".sav";

if state == "gotoRoom" { // push curPositions of robots/objects
    with (par_robot) push_robotState(self, true, 0, 0); //0, 0 because we're only pushing the current pos
    with (par_robot) handle_pushOntoStack(self, true); //push final state of room, cur obj positions
}

handle_roomSave(); //TODO - rm arg/replace obj_player arg

room_goto(rm);

handle_freeMemory();

print("");
print("----------------------------------------------");
print("----------ROOM TRANSITION------------");
print("----------------------------------------------");
print("");
