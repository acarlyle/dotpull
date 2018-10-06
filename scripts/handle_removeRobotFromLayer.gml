///handle_switchPlayerLayer(obj_layer layer, obj_enum robotToRemove)

var layer = argument0;
var robot = argument1;

/*
    Removes all physical and virtual references of this object from this layer.
    Creates a new robot at its current virtual position and uses that when the room transitions for its initial placement in the room.  
*/

print("-> handle_switchPlayerLayer()");

for (var r = 0; r < ds_list_size(layer.list_robots); r++){
    var robotCheck = layer.list_robots[| r]
    if(robotCheck[| OBJECT.NAME] == robot[| OBJECT.NAME]){ //if it's the right robot to remove
        print(" -> handle_switchPlayerLayer: Removing " + string(robot[| OBJECT.NAME]) + " from layer " + string(layer.roomName));
        with(get_objectFromString(robot[| OBJECT.NAME])) instance_destroy();
        var robotInst = instance_create(robot[| OBJECT.X], robot[| OBJECT.Y], get_objectFromString(robot[| OBJECT.NAME]));
        print(" -> handle_switchPlayerLayer: obj_player instances now: " + string(instance_number(obj_player)));
        ds_list_delete(layer.list_robots[| r], r);
        ds_list_destroy(robot);
    } 
}
