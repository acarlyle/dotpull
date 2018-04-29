///scr_getArrOfRoom(str roomName)



/*
    *** NOTE ***

    Currently, this is not storing objects in the global.deactivated tile.  
    Returns a 2d array containing the object positions of this room.
        
    *** END NOTE ***
    
    " "            - nothing 
*/

var roomStr = argument0;

print(" -> scr_getArrOfRoom(" + string(roomStr) + ")");

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
                if (string_pos(objName, posStr) == 0){ //returns 0 if substr not found
                    posStr += (objName + ",");
                    //print(objName);
                }
            }
        }
        if (strlen(posStr) > 0){
            posStr = trim(posStr); //trim last char (comma) if strlen is > 0
            posStr += " |";
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

print("end getArrOfRoom");

return arrMap;
