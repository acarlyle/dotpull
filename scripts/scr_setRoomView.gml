///scr_setRoomView();

/*
    Game is scaled Width x Height. set_scaleRes and set_phoneRes are OBE. 
    The view needs to be a pixel-perfect scalable number that works with
    the view port.  so if the view port is *6, the view needs to be *1, *2,
    *3, or *6.  The max size of the port is set from the view in the first room
    in the game, dot_init.  The view port needs to be less than or equal to
    dot_init's view port.  Zoom in functionality can be added with this system.
*/

switch (global.platform)
{
    case "peecee":
    
        view_wview[0] = 192*3; //view width (view is drawn to the view port)
        view_hview[0] = 128*3; //view height (view is drawn to the view port)
        view_wport[0] = 192*6; //port width (view port is portion of screen)
        view_hport[0] = 128*6; //port height (view port is portion of screen)
        
        //1536 x 1024 -> dot_init view port
        
        //window_set_size(global.WINDOW_WIDTH * global.set_phoneRes * global.set_scaleRes, 
        //                global.WINDOW_HEIGHT * global.set_phoneRes * global.set_scaleRes);
        //display_set_gui_size(global.WINDOW_WIDTH * global.set_phoneRes * global.set_scaleRes,
        //                     global.WINDOW_HEIGHT * global.set_phoneRes * global.set_scaleRes);
        
        window_set_size(view_wport[0], view_hport[0]);
        display_set_gui_size(view_wport[0], view_hport[0]);
        break;
}

print(".> scr_setRoomView: W_view, H_view: " + string(view_wview[0]) + "," + string(view_hview[0]));
print(" .> scr_setRoomView: W_viewport, H_viewport: " + string(view_wport[0]) + "," + string(view_hport[0]));

print("");
