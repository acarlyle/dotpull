///scr_getInput

key_left = keyboard_check_released(vk_left) || keyboard_check_released(ord('A')) || keyboard_check_released(vk_numpad4);
key_right = keyboard_check_released(vk_right) || keyboard_check_released(ord('D')) || keyboard_check_released(ord('6')) || keyboard_check_released(vk_numpad6);
key_up = keyboard_check_released(vk_up) || keyboard_check_released(ord('W')) || keyboard_check_released(vk_numpad8);
key_down = keyboard_check_released(vk_down) || keyboard_check_released(ord('S')) || keyboard_check_released(vk_numpad2);
key_upleft = keyboard_check_released(ord('Q')) || keyboard_check_released(ord("7")) || keyboard_check_released(vk_home) || keyboard_check_released(vk_numpad7);
key_upright = keyboard_check_released(ord('E')) || keyboard_check_released(ord("9")) || keyboard_check_released(vk_pageup) || keyboard_check_released(vk_numpad9);
key_downleft = keyboard_check_released(ord('Z')) || keyboard_check_released(ord("1")) || keyboard_check_released(vk_end) || keyboard_check_released(vk_numpad1);
key_downright = keyboard_check_released(ord('C')) || keyboard_check_released(ord("3")) || keyboard_check_released(vk_pagedown) || keyboard_check_released(vk_numpad3);
key_r = keyboard_check_released(ord('R'));
key_esc = keyboard_check_released(vk_escape);

if (key_esc){
    handle_restartLevel();
}
else{
    if (key_left || key_right || key_up || key_down ||
        key_upleft || key_upright || key_downleft || key_downright) move = true;
    if (key_r) undo = true;
}
//print(key_right);

//if (vk_anykey) global.playerMoved = true; //move after player moves
