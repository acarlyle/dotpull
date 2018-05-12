///draw_lowerRooms(var m_surf)

var m_surface = argument0;

var curRoomName = room_get_name(room);
//print(curRoomName);

//if (!surface_exists(m_surface)){ m_surface = surface_create(room_width, room_height); }
if (surface_exists(m_surface)){ 
    
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
        
        if (lowerRoomArray == false || upperRoomArray == false) return false;
        
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
                    print("surExisted_drawing: " + string(objName) + " at " + string(xPos * global.TILE_SIZE) + ", " + string(yPos * global.TILE_SIZE));
                    surface_set_target(m_surface);
                    draw_sprite(get_spriteFromObjStr(objName), 0, xPos * global.TILE_SIZE, yPos * global.TILE_SIZE);
                    surface_reset_target();
                }
            } 
        }   
    }
}

return m_surface;
