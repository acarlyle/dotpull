///scr_getInput

key_left = keyboard_check_released(vk_left) || keyboard_check_released(ord('A'));
key_right = keyboard_check_released(vk_right) || keyboard_check_released(ord('D'));
key_up = keyboard_check_released(vk_up) || keyboard_check_released(ord('W'));
key_down = keyboard_check_released(vk_down) || keyboard_check_released(ord('S'));
key_upleft = keyboard_check_released(ord('Q'));
key_upright = keyboard_check_released(ord('E'));
key_downleft = keyboard_check_released(ord('Z'));
key_downright = keyboard_check_released(ord('C'));
key_r = keyboard_check_released(ord('R'));

if (key_left || key_right || key_up || key_down ||
    key_upleft || key_upright || key_downleft || key_downright) move = true;


//if (vk_anykey) global.playerMoved = true; //move after player moves
