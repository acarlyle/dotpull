///scr_createMapForRoom()

/*
    " "            - nothing 
    "_"            - platform
    "o_block"      - obj_block 
*/

print(" -> scr_createMapForRoom()");

var xPos = 0;
var yPos = 0;
var arrMap;
var posStr;
var objInst;
var objName;

for (yPos = 0; yPos < room_height; yPos += global.TILE_SIZE){
    for (xPos = 0; xPos < room_width; xPos += global.TILE_SIZE){  
        posStr = " ";   
        with (all){ 
            //print(object_get_name(object_index));
            if scr_tileContains(xPos, yPos, array(object_index)){ 
                objName = object_get_name(self.object_index);
                if (string_pos(objName, posStr) == 0){ //returns 0 if substr not found
                    posStr += (objName + ",");
                    //print(objName);
                }
            }
        }
        arrMap[xPos, yPos] = posStr;
    }
}

for (yPos = 0; yPos < room_height; yPos += global.TILE_SIZE){
    for (xPos = 0; xPos < room_width; xPos += global.TILE_SIZE){
        if (arrMap[xPos, yPos] != " ") print(arrMap[xPos, yPos]);
    }
}

print("end createMap");
