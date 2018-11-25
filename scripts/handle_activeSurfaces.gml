///handle_activeSurfaces(ds_list activeLayers)

var activeLayers = argument0; 

print("-> handle_activeSurfaces()");

/*
    Checks if each layer has had updated movement in the past turn.  If it has, then the surface will be 
    updated in the surface obj's draw event.  
*/
for (var l = 0; l < ds_list_size(activeLayers); l++)
{
    var layer = activeLayers[| l];
    if (layer.isActive)
    {
        layer.surfaceInf.updateSurface = true;
        print(" -> handle_activeSurfaces(): layerName " + string(layer.roomName) + " will be updated.");
        /*if (surface_exists(layer.surfaceInf.surface))
        {
            surface_free(layer.surfaceInf.surface);
        }*/
    }
}


