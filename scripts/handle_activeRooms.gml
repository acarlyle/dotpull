///handle_activeRooms();

/*
    Handle room's objects from rooms other than the current
    floor.
*/

print(" -> handle_activeRooms() ");  

//draw_lowerRooms();
if (room_get_name(room) == "rm_stairs_f_1"){ //TODO - hardcoded room
    if (!instance_exists(surf_lowerRooms)) instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, surf_lowerRooms);
    else { print("how the fuck do you not exist"); }
}
