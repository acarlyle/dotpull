///handle_switchPlayerLayer(obj_layer layer, obj_enum robotToRemove)

var layer = argument0;
var robot = argument1;

/*
    Removes all physical and virtual references of this object from this layer.
    Creates a new robot at its current virtual position and uses that when the room transitions for its initial placement in the room. 
    
    TODO -> need to set the temp real player to have the number of keys that the robot enum has 
*/

print("-> handle_switchPlayerLayer()");

print(" -> handle_switchPlayerLayer list_robots size before delete: " + string(ds_list_size(layer.list_robots)));

for (var r = 0; r < ds_list_size(layer.list_robots); r++){
    var robotCheck = layer.list_robots[| r]
    if(robotCheck[| OBJECT.NAME] == robot[| OBJECT.NAME]){ //if it's the right robot to remove
        print(" -> handle_switchPlayerLayer: Removing " + string(robot[| OBJECT.NAME]) + " from layer " + string(layer.roomName));
        with(get_objectFromString(robot[| OBJECT.NAME])) instance_destroy();
        var robotInst = instance_create(robot[| OBJECT.X], robot[| OBJECT.Y], get_objectFromString(robot[| OBJECT.NAME]));
        //print(" -> handle_switchPlayerLayer: obj_player instances now: " + string(instance_number(obj_player)));
        
        /*
            IF the layer exists, add this robot to the new layer.  The new layer should have been set in
            obj_layerManager.playerLayer has already been updated to the new layer.  
        */
        
        if (obj_layerManager.playerLayer != undefined)
        {
            var movingRobotEnum = ds_list_create();
            ds_list_copy(movingRobotEnum, robot); //copies robot enum to a new list to add to the new layer
            //movingRobotEnum[| OBJECT.MOVED] = true;
            movingRobotEnum[| ROBOT.CANMOVE] = false;
            ds_list_add(obj_layerManager.playerLayer.list_robots, movingRobotEnum); 
         
            /* Now, add the newly copied robot to its new layer's map. */
            layer_addObjToArrMap(obj_layerManager.playerLayer , layer.robot);
               
            print(" -> handle_switchPlayerLayer: ADDED robot " + string(robot[| OBJECT.NAME]) + " to new layer room " + string(room_get_name(obj_layerManager.playerRoom)));
        }
        
        /* Remove obj from its current position in this layer's Map. */
        layer_removeObjFromArrMap(layer, layer.robot);
        
        /* Now free the object from its position in this layer. */
        ds_list_delete(layer.list_robots, r);
        ds_list_destroy(robot);
        layer.robot = undefined;
        
    } 
}



obj_layerManager.loadedRoom = false;
obj_layerManager.loadingRoom = true;

layer.surfaceInf.isMainSurface = false;
layer.surfaceInf.alpha /= 2;

if (scr_room1IsBelowRoom2(room_get_name(obj_layerManager.playerRoom), layer.roomName))
{
    layer.surfaceInf.isActive = false;
}

print(" -> handle_switchPlayerLayer list_robots size post-delete: " + string(ds_list_size(layer.list_robots)));
