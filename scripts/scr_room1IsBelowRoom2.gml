///scr_room1IsBelowRoom2(var roomName1, var roomName2)

/*
    rm_*NAME*_*BorF*_*NUM*
*/

var roomName1 = argument0;
var roomName2 = argument1;

//if (roomName1 == undefined || roomName2 == undefined) return false;

var roomName1Arr = scr_split(roomName1, "_");
var roomName2Arr = scr_split(roomName2, "_");

if (roomName1Arr[2] == "b" && roomName2Arr[2] == "f")
{
    return true;
}

else if (roomName1Arr[2] == roomName2Arr[2])
{
    if (real(roomName1Arr[3]) < real(roomName2Arr[3]))
    {
        return true;
    } 
}

print(" -> scr_room1IsBelowRoom2: + " + string(roomName1) + " is not below " + string(roomName2));

return false;
