///undo_fallingPlatform(par_fallingPlatform fallingPlatform)

/*
    Handles undo for this fallingPlatform obj
*/

breakableWall = argument0;
print("Undoing breakableWall 1(preUndoHitsLeft): " + string(breakableWall.hitsLeft));

var breakableWallStr = ds_stack_pop(breakableWall.stateHistory);
//print("hitsLeftFromStack: " + string(breakableWallStr)); 
if (breakableWallStr != undefined){
    //print ("UNDOING breakable wall");
    var imgIndex = 0;
    breakableWall.hitsLeft = breakableWallStr;
    switch(breakableWallStr){
        case 3:
            imgIndex = 0;
            //print('img index set to 0 from 3');
            break;
        case 2:
            //imgIndex = max(breakableWall.numFrames+1, 1);
            imgIndex = 1;
            break;
        case 1:
            //imgIndex = max(breakableWall.numFrames+1, 2);
            imgIndex = 2;
            break;
        case 0:
            //imgIndex = max(breakableWall.numFrames+1, 3);
            imgIndex = 3;
            break;
    }
    //print ("img index is now: " + string(imgIndex));
    if (imgIndex > breakableWall.numFrames){
        imgIndex = breakableWall.numFrames; 
        //print ("img index updated to: " + string(imgIndex));
    }
    //print("breakwall image index is " + string(breakableWall.image_index));
    breakableWall.image_index = min(breakableWall.numFrames+1, imgIndex);
    //print("breakwall image index is now " + string(breakableWall.image_index)); 
    if (breakableWall.hitsLeft != 0){
        breakableWall.isDeactivated = false;
    }
}
print("Undoing breakableWall 2(postUndoHitsLeft): " + string(breakableWall.hitsLeft));
