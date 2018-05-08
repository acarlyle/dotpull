///get_arrayOfRoomFromFile(var fileName)

var fileName = argument0;

saveFile = file_text_open_read(fileName);
var curLine = "";
var arr;

curLine = file_text_readln(saveFile); // *****
curLine = file_text_readln(saveFile); // ---
curLine = file_text_readln(saveFile); // ((roomName))
curLine = file_text_readln(saveFile); // ---

//print(curLine);

/*
    !!! Split Breakdown Showdown !!!
    
    | - seperates tiles
    ; - seperates objects in a tile
    : - seperates an object and its multiple stacks
    , - seperates each stack
    _ - seperates a stack type from the stack itself 
    
*/

curLine = file_text_readln(saveFile); //beging room parsing here
var lineNum = -1;

while(!strcontains(curLine, "---")){
    lineNum++;
    var tileArr = scr_split(curLine, "|"); //array of each tile's contents
    for (var tile = 0; tile < array_length_1d(tileArr); tile++){
        if (tileArr[tile] == " ") continue; //blank tile
        var objsArr = scr_split(tileArr[tile], ";");
        var posStr = ""; //contains every obj at this position
        for (var obj = 0; obj < array_length_1d(objsArr); obj++){
            if (strcontains(objsArr[obj], ":")){ //contains stacks
                print(objsArr[obj]);
                thisObjAndStacks = scr_split(objsArr[obj], ":"); 
                var objName = thisObjAndStacks[0];
                if (string_pos(objName, posStr) == 0){ //returns 0 if substr not found
                    posStr += (objName + ",");
                }        
            }
        }
        arr[lineNum, tile] = posStr;
        //print("posStr: " + string(posStr));
    }
    curLine = file_text_readln(saveFile); //read at the end of the loop
    //print(curLine);
}
file_text_close(saveFile);

print2dArray(arr);
