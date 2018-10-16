///update_lowerSurface(var m_surf, var upperRoomName)

/*
    Draws the rooms lower than the passed upperRoom.
*/

var surface = argument0;
var upperRoomName = argument1;

print(" -> draw_lowerSurface(" + string(surface) + ", " + string(upperRoomName) + ")");

if (!surface_exists(surface)){ surface = surface_create(room_width, room_height); }
if (surface_exists(surface)){ 

    //clear surface
    surface_set_target(surface);
    draw_clear_alpha(c_black, 0);
    surface_reset_target();
    
    // get below room's name
    var lowerRoomName = get_lowerRoomName(upperRoomName);
    //print(lowerRoomName);
    if (lowerRoomName != undefined && room_exists(lowerRoomName)){
        //print("lowerRoomName: " + string(lowerRoomName));
        var fileName = lowerRoomName + ".sav";
        //print("Filename: " + fileName);
        var lowerRoomArray = get_arrayOfRoomFromFile(fileName);
        var upperRoomArray = get_arrayOfRoomFromFile(upperRoomName + ".sav");
        //print2dArray(lowerRoomArray);
        //print2dArray(upperRoomArray);
        
        //TODO -> This logic will be spammed until the floor is drawn, if the room exists.
        //Need to implement a way out in the surface object that is calling this function.
        if (lowerRoomArray == false || upperRoomArray == false) return false;
        
        //iterate through lower floor array and compare it to the one above it
        for (var yPos = 0; yPos < array_height_2d(lowerRoomArray); yPos++;){
            for (var xPos = 0; xPos < array_length_2d(lowerRoomArray, yPos); xPos++;){
                if (lowerRoomArray[yPos, xPos] == " ") continue; //nothing in lowerRoom tile -> continue
                if (upperRoomArray[yPos, xPos] != " ") continue; //something in upperRoom tile -> continue
                
                var objsHere = scr_split(lowerRoomArray[yPos, xPos], ";");
                for (obj = 0; obj < array_length_1d(objsHere); obj++){
                    var objName = objsHere[obj];
                    //if strcontains(objName, ":") {
                    if (strcontains(objName, "[")){
                        var objAndStacks = scr_split(objName, "["); //get rid of stacks
                        objName = objAndStacks[0];
                        //objName contains local variables
                        //if (strcontains(objName, "[")){
                            //var objNameAndVars = scr_split(objName, "[");
                            //objName = objNameAndVars[0];
                            print("New obj name: " + string(objName));
                        }
                    //}
                    //print("surExisted_drawing: " + string(objName) + " at " + string(xPos * global.TILE_SIZE) + ", " + string(yPos * global.TILE_SIZE));
                    surface_set_target(surface);
                    draw_sprite(get_spriteFromObjStr(objName), 0, xPos * global.TILE_SIZE, yPos * global.TILE_SIZE);
                    surface_reset_target();
                }
            } 
        }   
    }
}


return surface;
