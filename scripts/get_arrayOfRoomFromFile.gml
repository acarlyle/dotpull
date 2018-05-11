///get_arrayOfRoomFromFile(var fileName)

var fileName = argument0;

print(" -> get_arrayOfRoomFromFile(" + string(fileName) + ")");

if (!file_exists(fileName)) return false;

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
        var posStr = "";
        posStr = tileArr[tile];
        arr[lineNum, tile] = posStr;
        //print("posStr: " + string(arr[lineNum, tile]));
    }
    curLine = file_text_readln(saveFile); //read at the end of the loop
    //print(curLine);
}
file_text_close(saveFile);

return arr;
