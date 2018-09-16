///get_curRoomObjects();

var roomStr = room_get_name(room);

print("-> get_curRoomObjects()");

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
        
            if (self.object_index == par_control.object_index) continue; //doesn't work for obj_layer ???
            
            //if (self.object_index == obj_player.object_index) print("yoooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
            
            if (xPos == 112 && yPos == 176)
                print("get_curRoomObjects: Handling " + string(object_get_name(self.object_index))); 
           
            if (instance_place(xPos, yPos, self.object_index) || //this checks for instances of tiles
                scr_tileContains_curRoom(xPos, yPos, array(self.object_index))){ //this checks for objects on a tile
                
                if (xPos == 112 && yPos == 176)
                    print("get_curRoomObjects: post instance place check " + string(object_get_name(self.object_index))); 
                
                objName = object_get_name(self.object_index);
                
                if (string_pos(objName, posStr) == 0){ //returns 0 if substr not found (do we already have this obj check)
                    posStr += (objName + get_objectLocalVarsStr(self.object_index));
                    if (isPuzzleElement){ //only puzzle elements have stacks
                        posStr += ":";
                        //if (moveHistory)     posStr += ("moveHistory_" + (ds_stack_write(moveHistory) + ","));
                        //if (movedDirHistory) posStr += ("movedDirHistory_" + (ds_stack_write(movedDirHistory) + ","));
                        //if (stateHistory)    posStr += ("stateHistory_" + (ds_stack_write(stateHistory) + ","));
                        
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
