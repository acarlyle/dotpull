///get_input()

//TODO deal with hardcoded obj_player (this might be ok)

global.key_left = keyboard_check_released(vk_left) || keyboard_check_released(ord('A')) || keyboard_check_released(vk_numpad4);
global.key_right = keyboard_check_released(vk_right) || keyboard_check_released(ord('D')) || keyboard_check_released(ord('6')) || keyboard_check_released(vk_numpad6);
global.key_up = keyboard_check_released(vk_up) || keyboard_check_released(ord('W')) || keyboard_check_released(vk_numpad8);
global.key_down = keyboard_check_released(vk_down) || keyboard_check_released(ord('S')) || keyboard_check_released(vk_numpad2);
global.key_upleft = keyboard_check_released(ord('Q')) || keyboard_check_released(ord("7")) || keyboard_check_released(vk_home) || keyboard_check_released(vk_numpad7);
global.key_upright = keyboard_check_released(ord('E')) || keyboard_check_released(ord("9")) || keyboard_check_released(vk_pageup) || keyboard_check_released(vk_numpad9);
global.key_downleft = keyboard_check_released(ord('Z')) || keyboard_check_released(ord("1")) || keyboard_check_released(vk_end) || keyboard_check_released(vk_numpad1);
global.key_downright = keyboard_check_released(ord('C')) || keyboard_check_released(ord("3")) || keyboard_check_released(vk_pagedown) || keyboard_check_released(vk_numpad3);
global.key_r = keyboard_check_released(ord('R'));
global.key_esc = keyboard_check_released(vk_escape);
global.key_space = keyboard_check_released(vk_space);

if (global.key_esc){
    return "restart";
}
else{
    //disable multiple turns in one move
    if (global.key_left + global.key_right + global.key_up + global.key_down +
        global.key_upleft + global.key_upright + global.key_downleft + 
        global.key_downright + global.key_space >= 2){
        
        return false; //do nothing, movement disabled
    }
    else if (global.key_left || global.key_right || global.key_up || global.key_down ||
        global.key_upleft || global.key_upright || global.key_downleft || global.key_downright ||
        global.key_space) return "move";
    //else if (global.key_r) return "undo";
}
