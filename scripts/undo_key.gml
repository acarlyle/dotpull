///undo_key(obj_enum key)

/*
    Handles undo for this key obj
*/

var key = argument0;

var state = ds_stack_pop(key.stateHistory);

if (state == "ground" && key[| OBJECT.STATE] == "ground")
{
    key[| OBJECT.ISACTIVE] = true;
    key[| OBJECT.STATE] = "ground";
}
else if (state == "ground" && key[| OBJECT.STATE] == "inventory")
{
    key[| OBJECT.STATE] = "ground";
    obj_player.numKeys--; // TODO -> How to do this better??
    key[| OBJECT.ISACTIVE] = true;
    print("Key is activated");
}
else if (state == "inventory" && key[| OBJECT.STATE] == "inventory")
{
    key[| OBJECT.STATE] = "inventory";
    key[| OBJECT.ISACTIVE] = false;
}
