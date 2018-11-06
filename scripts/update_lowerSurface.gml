///update_lowerSurface(par_surface obj_surfInf, obj_layer layerToUpdate)

/*
    Draws the rooms lower than the passed upperRoom.
*/

var surface = argument0;
var layer = argument1;

var upperRoomName = get_higherRoomName(layer.roomName);

print("-> update_lowerSurface surfaceRoomName: " + string(layer.roomName) + "; upperRoomName: " + string(upperRoomName));

if (!surface_exists(surface)){ surface = surface_create(room_width, room_height); }
if (surface_exists(surface)){ 

    //clear surface
    surface_set_target(surface);
    draw_clear_alpha(c_black, 0);
    surface_reset_target();
    
    var lowerLayer = layer;
    var upperLayer = get_layerFromRoomStr(upperRoomName);
    if (room_exists(lowerLayer.roomName)){
        var fileName = lowerLayer.roomName + ".sav";
        //print("Filename: " + fileName);
        var lowerRoomArray = lowerLayer.roomMapArr;
        var upperRoomArray = upperLayer.roomMapArr;
        //print2dArray(lowerRoomArray);
        //print2dArray(upperRoomArray);
        
        //TODO -> This logic will be spammed until the floor is drawn, if the room exists.
        //Need to implement a way out in the surface object that is calling this function.
        if (lowerRoomArray == false || upperRoomArray == false) return false;
        
        //iterate through lower floor array and compare it to the one above it
        for (var yPos = 0; yPos < array_height_2d(lowerRoomArray); yPos++;){
            for (var xPos = 0; xPos < array_length_2d(lowerRoomArray, yPos); xPos++;){
                if (lowerRoomArray[yPos, xPos] == " ") continue; //nothing in lowerRoom tile -> continue
                if (upperRoomArray[yPos, xPos] != " "){
                    if scr_tileContains(upperLayer, xPos, yPos, array(obj_player)) 
                    {
                        print("-> update_lowerSurface there's a robot above this spot!");
                    } //continue drawing, could be over a stepping stone
                    else
                    {
                        continue; //something in upperRoom tile -> continue
                    }
                }
                
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
                    var imgInd = 0;
                    
                    //print("update_lowerSurface: " + string(objName) + " at " + string(xPos * global.TILE_SIZE) + ", " + string(yPos * global.TILE_SIZE));
                    var objAsset = get_objectFromString(objName);
                    if (objAsset != undefined)
                    {
                        if (objAsset.isPuzzleElement)
                        {
                            var enumRef = map_place(lowerLayer, get_objectFromString(objName), xPos * global.TILE_SIZE, yPos * global.TILE_SIZE);
                            imgInd = enumRef[| OBJECT.IMGIND];
                        }   
                    }
                    
                    surface_set_target(surface);
                    draw_sprite(get_spriteFromObjStr(objName), imgInd, xPos * global.TILE_SIZE, yPos * global.TILE_SIZE);
                    surface_reset_target();
                }
            } 
        }   
    }
}


return surface;
