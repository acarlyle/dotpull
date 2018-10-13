///get_curRoomObjects();

var roomStr = room_get_name(room);

print("-> get_curRoomObjects()");

var arrMap;
var posStr = "";
var objInst;
var objName;

//blank out room array map
for (var yy = 0; yy < room_height / global.TILE_SIZE; yy++){
    for (var xx = 0; xx < room_width / global.TILE_SIZE; xx++){    
        arrMap[yy, xx] = ""; 
    }
}

//print("get_curRoomObjects: room array length: " + string(array_length_2d(arrMap, 0)));
//print("get_curRoomObjects: room array height: " + string(array_height_2d(arrMap)));

/*

    * Save active objects
    * objAtTile(1,0)[localVar=value/localVar2=number]:moveHistory_<stackHash>;|   <- typical obj. line
    
*/
  
with (all){

    posStr = "";

    //control objects should only be on DEACTIVATED_X anyways
    if (object_get_parent(self.object_index) == par_control || 
        (self.x == global.DEACTIVATED_X || self.y == global.DEACTIVATED_Y)){ 
        
        continue; //don't add control objects/deactivated ones to map
    }
    
    //print("get_curRoomObjects: with " + string(object_get_name(self.object_index)));
        
    objName = object_get_name(self.object_index);
    //print("get_curRoomObjects: objName: " + string(objName) + " at " + string(x) + "," + string(y));
    
    //if (string_pos(objName, posStr) == 0){ //returns 0 if substr not found (do we already have this obj? check, if not, add)
    
    posStr += (objName + get_objectLocalVarsStr(self.object_index));
    if (isPuzzleElement){ //only puzzle elements have stacks
        posStr += ":";
        //if (moveHistory)     posStr += ("moveHistory_" + (ds_stack_write(moveHistory) + ","));
        //if (movedDirHistory) posStr += ("movedDirHistory_" + (ds_stack_write(movedDirHistory) + ","));
        //if (stateHistory)    posStr += ("stateHistory_" + (ds_stack_write(stateHistory) + ","));
        
        posStr = trim(posStr); //cut the last comma
    }
    posStr += ";";
    //print("POSSTR:" + string(posStr));
    
    //add this object to this position in the room arr map at position 'zero' (before the '|' which denotes end of tile position)
    arrMap[y / global.TILE_SIZE, x / global.TILE_SIZE] = arrMap[y / global.TILE_SIZE, x / global.TILE_SIZE] + posStr;
    
    //print("get_curRoomObjects pos of " + string(y / global.TILE_SIZE) + "," + string(x / global.TILE_SIZE) + " string now:" + string(arrMap[y / global.TILE_SIZE, x / global.TILE_SIZE]));
    
    //}
}

//add spaces if no object there
for (var yy = 0; yy < room_height / global.TILE_SIZE; yy++){
    for (var xx = 0; xx < room_width / global.TILE_SIZE; xx++){    
        if (arrMap[yy, xx] == "") arrMap[yy, xx] = " |"; 
        else arrMap[yy, xx] = arrMap[yy, xx] + "|";
    }
}

//print("get_curRoomObjects: print array of this thing before returning it: ");
//print2dArray(arrMap, false);

return arrMap;
