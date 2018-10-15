///handle_updateLayer(obj_layer layer)

/*

    TODO needs better implemenation rather than this hackish workaround:
    
        Handle updating fake layer
        If obj_player is this layer's robot, this is the fake layer (real objects are in the room) 

    This function's purpose is to update this layer object's sprite positions
    based on their changed state in this layer's Array Map.  
    
*/

var layer = argument0;
print("-> handle_updateLayer() for " + layer.roomName);

if (surface_exists(layer.surfaceInf.surface)){
    print("handle_updateLayer: Updating layer...");
    layer.surfaceInf.surface =  update_mainSurface(layer.surfaceInf.surface, layer);
    print("handle_updateLayer: Finished updating the layer for room " + layer.roomName);
}
