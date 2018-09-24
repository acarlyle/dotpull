///update_layerSurface(obj_surface surface, var upperRoomName)

/*
    Draws layer owned by this surface.
*/

var surface = argument0;
var layer = argument1;

//print(" -> update_layerSurface()");

if (!surface_exists(surface)){ surface = surface_create(room_width, room_height); }

if (surface_exists(surface)){ 

    //clear surface
    surface_set_target(surface);
    draw_clear_alpha(c_black, 0);
    surface_reset_target();
    
    var roomArr = layer.roomMapArr;
    //print2dArray(roomArr);
    
    //iterate through lower floor array and compare it to the one above it
    for (var yPos = 0; yPos < array_height_2d(roomArr); yPos++){
        for (var xPos = 0; xPos < array_length_2d(roomArr, yPos); xPos++){
            //print("Tile position at " + string(yPos) + "," + string(xPos) + ": "  + roomArr[yPos, xPos]);
            if (roomArr[yPos, xPos] == " ") continue; //nothing in tile -> continue
            
            var objsHere = scr_split(roomArr[yPos, xPos], ";");
            //print("objsHere: " + string(objsHere));
            for (var obj = 0; obj < array_length_1d(objsHere); obj++){
                var objName = objsHere[obj];
                //print("objName I: " + string(objName));
                if (strcontains(objName, "[")){
                    var objSplit = scr_split(objName, "["); //get rid of stacks
                    objName = objSplit[0];
                    //objName contains local variables
                    //if (strcontains(objName, "[")){
                        //var objNameAndVars = scr_split(objName, "[");
                        //objName = objNameAndVars[0];
                    //print("New obj name: " + string(objName));
                }
                
                //grab the updated sprite index from the objEnum
                var objEnum = ds_map_find_value(layer.objNameAndPosToEnumMap, 
                                                objName + 
                                                ":" + 
                                                string(xPos * global.TILE_SIZE) + 
                                                "," + 
                                                string(yPos * global.TILE_SIZE));
                var imgIndex = 0;
                //print(ds_map_size(layer.objNameAndPosToEnumMap));
                //print("Attempted: " + string(objName) + ":" + string(xPos * global.TILE_SIZE) + "," + string(yPos * global.TILE_SIZE));
                if (objEnum){ 
                    imgIndex = objEnum[| OBJECT.IMGIND]; //set sprite to use updated sprite_index
                    //print("update_layerSurface: Using sprite index of " + string(sprIndex) + " for " + objEnum[| OBJECT.NAME]);
                }
                
                //}
                //print("update_layerSurface: drawing " + string(objName) + " at " + string(xPos * global.TILE_SIZE) + ", " + string(yPos * global.TILE_SIZE) + " with image index of " + string(imgIndex));
                surface_set_target(surface);
                draw_sprite(get_spriteFromObjStr(objName), imgIndex, xPos * global.TILE_SIZE, yPos * global.TILE_SIZE);
                surface_reset_target();
            }
        } 
    }   
}


return surface;
