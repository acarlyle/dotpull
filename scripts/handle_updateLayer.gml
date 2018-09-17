///handle_updateLayer(obj_layer layer)

/*

    TODO needs better implemenation rather than this hackish workaround:
    
        Handle updating fake layer
        If obj_player is this layer's robot, this is the fake layer (real objects are in the room) 

    This function's purpose is to update this layer object's sprite positions
    based on their changed state in this layer's Array Map.  
    
*/

var layer = argument0;
print("-> handle_updateLayer");

//var stoopidTrigger = instance_place(16, 112, obj_trigger);
//if (stoopidTrigger) print("STOOOOPID STOOPID 3!!!");

var robot = layer.robot;

for (var o = 0; o < ds_list_size(layer.list_objEnums); o++){
    var object = layer.list_objEnums[| o];
    
    print(" -> handle_updateLayer for " + string(object[| OBJECT.NAME]) + " at: " + string(object[| OBJECT.OLDPOSX]) +  "," + string(object[| OBJECT.OLDPOSY]));
    
    //var stoopidTrigger = instance_place(16, 112, obj_trigger);
    //if (stoopidTrigger) print("STOOOOPID STOOPID 4!!!");
    
    if (robot[| OBJECT.NAME] == "obj_player"){
    
        var objInst = instance_place(object[| OBJECT.OLDPOSX], object[| OBJECT.OLDPOSY], get_objectFromString(object[| OBJECT.NAME]));
        if (!objInst) continue;
        
        //var stoopidTrigger = instance_place(16, 112, obj_trigger);
        //if (stoopidTrigger) print("STOOOOPID STOOPID 5!!!");
        
        if (object[| OBJECT.X] == global.DEACTIVATED_X || object[| OBJECT.Y] == global.DEACTIVATED_Y){
            print(object[| OBJECT.NAME] + " is disabled, cannot map_place deactivated tilePos.");
            
            print(objInst.x);
            print(objInst.y);
            objInst.x = global.DEACTIVATED_X;
            objInst.y = global.DEACTIVATED_Y;
            continue;
        }
        
        var stoopidTrigger = instance_place(16, 112, obj_trigger);
        if (stoopidTrigger) print("STOOOOPID STOOPID 6!!!");
        
        objInst.x = object[| OBJECT.X];
        var stoopidTrigger = instance_place(16, 112, obj_trigger);
        if (stoopidTrigger) print("STOOOOPID STOOPID 7!!!");
        objInst.y = object[| OBJECT.Y];
        var stoopidTrigger = instance_place(16, 112, obj_trigger);
        if (stoopidTrigger) print("STOOOOPID STOOPID 8!!!");
        objInst.image_index = object[| OBJECT.IMGIND];
        var stoopidTrigger = instance_place(16, 112, obj_trigger);
        if (stoopidTrigger) print("STOOOOPID STOOPID 9!!!");
        
    }   
}
