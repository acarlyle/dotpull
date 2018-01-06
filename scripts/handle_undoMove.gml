///handle_undoMove

print("handle_undoMove");

//handle player's undo
var objPosStr = ds_stack_pop(obj_player.moveHistory); //string e.g. "64,64"
//print(objPosStr);
//print(obj_player.x);
//print(obj_player.y);
if (objPosStr != undefined){
    var objCoordArr = scr_split(objPosStr);
    //print(objCoordArr[0]);
    //print(objCoordArr[1]);
    obj_player.x = objCoordArr[0];
    obj_player.y = objCoordArr[1];
    global.playerX = obj_player.x;
    global.playerY = obj_player.y;
}
//handle player's items on undo
var items = ds_stack_pop(obj_player.itemHistory);
obj_player.numKeys = items[0];

//handle every element's 
for (var i = 0; i < array_length_1d(global.roomContents); i++){
    //print("in loop");
    with(global.roomContents[i]){
        //print("key still here");
        //var obj = global.roomContents[i];
        var objPosStr = ds_stack_pop(moveHistory); //string e.g. "64,64"
        //print(objPosStr);
        if (objPosStr != undefined){
            var objCoordArr = scr_split(objPosStr);
            x = objCoordArr[0];
            y = objCoordArr[1];
        }
    }
}


undo = false;
