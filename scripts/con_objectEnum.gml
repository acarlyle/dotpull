///con_objectEnum(str objName, int objPosX, int objPosY, bool canPull, bool canPush)

var objName = argument0;
var objPosX = argument1;
var objPosY = argument2;

var objectEnum = ds_list_create();

print(" -> con_objectEnum of object " + string(objName));

objectEnum[| OBJECT.NAME] = objName;
objectEnum[| OBJECT.X] = real(objPosX);
objectEnum[| OBJECT.Y] = real(objPosY);

/*  
    Probably best not to store every possible variable in a text file.
    something like the below would be much better for loading in object-specific
    variables.  For variables that can be changed based on position/context,
    those for sure should be stored somewhere.  
*/

switch(get_objectFromString(objName)){
    case obj_block:
        objectEnum[| OBJECT.CANPULL] = true;
        objectEnum[| OBJECT.CANPUSH] = false;
        objectEnum[| OBJECT.ISACTIVE] = true;
        break;
    case obj_player:
        objectEnum[| OBJECT.CANPULL] = false;
        objectEnum[| OBJECT.CANPUSH] = false;
        objectEnum[| OBJECT.ISACTIVE] = true;
        
        objectEnum[| ROBOT.CANMOVE] = true;
        objectEnum[| ROBOT.OLDPOSX] = global.DEACTIVATED_X;
        objectEnum[| ROBOT.OLDPOSY] = global.DEACTIVATED_Y;
        objectEnum[| ROBOT.ISDEAD] = false;
        objectEnum[| ROBOT.NUMKEYS] = 0;
        objectEnum[| ROBOT.HASBABY] = false;
        objectEnum[| ROBOT.MOVE] = false;
        break;
}

return objectEnum;
