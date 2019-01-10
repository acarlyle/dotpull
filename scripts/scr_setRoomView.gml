///scr_setRoomView();

/*
    Game is scaled Width x Height. set_scaleRes and set_phoneRes are OBE. 
*/

switch (global.platform)
{
    case "peecee":
    
        view_wview[0] = 192*3; //view width (view is drawn to the view port)
        view_hview[0] = 128*3; //view height (view is drawn to the view port)
        view_wport[0] = 192*9; //port width (view port is portion of screen)
        view_hport[0] = 128*9; //port height (view port is portion of screen)
        
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
