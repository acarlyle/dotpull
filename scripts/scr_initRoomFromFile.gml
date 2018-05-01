///scr_initRoomFromFile(var roomName)

var roomName = argument0;
var fileName = string(roomName) + ".sav";

//with (all){
    //if (isPuzzleElement) instance_destroy();
//}

saveFile = file_text_open_read(fileName);
var curLine = "";

curLine = file_text_readln(saveFile); // *****
curLine = file_text_readln(saveFile); // ---
curLine = file_text_readln(saveFile); // ((roomName))
curLine = file_text_readln(saveFile); // ---

print(curLine);

/*
    !!! Split Breakdown Showdown !!!
    
    | - seperates tiles
    ; - seperates objects in a tile
    : - seperates an object and its multiple stacks
    , - seperates each stack
    _ - seperates a stack type from the stack itself 
    
*/

curLine = file_text_readln(saveFile); //beging room parsing here

while(!strcontains(curLine, "---")){
    
    var tileArr = scr_split(curLine, "|"); //array of each tile's contents
    for (var tile = 0; tile < array_length_1d(tileArr); tile++){
        if (tileArr[tile] == " ") continue; //blank tile
        var objsArr = scr_split(tileArr[tile], ";");
        for (var obj = 0; obj < array_length_1d(objsArr); obj++){
            if (strcontains(objsArr[obj], ":")){ //contains stacks
                thisObjAndStacks = scr_split(objsArr[obj], ":");
                var objName = thisObjAndStacks[0];   
                var stackTypeAndStackArr = scr_split(thisObjAndStacks[1], ",");
                for (var stack = 0; stack < array_length_1d(stackTypeAndStackArr); stack++){
                    switch (stackTypeAndStackArr[0]){
                        case "moveHistory":
                            
                            break;
                        case "movedDirHistory":
                            break;
                        case "stateHistroy":
                            break;
                    }
                }             
            }
        }
    }
    
    
    curLine = file_text_readln(saveFile); //read at the end of the loop
    print(curLine);
}
