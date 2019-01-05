///push_objectState(obj_enum  obj, bool pushCurPos)

var object = argument0; //could be player or other character 
var pushCurPos = argument1;  //whether to push the cur obj pos or the old one
var pushX = 0;
var pushY = 0;

print(" -> handle_pushOntoStack() for  " + string(object[| OBJECT.NAME]) + " pushCurrentPos: " + string(pushCurPos));

if (pushCurPos)
{ 
    pushX = object[| OBJECT.X]; 
    pushY = object[| OBJECT.Y]; 
}
else
{ 
    pushX = object[| OBJECT.OLDPOSX]; 
    pushY = object[| OBJECT.OLDPOSY]; 
}

/*
    Pushing movement
*/

if (object[| OBJECT.MOVEHISTORY] != undefined)
{
    ds_stack_push(object[| OBJECT.MOVEHISTORY], string(pushX) + "," + string(pushY));
}

if (object[| OBJECT.NAME] == "obj_spike")
{
    if (object[| OBJECT.STATEHISTORY] != undefined)
    {
        ds_stack_push(object[| OBJECT.STATEHISTORY], object[| OBJECT.STATE] + "," + object[| AI.TARGETDIR]);
    }
}

/*
    If object has a state history, push it.
*/

if (object[| OBJECT.STATEHISTORY] != undefined)
{
    if (object[| OBJECT.NAME] == "obj_spike")
    {
        ds_stack_push(object[| OBJECT.STATEHISTORY], object[| OBJECT.STATE] + "," + object[| AI.TARGETDIR]);
    }
    
    else if (object[| OBJECT.NAME] == "obj_key" || 
            object[| OBJECT.NAME]  == "obj_door" ||
            object[| OBJECT.NAME]  == "obj_baby") 
    {
        ds_stack_push(object[| OBJECT.STATEHISTORY], object[| OBJECT.STATE]);
    }
    
}

if (get_parentOfEnum(object) == "par_breakableWall")
{
    ds_stack_push(object[| OBJECT.STATEHISTORY], object[| AI.HP]);
}

if (object[| OBJECT.CANPULL] || object[| OBJECT.CANPULL])
{
    if (object[| OBJECT.MOVEDDIRHISTORY] != undefined)
    {
        ds_stack_push(object[| OBJECT.MOVEDDIRHISTORY], object[| OBJECT.MOVEDDIR]);
    }
}
