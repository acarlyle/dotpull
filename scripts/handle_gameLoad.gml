///handle_gameLoad()

print("handle load game");

if file_exists("save.sav"){
    var loadFile = file_text_open_read("save.sav");
    var loadedRoom = file_text_read_real(loadFile);
    file_text_close(loadFile);
    room_goto(init);
    room_goto(loadedRoom);
    
    global.saveRoomLoaded = loadedRoom;
}

else{
    //go to level one anyways
    room_goto(rm_level1);
}
