///undo_breakableWall(obj_enum breakableWall)

/*
    Handles undo for this breakableWall obj
*/

var breakableWall = argument0;
print("Undoing breakableWall 1(preUndoHitsLeft): " + string(breakableWall[| AI.HP]));

var breakableWallStr = ds_stack_pop(breakableWall[| OBJECT.STATEHISTORY]); 
if (breakableWallStr != undefined){
    //print ("UNDOING breakable wall");
    var imgIndex = 0;
    breakableWall[| AI.HP] = breakableWallStr;
    switch(breakableWallStr){
        case 3:
            imgIndex = 0;
            break;
        case 2:
            imgIndex = 1;
            break;
        case 1:
            imgIndex = 2;
            break;
        case 0:
            imgIndex = 3;
            break;
    }
    if (imgIndex > breakableWall[| AI.HPMAX]){
        imgIndex = breakableWall[| AI.HPMAX]; 

    }
    breakableWall[| OBJECT.IMGIND] = min(breakableWall[| AI.HPMAX]+1, imgIndex);
    if (breakableWall[| AI.HP] != 0){
        breakableWall[| OBJECT.ISACTIVE] = true;
    }
}
