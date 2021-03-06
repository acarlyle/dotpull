///get_activeRoomObjects(obj_layer layer)



/*
    *** NOTE ***

    should save this room's state (obj pos and stacks) to a file
        
    *** END NOTE ***
    
    " "            - nothing 
*/

//var layer = argument0;

var roomStr = argument0;

print(" -> get_activeRoomObjects(" + string(roomStr) + ")");

var xPos = 0;
var yPos = 0;
var arrMap;
var posStr;
var objInst;
var objName;

/*
    * Save active objects
    * objAtTile(1,0)[localVar=value/localVar2=number]:moveHistory_<stackHash>;|   <- typical obj. line
*/

for (yPos = 0; yPos < room_height; yPos += global.TILE_SIZE){
    for (xPos = 0; xPos < room_width; xPos += global.TILE_SIZE){  
        posStr = "";   
        with (all){ 
            if (object_get_name(object_index) == "obj_player") print("GETTING ACTIVE OBJECT PLAYER EDITION");
            if (instance_place(xPos, yPos, self.object_index) || //this checks for instances of tiles
                scr_tileContains(layer, xPos, yPos, array(self.object_index))){ //this checks for objects on a tile
                
                
                objName = object_get_name(self.object_index);
                if (objName == "obj_player") print("PLAYER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                if (string_pos(objName, posStr) == 0){ //returns 0 if substr not found (do we already have this obj check)
                    posStr += (objName + get_objectLocalVarsStr(self.object_index));
                    if (isPuzzleElement){ //only puzzle elements have stacks
                        posStr += ":";
                        if (moveHistory)     posStr += ("moveHistory_" + (ds_stack_write(moveHistory) + ","));
                        if (movedDirHistory) posStr += ("movedDirHistory_" + (ds_stack_write(movedDirHistory) + ","));
                        if (stateHistory)    posStr += ("stateHistory_" + (ds_stack_write(stateHistory) + ","));
                        
                        posStr = trim(posStr); //cut the last comma
                    }
                    posStr += ";";
                    //print("POSSTR: " + string(posStr))
                }
            }
        }
        if (strlen(posStr) > 0){
            //posStr = trim(posStr); //trim last char (comma) if strlen is > 0
            posStr += "|";
        }
        else posStr = " |"; //nothing is there, not even a platform
        arrMap[yPos / global.TILE_SIZE, xPos / global.TILE_SIZE] = posStr;
    }
}

//Save deactivated objects

print("end saveRoomState");

return arrMap;
