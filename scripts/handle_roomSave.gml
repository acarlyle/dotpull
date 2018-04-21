///handle_roomSave()

print("-> handle_roomSave()");

var robot = argument0;

/*
    This shit saves the room's current object positions along with all of the dynamic 
    memory used by it into a file so that it can be returned to normal when a player comes
    back and not reinitialized.  
    FILE FORMAT
    
    *****
    ---
    var fileName
    ---
    
    *****
*/

var roomName = room_get_name(room);
var roomSaveFileName = roomName + ".sav"; //should have a bkp file in case of failure to save/load
if (file_exists(roomSaveFileName)) file_delete(roomSaveFileName);

var roomSaveFile = file_text_open_write(roomSaveFileName);
file_text_write_real(roomSaveFile, robot.moveHistory);
file_text_close(roomSaveFile);

roomSaveFile = file_text_open_read(roomSaveFileName);
var something = file_text_read_real(roomSaveFile);
file_text_close(roomSaveFile);

print(ds_stack_top(something));  
print("Room saved!");
