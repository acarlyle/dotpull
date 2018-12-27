///scr_initPlatform()

/*
    Height should be the larger number for a phone resolution.  
    Width should be the larger factor for a Desktop / teevee.
    
    The above is how I'ce been coding the game.  However, it might be smarter to just force the game to
    be played horizontaly if on a teeny phone, so both version of the game favour the wide screen
    and I don't have to conduct wizardy with the level design.  GOOD IDEA ALEC.  
*/

print("-> scr_initPlatform");

switch (global.platform)
{
    case "peecee":
        global.set_scaleRes = 3;        
        global.set_phoneRes = 1; //act phone value is 5 (960 * 640)
        global.WINDOW_WIDTH = 192;
        global.WINDOW_HEIGHT = 128;
        alarm[0] = 1; // center the game's screen window; equal to one frame
        print(" -> scr_initPlatform: finished initing platform for " + global.platform);
        break;
}
