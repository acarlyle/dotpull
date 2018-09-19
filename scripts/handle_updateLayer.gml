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

    print("objEnum # " + string(o));    

    var object = layer.list_objEnums[| o];
    
    //print(ds_list_size(layer.list_objEnums));
    
    print(" -> handle_updateLayer for " + string(object[| OBJECT.NAME]) + " at: " + string(object[| OBJECT.OLDPOSX]) +  "," + string(object[| OBJECT.OLDPOSY]));
    
    //var stoopidTrigger = instance_place(16, 112, obj_trigger);
    //if (stoopidTrigger) print("STOOOOPID STOOPID 4!!!");
    
    if (robot[| OBJECT.NAME] == "obj_player"){
    
        //if ((object[| OBJECT.X] == object[| OBJECT.OLDPOSX]) && 
        //    object[| OBJECT.Y] == object[| OBJECT.OLDPOSY]) continue;
    
        print("old enum objectX: " + string(object[| OBJECT.OLDPOSX]));
        print("old enum objectY: " + string(object[| OBJECT.OLDPOSY]));
        print("cur enum objectX: " + string(object[| OBJECT.X]));
        print("cur enum objectY: " + string(object[| OBJECT.Y]));
        
        with(obj_trigger) {
            print("BEFORE: woo it's a trigger at: " + string(x) + "," + string(y));
        }
    
        var objInst = instance_place(object[| OBJECT.OLDPOSX], object[| OBJECT.OLDPOSY], get_objectFromString(object[| OBJECT.NAME]));
        if (!objInst){
            //print("This instance doesn't exist.  Continuing...."); 
            continue;
        }
        
        print("inst Obj: " + string(object_get_name(objInst.object_index)));
        print("inst objX: " + string(objInst.x));
        print("inst objY: " + string(objInst.y));
        
        //var stoopidTrigger = instance_place(16, 112, obj_trigger);
        //if (stoopidTrigger) print("STOOOOPID STOOPID 5!!!");
        
        /*if (object[| OBJECT.X] == global.DEACTIVATED_X || object[| OBJECT.Y] == global.DEACTIVATED_Y){
            print(object[| OBJECT.NAME] + " is disabled, cannot map_place deactivated tilePos.");
            
            print(objInst.x);
            print(objInst.y);
            objInst.x = global.DEACTIVATED_X;
            objInst.y = global.DEACTIVATED_Y;
            continue;
        }*/
        
        objInst.x = real(object[| OBJECT.X]);
        objInst.y = real(object[| OBJECT.Y]);
        objInst.image_index = real(object[| OBJECT.IMGIND]);
        
        with(obj_trigger) {
            print("AFTER: woo it's a trigger at: " + string(x) + "," + string(y));
        }
        
    }   
}
