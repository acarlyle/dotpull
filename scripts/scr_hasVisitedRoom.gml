///scr_hasVisitedRoom(par_robot robot, var roomName)

var robot = argument0;
var roomName = argument1;

if (ds_list_find_index(robot.roomsVisited, roomName) != -1) { return true; }
return false;
