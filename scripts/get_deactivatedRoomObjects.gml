///get_deactivatedRoomObjects(str roomName)



/*
    *** NOTE ***

    is returning this room's deactivated objects + their stacks in a str
        
    *** END NOTE ***
    
    " "            - nothing 
*/

var roomStr = argument0;

print(" -> get_deactivatedRoomObjects(" + string(roomStr) + ")");

var posStr = "";
var objInst;
var objName;

//Get deactivated objects   
with (all){ 
    //print(object_get_name(object_index));
    if (instance_place(global.DEACTIVATED_X, global.DEACTIVATED_Y, object_index) || //this checks for instances of tiles
        scr_tileContains(global.DEACTIVATED_X, global.DEACTIVATED_Y, array(object_index))){ //this checks for objects on a tile
        
        objName = object_get_name(self.object_index);
        if (string_pos(objName, posStr) == 0){ //returns 0 if substr not found (do we already have this obj check)
            posStr += objName;
            if (isPuzzleElement){ //only puzzle elements have stacks
                posStr += ":";
                if (moveHistory)     posStr += ("moveHistory_" + (ds_stack_write(moveHistory) + ","));
                if (movedDirHistory) posStr += ("movedDirHistory_" + (ds_stack_write(movedDirHistory) + ","));
                if (stateHistory)    posStr += ("stateHistory_" + (ds_stack_write(stateHistory) + ","));
                
                //aStack = ds_stack_create();
                //ds_stack_read(aStack, ds_stack_write(stateHistory));
                //print(ds_stack_pop(aStack));
                
                posStr = trim(posStr); //cut the last comma
            }
            posStr += ";";
            //print(posStr)
        }
    }
}

//Save deactivated objects

print("end saveRoomState");

return posStr;
