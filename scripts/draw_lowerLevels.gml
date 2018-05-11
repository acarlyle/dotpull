///draw_lowerLevels()

var curRoomName = room_get_name(room);
//print(curRoomName);

// get below room's name
var lowerRoomName = get_lowerRoomName(curRoomName);
if (lowerRoomName != undefined){
    //print("lowerRoomName: " + string(lowerRoomName));
    var fileName = lowerRoomName + ".sav";
    print("Filename: " + fileName);
    var lowerRoomArray = get_arrayOfRoomFromFile(fileName);
    var upperRoomArray = get_arrayOfRoomFromFile(curRoomName + ".sav");
    //print2dArray(lowerRoomArray);
    //print2dArray(upperRoomArray);
    
    //iterate through lower floor array and compare it to the one above it
    for (var yPos = 0; yPos < array_height_2d(lowerRoomArray); yPos++;){
        for (var xPos = 0; xPos < array_length_2d(lowerRoomArray, yPos); xPos++;){
            if (lowerRoomArray[yPos, xPos] == " ") continue; //nothing in lowerRoom tile -> continue
            if (upperRoomArray[yPos, xPos] != " ") continue; //something in upperRoom tile -> continue
            
            var objsHere = scr_split(lowerRoomArray[yPos, xPos], ";");
            for (obj = 0; obj < array_length_1d(objsHere); obj++){
                var objName = objsHere[obj];
                if strcontains(objName, ":") {
                    var objAndStacks = scr_split(objName, ":"); //get rid of stacks
                    objName = objAndStacks[0];
                }
                
                //draw the lower level to the global.sur_lowerRooms surface
                if (!global.surf_lowerRooms) global.surf_lowerRooms = surface_create(room_width, room_height);
                if (!surface_exists(global.surf_lowerRooms)){
                    global.surf_lowerRooms = surface_create(room_width, room_height);
                    surface_set_target(global.surf_lowerRooms);
                    print("surfCreated_drawing: " + string(objName) + " at " + string(xPos * global.TILE_SIZE) + ", " + string(yPos * global.TILE_SIZE));
                    //draw_sprite(get_spriteFromObjStr(objName), 0, xPos * global.TILE_SIZE, yPos * global.TILE_SIZE);
                }
                else{
                    surface_set_target(global.surf_lowerRooms);
                    print("surExisted_drawing: " + string(objName) + " at " + string(xPos * global.TILE_SIZE) + ", " + string(yPos * global.TILE_SIZE));
                    //draw_sprite(get_spriteFromObjStr(objName), 0, xPos * global.TILE_SIZE, yPos * global.TILE_SIZE);
                }
                surface_reset_target();
            }
        } 
    }   
}
