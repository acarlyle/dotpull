///set_objectLocalVars(var object, var localVarsStr)

/*
    Sets the local variables in the object as per the arguments.
    localVars strings are passed in the following format:
    
        localVar=value/localVar2=number
        
*/

var object = argument0;
var localVarsStr = argument1;

print("set_objectLocalVars(" + object_get_name(object.object_index) + "," + string(localVarsStr)+")");

//splits by each local var/value pair
var localVarsArr = scr_split(localVarsStr, "/");

//for (var localVarNum = 0; localVarNum < array_length_1d(localVarsArr); localVarNum++){

switch (object_get_name(object.object_index)){
    //check if the triggerDoor tied to this trigger exists; the x and y position were stored in the file
    case "obj_trigger":
        var localVarAndValueArr = scr_split(localVarsArr[0], "=");
        var doorPosX = real(localVarAndValueArr[1]);
        print("DoorPosX: " + string(doorPosX));
        localVarAndValueArr = scr_split(localVarsArr[1], "=");
        var doorPosY = real(localVarAndValueArr[1]);
        if (!instance_place(doorPosX, doorPosY, obj_triggerDoor)){
            instance_create(doorPosX, doorPosY, obj_triggerDoor);
            print("TRIGGER DOOR CREATED AT " + string(doorPosX) + ", " + string(doorPosY));
        }
        object.triggerDoorPtr = instance_place(doorPosX, doorPosY, obj_triggerDoor);
        print("Trigger door SET");
        break;
    }
    
//}
