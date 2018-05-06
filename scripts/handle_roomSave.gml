///handle_roomSave()

print("-> handle_roomSave()");

var xPos = 0;
var yPos = 0;

/*
    This shit saves the room's current object positions along with all of the dynamic 
    memory used by it into a file so that it can be returned to normal when a player comes
    back and not reinitialized.  
    
    Save file default path is C:\Users\UserName\AppData\Local\beam
    
    *** TODO NOTE ***
        This will need to be hashed to prevent cheat cheat fuckorinos.
    *** END TODO NOTE ***
    
    
    FILE FORMAT
    
    *****
    ---
    var fileName
    ---
    
    *****
*/

// set save file for this room
var roomName = room_get_name(room);
var roomSaveFileName = roomName + ".sav"; //should have a bkp file in case of failure to save/load
if (file_exists(roomSaveFileName)) file_delete(roomSaveFileName);

// write file header
var roomSaveFile = file_text_open_write(roomSaveFileName);
file_text_write_string(roomSaveFile, "*****"); //starts file fresh with write instead of append
file_text_writeln(roomSaveFile);
file_text_write_string(roomSaveFile, "---");
file_text_writeln(roomSaveFile);
file_text_write_string(roomSaveFile, roomName);
file_text_writeln(roomSaveFile);
file_text_write_string(roomSaveFile, "---");
file_text_writeln(roomSaveFile);

// write room's object positions
var curRoomMap = scr_saveRoomState(roomName); 
//print("arr height: " + string(array_height_2d(curRoomMap)));
//print("arr length: " + string(array_length_2d(curRoomMap, 0)));
for (yPos = 0; yPos < array_height_2d(curRoomMap); yPos++){
    for (xPos = 0; xPos < array_length_2d(curRoomMap, yPos); xPos++){
        file_text_write_string(roomSaveFile, curRoomMap[yPos, xPos]);
    }
    file_text_writeln(roomSaveFile);
}
file_text_write_string(roomSaveFile, "---");
file_text_writeln(roomSaveFile);


//file_text_write_real(roomSaveFile, robot.moveHistory);



// close file
file_text_close(roomSaveFile);


// read save file
//roomSaveFile = file_text_open_read(roomSaveFileName);
//var something = file_text_read_real(roomSaveFile);
//file_text_close(roomSaveFile);

//print(ds_stack_top(something));  
//print("Room saved!");

