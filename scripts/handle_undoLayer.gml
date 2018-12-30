///handle_undoLayer(obj_layer layer)

/*
    Unwinds the passed layer's objects back 1 turn.
*/

var layer = argument0;

var robot;

print("-> handle_undoLayer for room " + layer.roomName);

handle_cleanUpElementEffects();

/*
    Handle undo robots.
*/

if (ds_list_size(layer.list_robots) > 0)
{
    for (var r = 0; r < ds_list_size(layer.list_robots); r++) //foreach robot in this layer
    {
        layer.robot = layer.list_robots[| r]; //robot enum
        robot = layer.robot;

        //undo player's death
        if (robot[| ROBOT.ISDEAD])
        { 
            undo_robotDeath(robot);
        }
        
        if (!ds_stack_empty(robot[| OBJECT.MOVEHISTORY]))
        {
            var continueUndo = undo_robot(robot); //don't undo these objects if we're switching rooms
            if (!continueUndo) handle_pushOntoStack(robot, true); //push every objects' state, even if undoing
            if (continueUndo)
            {
                //handle every puzzle element's stack in this room
                for (var enumI = 0; enumI < ds_list_size(layer.list_objEnums); enumI++)
                {
                    var object = layer.list_objEnums[| enumI];
                    
                    print("Handling undo for " + string(object[| OBJECT.NAME]));
                    
                    if (object[| OBJECT.NAME] == "obj_spike")
                    {
                        undo_spike(object);
                    }
                    if (get_parentOfEnum(object) == "par_breakableWall")
                    {
                        undo_breakableWall(object);
                    }
                    if (get_parentOfEnum(object) == "par_fallingPlatform")
                    {
                        undo_fallingPlatform(object);
                    }
                    if (get_parentOfEnum(object) == "par_arrow")
                    {
                        undo_arrow(object);
                    }
                    
                    /*
                        X, Y Position-sensitive objects
                    */
                    
                    var objPosStr = ds_stack_pop(object[| OBJECT.MOVEHISTORY]); //string e.g. "64,64"

                    if (objPosStr != undefined)
                    {
                        var objCoordArr = scr_split(objPosStr, ",");
                        object[| OBJECT.X] = objCoordArr[0];
                        object[| OBJECT.Y] = objCoordArr[1];
                        
                        // set old object pos (this is the val pushed to the obj's stack)
                        var oldObjPosStr = ds_stack_top(object[| OBJECT.MOVEHISTORY]);
                        if (oldObjPosStr != undefined)
                        {
                            var oldObjPosArr = scr_split(oldObjPosStr, ",");
                            object[| OBJECT.OLDPOSX] = oldObjPosArr[0];
                            object[| OBJECT.OLDPOSY] = oldObjPosArr[1];
                        }
                        else
                        {
                            object[| OBJECT.OLDPOSX] = object[| OBJECT.X];
                            object[| OBJECT.OLDPOSY] = object[| OBJECT.Y]
                        }
                        //undo trigger
                        if (object[| OBJECT.NAME] == "obj_trigger" || objectStr == "obj_triggerDoor")
                        {
                            undo_trigger(object);
                        }
                        if (object[| OBJECT.NAME]== "obj_triggerDoor")
                        {
                            undo_triggerDoor(object);
                        }
                        if (object[| OBJECT.NAME] == "obj_key")
                        {
                            undo_key(object);
                        }
                        if (object[| OBJECT.NAME] == "obj_baby")
                        {
                            undo_baby(object);
                        }
                        if (object[| OBJECT.NAME] == "obj_door")
                        {
                            undo_door(object);
                        }
                        if (get_parentOfEnum(object) == "par_cannon")
                        {
                            undo_cannon(object);
                        }
                        
                        if (object[| OBJECT.MOVEDDIR] != "")
                        {
                            object[| MOVEDDIR] = ds_stack_pop(object[| OBJECT.MOVEDDIRHISTORY]); //object last moved in this dir
                        }
                    }
                }
            }
        }  
    }
}
