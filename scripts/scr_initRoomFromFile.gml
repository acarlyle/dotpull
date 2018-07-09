///scr_initRoomFromFile(var roomName)

var roomName = argument0;
var fileName = string(roomName) + ".sav";

print(" -> initRoomFromFile");

with (all){ if isPuzzleElement instance_destroy(); } 
with (par_surface) instance_destroy();

saveFile = file_text_open_read(fileName);
var curLine = "";

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
    
    -- local variables split rules --
     - some vars have local variables saved -
    
    [ - opening bracket for a list of local variables
    ] - closing bracket for a list of local variables
    / - seperate each local variable in a local variable bracket
    = - defines relationship between local variable and its value   
    
*/

//objAtTile[localVar=value/localVar2=number]:moveHistory_<stackHash>;|

curLine = file_text_readln(saveFile); //beginning room parsing here

while(!strcontains(curLine, "---")){

    var obj = noone;
    

    //split by each each tile's contents
    var tileArr = scr_split(curLine, "|");
    for (var tile = 0; tile < array_length_1d(tileArr); tile++){
        if (tileArr[tile] == " ") continue; //blank tile
        //split by objects in this tile
        var objsArr = scr_split(tileArr[tile], ";");
        for (var obj = 0; obj < array_length_1d(objsArr); obj++){
            //if this object contains stacks
            if (strcontains(objsArr[obj], ":")){
                //split by this object and its stack(s)
                thisObjAndStacks = scr_split(objsArr[obj], ":"); 
                var objName = thisObjAndStacks[0];
                var tmpObjName = objName;
                //this objName contains the object's local variable names and values 
                if (strcontains(objName, "[")){
                    objVarsAndStacks = scr_split(objName, "]");
                    objNameAndVars = scr_split(objVarsAndStacks[0], "[");
                    objVars = objNameAndVars[1];
                    tmpObjName = objNameAndVars[0];
                }
                
                //create object
                var objRef = instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, asset_get_index(tmpObjName));
                if (objName != tmpObjName) set_objectLocalVars(objRef, objVars);
                
                print(object_get_name(objRef.object_index));
                print(thisObjAndStacks[1]);
                //Remove leading ']' (used to indicate closure of local variables)
                var stacksArr = scr_split(thisObjAndStacks[1], "]");
                //split by each stack
                var arrayOfStacks = scr_split(stacksArr[0], ",");
                
                for (var stack = 0; stack < array_length_1d(arrayOfStacks); stack++){
                    //split by stack type and the stack itself
                    var stackNameAndStackHashArr = scr_split(arrayOfStacks[stack], "_");
                    
                    //
                    if (strcontains(stackNameAndStackHashArr[1], "[")){
                        
                    }
                    
                    switch (stackNameAndStackHashArr[0]){
                        case "moveHistory":
                            //print(string(objName) + ", " + string(stackNameAndStackHashArr[0]) + string(stackNameAndStackHashArr[1]));
                            ds_stack_destroy(objRef.moveHistory); //clear deactivated position
                            objRef.moveHistory = ds_stack_create();
                            ds_stack_read(objRef.moveHistory, stackNameAndStackHashArr[1]);
                            print("obj stack size: " + string(ds_stack_size(objRef.moveHistory)));
                            var string_objPos = ds_stack_pop(objRef.moveHistory);
                            print("objPos from stack: " + string(string_objPos));  
                            var array_objArr = scr_split(string_objPos, ",");
                            objRef.x = array_objArr[0]; 
                            objRef.y = array_objArr[1];
                            print(string(ds_stack_size(objRef.moveHistory))); 
                            //print("X SET TO " + string(objRef.x));
                            //print("Y SET TO " + string(objRef.y));
                            break;
                        case "movedDirHistory":
                            ds_stack_clear(objRef.movedDirHistory);
                            ds_stack_read(objRef.movedDirHistory, stackNameAndStackHashArr[1]);
                            objRef.movedDir = ds_stack_pop(objRef.moveHistory);  
                            break;
                        case "stateHistory": //TODO - some objects have unique states, how to tell difference ?
                            ds_stack_clear(objRef.stateHistory);
                            ds_stack_read(objRef.stateHistory, stackNameAndStackHashArr[1]);
                        break;
                    }
                }             
            }
        }
    }
    
    
    curLine = file_text_readln(saveFile); //read at the end of the loop
    //print(curLine);
}
file_text_close(saveFile);
