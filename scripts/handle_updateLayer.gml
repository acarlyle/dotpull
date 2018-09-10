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

var robot = layer.robot;

for (var o = 0; o < ds_list_size(layer.list_objEnums); o++){
    var object = layer.list_objEnums[| o];
    
    if (robot[| OBJECT.NAME] == "obj_player"){
    
        var objInst = instance_place(object[| OBJECT.OLDPOSX], object[| OBJECT.OLDPOSY], get_objectFromString(object[| OBJECT.NAME]));
        if (!objInst) continue;
        
        if (object[| OBJECT.X] == global.DEACTIVATED_X || object[| OBJECT.Y] == global.DEACTIVATED_Y){
            print(object[| OBJECT.NAME] + " is disabled, cannot map_place deactivated tilePos.");
            
            print(objInst.x);
            print(objInst.y);
            objInst.x = global.DEACTIVATED_X;
            objInst.y = global.DEACTIVATED_Y;
            continue;
        }
        
        objInst.x = object[| OBJECT.X];
        objInst.y = object[| OBJECT.Y];
        objInst.image_index = object[| OBJECT.IMGIND];
    }   
}
