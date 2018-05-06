///handle_checkForStairs(par_robot robot)

var robot = argument0;

//MOVE UP/DOWN A FLOOR
if (instance_place(robot.playerX, robot.playerY, par_stairs)){
    var thisRoomName = room_get_name(room);
    print(thisRoomName);
    thisRoomNameArr = scr_split(thisRoomName, "_");
    
    var roomPrefix = thisRoomNameArr[0];
    var roomName = thisRoomNameArr[1];
    var floorType = thisRoomNameArr[2];
    var floorNumber = thisRoomNameArr[3];
    
    if (instance_place(robot.playerX, robot.playerY, obj_stairsAsc)){
        switch(floorType){
            case "b": //basement
                print("asc_basement");
                if (real(floorNumber) == 1){ floorType = "f"; }
                else{ floorNumber = real(floorNumber) - 1; }
                break;
            case "f": //normie floor
                print("asc_floor"); 
                floorNumber = real(floorNumber) + 1;
                break;
        }
    }
    else if instance_place(robot.playerX, robot.playerY, obj_stairsDesc){
        switch(floorType){
            case "b": //basement
                print("desc_basement");
                floorNumber = real(floorNumber) + 1; 
                break;
                
            case "f": //normie floor
                print("desc_floor");
                if (real(floorNumber) == 1){ floorType = "b"; }
                else{ floorNumber = real(floorNumber) - 1; }
                break;
        }   
    }
    
    var newRoomName = roomPrefix + "_" 
                    + roomName + "_" 
                    + string(floorType) + "_" 
                    + string(floorNumber);
                    
    print("newRoomName: " + string(newRoomName));   
    
    handle_gotoRoom(scr_roomFromString(newRoomName), "gotoRoom");   
}
