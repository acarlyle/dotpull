///handle_addRobotToLayer(obj_enum robotToAdd, obj_layer newLayer)

var robotToAdd = argument0;
var newLayer = argument1;

/*
    adds the passed robot to the passed layer
*/

print("-> handle_addRobotToLayer()");

if (newLayer.list_robots == undefined){
    newLayer.list_robots = ds_list_create();
}

ds_list_add(newLayer.list_robots, robotToAdd);  
