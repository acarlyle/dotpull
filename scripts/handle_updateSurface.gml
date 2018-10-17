///handle_updateSurface(par_surface surfaceInf)

/*

    This function's purpose is to update this surface object's sprite positions
    based on their changed state in this surface's Array Map.  
    
    If the Surface contains the player, update_mainSurface funtion is called.  Otherwise,
    it is assumed the layer is below the player's layer so update_lowerSurface handles that.
    
*/

var surfaceInf = argument0;

print("-> handle_updateSurface() for " + surfaceInf.layer.roomName);

if (surfaceInf.isActive)
{
    if (surfaceInf.isMainSurface)
    {
        surfaceInf.surface = update_mainSurface(surfaceInf.surface, surfaceInf.layer); 
    }
    else
    {
        surfaceInf.surface = update_lowerSurface(surfaceInf.surface, get_higherRoomName(surfaceInf.layer.roomName)); 
    }
}
