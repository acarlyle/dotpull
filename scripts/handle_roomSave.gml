///handle_roomSave(bool curRoom)

print("-> handle_roomSave(bool curRoom)");

var saveCurRoom = argument0;


var xPos = 0;
var yPos = 0;

var activeRoomObjectsArr;

/*
    This shit saves the room's current object positions along with all of the dynamic 
    memory used by it into a file so that it can be returned to normal when a player comes
    back.  This is so the room isn't reinitialized.  
    
    Save file default path is C:\Users\UserName\AppData\Local\beam
    
    *** TODO NOTE ***
        This will need to be hashed to prevent notepad SMEs!!!!.
    *** END TODO NOTE ***
    
    
    FILE FORMAT
    
    *****
    ---
    var fileName
    ---
    objAtTile(0,0):moveHistory_<stackHash>...;obj2AtTile(0,0):moveHis....;|obj2AtTile(0,1):...;|
    objAtTile(1,0)[localVar=value/localVar2=number]:moveHistory_<stackHash>;|
    ---
    *****
*/

// set save file for this room
var roomName = room_get_name(room);
var roomSaveFileName = roomName + ".sav"; // TODO -> should have a bkp file in case of failure to save/load
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


if (saveCurRoom)
    activeRoomObjectsArr = get_curRoomObjects(); //grabs objs from the room Rob is in
else
    //activeRoomObjectsArr = get_activeRoomObjects(roomName); 
    activeRoomObjectsArr = get_curRoomObjects();
    
//print("arr height: " + string(array_height_2d(activeRoomObjectsArr)));
//print("arr length: " + string(array_length_2d(activeRoomObjectsArr, 0)));
for (yPos = 0; yPos < array_height_2d(activeRoomObjectsArr); yPos++){
    for (xPos = 0; xPos < array_length_2d(activeRoomObjectsArr, yPos); xPos++){
        //print("WRITING: " + string(activeRoomObjectsArr[yPos, xPos]));
        file_text_write_string(roomSaveFile, activeRoomObjectsArr[yPos, xPos]);
    }
    file_text_writeln(roomSaveFile);
}
file_text_write_string(roomSaveFile, "---");

// write room's deactivated object positions
//var deactivatedRoomObjectsArr = get_deactivatedRoomObjects(roomName); // TODO ?  maybe

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

