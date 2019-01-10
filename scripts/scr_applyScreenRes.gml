///scr_applyScreenRes

// max size for me locally WxH = (192 x 128) * 10 -> (1920 -> 1280) 

//window_set_size(global.WINDOW_WIDTH * global.set_phoneRes * global.set_scaleRes, 
//                global.WINDOW_HEIGHT * global.set_phoneRes * global.set_scaleRes);
                

display_set_gui_size(global.WINDOW_WIDTH * global.set_phoneRes * global.set_scaleRes,
                     global.WINDOW_HEIGHT * global.set_phoneRes * global.set_scaleRes);
