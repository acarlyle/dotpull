///handle_updateSurface()

/*

    This function's purpose is to update this surface object's sprite positions
    based on their changed state in this surface's Array Map.  
    
    If the Surface contains the player, update_mainSurface funtion is called.  Otherwise,
    it is assumed the layer is below the player's layer so update_lowerSurface handles that.
    
*/

print("-> handle_updateSurface() for " + layer.roomName);

if (isActive)
{
    if (isMainSurface)
    {
        update_mainSurface(); // updates gamemaker surface owned by this SurfaceInf
    }
    else
    {
        //print("-> handle_updateSurface() PRE roomname: " + layer.roomName);
        update_lowerSurface(); // updates gamemaker surface owned by this SurfaceInf
        //print("-> handle_updateSurface() POST roomname: " + layer.roomName);
    }
}

updateSurface = false; //finished updating surface

//print("-> handle_updateSurface() POST roomname: " + surfaceInf.layer.roomName);
