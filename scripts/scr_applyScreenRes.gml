///scr_applyScreenRes

window_set_size(global.WINDOW_WIDTH * global.set_phoneRes * global.set_scaleRes, 
                global.WINDOW_HEIGHT * global.set_phoneRes * global.set_scaleRes);
                
//display_set_gui_maximise(.1, .1);
//display_set_gui_maximise();
                
//display_set_gui_size(global.WINDOW_WIDTH * global.set_phoneRes * global.set_scaleRes, 
//                     global.WINDOW_WIDTH * global.set_phoneRes * global.set_scaleRes);
                     
//display_set_gui_maximise(global.set_phoneRes * global.set_scaleRes,
//                         global.set_phoneRes * global.set_scaleRes);

//display_set_gui_maximise(1, 1, 150, 300); 

//display_set_gui_size(global.WINDOW_WIDTH * global.set_phoneRes * global.set_scaleRes, 
//                     global.WINDOW_WIDTH * global.set_phoneRes * global.set_scaleRes);
                    
//display_set_gui_maximise(1, 1, 0, 0);

//var pos = application_get_position();
//display_set_gui_maximise(1, 1, pos[0], pos[1]);
//display_set_gui_maximise();

display_set_gui_size(global.WINDOW_WIDTH * global.set_phoneRes * global.set_scaleRes,
                     global.WINDOW_HEIGHT * global.set_phoneRes * global.set_scaleRes);
//display_set_gui_maximise(1, 1, 0, 0);
