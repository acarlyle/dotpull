///scr_initRoom

/*
    Called in every room's creation code  
*/

print(" ####################################### ");
print("");
print ("-> scr_initRoom() for " + string(room_get_name(room)));
print("");

var layer;

/*
    If this is the first room loaded in, construct a layermanager.
*/

if (!instance_exists(obj_layerManager))
{
    con_layerManager();
}

/*
    Init every layer in this room and hand them off to the LayerManager.  This is done
    for every rm_ in this layer.  
*/

if (obj_layerManager.loadingRoom && !obj_layerManager.loadedRoom)
{

    var roomSaveFileName = string(room_get_name(room)) + ".sav";
    
    if (file_exists(roomSaveFileName)) 
    {
        file_delete(roomSaveFileName);
        print("###############################");
        print("###############################");
        print("###############################");
        print(" -> scr_initRoom: Warning: " + string(roomSaveFileName) + " has been deleted!");
    }
    
    var priorityElementList = con_priorityObjectList(); //gets a list of every object in this room sorted by movement priority 
    
    //add layer to layer manager's active layer list if it's not there
    layer = con_layer(room_get_name(room), priorityElementList);
    ds_list_add(obj_layerManager.list_activeLayers, layer);
    print(" -> scr_initRoom: added layer of room " + string(layer.roomName) + " to the global.activeLayers ds list in the layerManager.");
    
    if (obj_layerManager.playerRoom == room) 
    {
        obj_layerManager.playerLayer = layer; //set the correct player layer
        print(" -> scr_initRoom: obj_layerManager playerLayer set to: " + string(room_get_name(room)));
    }
    
    /*
        Create a persistent asset (persistent only affects this instance!) 
        reference at deactivated tile so that every layer has calling access 
        to every active object.  
    */
    
    if (!instance_place(global.DEACTIVATED_X, global.DEACTIVATED_Y, obj_platform))
    {
        var platform = instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, obj_platform);
        platform.persistent = true;
    }
    
    print(" -> scr_initRoom: list_objEnums size: " + string(ds_list_size(layer.list_objEnums)));
    
    for (var i = 0; i < ds_list_size(layer.list_objEnums); i++)
    {
        var objEnum = layer.list_objEnums[| i];
        if (!instance_place(global.DEACTIVATED_X, global.DEACTIVATED_Y, get_objectFromString(objEnum[| OBJECT.NAME])))
        { 
            var inst = instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, get_objectFromString(objEnum[| OBJECT.NAME]));
            inst.persistent = true;
            print(" -> scr_initRoom: Created a deactivated " + string(objEnum[| OBJECT.NAME]) + " at " + string(global.DEACTIVATED_X) + "," + string(global.DEACTIVATED_Y));
        }
    }
    
    ds_list_destroy(priorityElementList);
    
    /*
        Layer initialization happens from the lowest possible layer all the way up to the room where scr_initRoom was initially called.
        If there's a room above us, continue initing each layer.  Otherwise, head to the PlayerLayer and load in the real level.  
    */
    
    var higherRoomName = get_higherRoomName(room_get_name(room));
    if (higherRoomName != undefined && !layer_isActive(get_layerFromRoomStr(higherRoomName)))
    {
        room_goto(get_roomFromString(higherRoomName));
        print(" -> scr_initRoom: higher room detected.  roomGoto(" + string(higherRoomName) + ")");
    }
    else
    {
        /*
            For some reason a simple room_goto isn't working when we're scr_initRooming from one floor to another.
            This forces GameMaker to actually load in the surface and purge all the real objs.
        */
        
        if ((room) == obj_layerManager.playerRoom)
        {
            obj_layerManager.loadedRoom = true;
            obj_layerManager.loadingRoom = false;
        }
        
        //room_goto(obj_layerManager.playerRoom);
        
    }
    
}
else if (obj_layerManager.loadingRoom == false && obj_layerManager.loadedRoom == false)
{
    obj_layerManager.loadingRoom = true;
    print(" -> scr_initRoom() loadingRoom is a go!  loadingRoom is true.");
}

if (obj_layerManager.loadedRoom) 
{ 

    /*
        Surfaces are not persistent objects.  they will need to be constructed again after the loading phase 
        switches between several rooms.
    */
    
    
    layer = get_layerFromRoomStr(room_get_name(room));
    layer.surfaceInf = con_surface(surf_layerRoom, layer, 0, 0, 1, 1, 0, c_white, 1);
    
    /*
        Free up real objects in the room (does not clear obj_controls or objects hanging around 
        as asset references). 
    */
    
    with (par_object)
    {
        if (x != global.DEACTIVATED_X && y != global.DEACTIVATED_Y)
        {
            instance_destroy();
            print(" -> scr_initRoom: Destroyed real obj " + string(object_get_name(object_index)) + " at x,y: " + string(x) + "," + string(y));
        }
    }
    
    print(" -> scr_initRoom: " + string(room_get_name(room)) + " loaded."); 
    
}
