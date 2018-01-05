///scr_getInput

key_left = keyboard_check_released(vk_left) || keyboard_check_released(ord('A'));
key_right = keyboard_check_released(vk_right) || keyboard_check_released(ord('D'));
key_up = keyboard_check_released(vk_up) || keyboard_check_released(ord('W'));
key_down = keyboard_check_released(vk_down) || keyboard_check_released(ord('S'));
key_upleft = keyboard_check_released(ord('Q')) || keyboard_check_released(ord("7")) || keyboard_check_released(vk_home);
key_upright = keyboard_check_released(ord('E')) || keyboard_check_released(ord("9")) || keyboard_check_released(vk_pageup);
key_downleft = keyboard_check_released(ord('Z')) || keyboard_check_released(ord("1")) || keyboard_check_released(vk_end);
key_downright = keyboard_check_released(ord('C')) || keyboard_check_released(ord("3")) || keyboard_check_released(vk_pagedown);
key_r = keyboard_check_released(ord('R'));

if (key_left || key_right || key_up || key_down ||
    key_upleft || key_upright || key_downleft || key_downright) move = true;


//if (vk_anykey) global.playerMoved = true; //move after player moves
