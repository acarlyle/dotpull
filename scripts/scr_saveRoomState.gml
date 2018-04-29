///scr_saveRoomState(str roomName)



/*
    *** NOTE ***

    should save this room's state (obj pos and stacks) to a file
        
    *** END NOTE ***
    
    " "            - nothing 
*/

var roomStr = argument0;

print(" -> scr_saveRoomState(" + string(roomStr) + ")");

var xPos = 0;
var yPos = 0;
var arrMap;
var posStr;
var objInst;
var objName;

for (yPos = 0; yPos < room_height; yPos += global.TILE_SIZE){
    for (xPos = 0; xPos < room_width; xPos += global.TILE_SIZE){  
        posStr = "";   
        with (all){ 
            //print(object_get_name(object_index));
            if (instance_place(xPos, yPos, object_index) || //this checks for instances of tiles
                scr_tileContains(xPos, yPos, array(object_index))){ //this checks for objects on a tile
                
                objName = object_get_name(self.object_index);
                if (string_pos(objName, posStr) == 0){ //returns 0 if substr not found (do we already have obj chk)
                    posStr += objName;
                    if (isPuzzleElement){ //only puzzle elements have stacks
                        posStr += ":";
                        if (moveHistory)     posStr += (ds_stack_write(moveHistory) + ",");
                        if (movedDirHistory) posStr += (ds_stack_write(movedDirHistory) + ",");
                        if (stateHistory)    posStr += (ds_stack_write(stateHistory) + ",");
                        
                        //aStack = ds_stack_create();
                        //ds_stack_read(aStack, ds_stack_write(stateHistory));
                        //print(ds_stack_pop(aStack));
                        
                        posStr = trim(posStr);
                    }
                    posStr += ";";
                    //print(posStr)
                }
            }
        }
        if (strlen(posStr) > 0){
            posStr = trim(posStr); //trim last char (comma) if strlen is > 0
            posStr += "|";
        }
        else posStr = " |"; //nothing is there, not even a platform
        arrMap[yPos / global.TILE_SIZE, xPos / global.TILE_SIZE] = posStr;
    }
}

// BROKEN -- will crash; was only for testing
/*for (yPos = 0; yPos < room_height; yPos++){
    for (xPos = 0; xPos < room_width; xPos ++){
        if (arrMap[xPos, yPos] != "") {
            print(arrMap[xPos, yPos]);
            //var splitArr = scr_split(arrMap[xPos, yPos], ",");
            //print(splitArr[0]);
        }
    }
}*/

print("end saveRoomState");

return arrMap;
