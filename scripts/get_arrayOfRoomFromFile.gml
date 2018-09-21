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
var lineNum = 0;

while(!strcontains(curLine, "---")){
    var tileArr = scr_split(curLine, "|"); //array of each tile's contents
    //print("get_arrayOfRoomFromFile: tileArr len: " + string(array_length_1d(tileArr)));
    for (var tile = 0; tile < array_length_1d(tileArr) - 1; tile++){
        var posStr = "";
        posStr = tileArr[tile];
        arr[lineNum, tile] = posStr; //y,x
        //print("posStr: " + string(arr[lineNum, tile]));
    }
    curLine = file_text_readln(saveFile); //read at the end of the loop\
    lineNum++;
    //print(curLine);
}
file_text_close(saveFile);

return arr;
