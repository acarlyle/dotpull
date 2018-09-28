///handle_removeRobotFromLayer(obj_layer layer, obj_enum robotToRemove)

var layer = argument0;
var robot = argument1;

for (var r = 0; r < ds_list_size(layer.list_robots); r++){
    var robotCheck = layer.list_robots[| r]
    if(robotCheck[| OBJECT.NAME] == robot[| OBJECT.NAME]){ //if it's the right robot to remove
        print("handle_removeRobotFromLayer: Removing " + string(robot[| OBJECT.NAME]) + " from layer " + string(layer.roomName));
        //var robotInst = instance_create(robot[| OBJECT.X], robot[| OBJECT.Y], get_objectFromString(robot[| OBJECT.NAME]));
        print("handle_removeRobotFromLayer: obj_player instances now: " + string(instance_number(obj_player)));
        ds_list_delete(layer.list_robots[| r], r);
        ds_list_destroy(robot);
    } 
}
