///handle_checkForStairs(obj_layer layer, par_robot robot)

var layer = argument0;
var robot = argument1;

print("-> handle_checkForStairs()");

//MOVE UP/DOWN A FLOOR
if (map_place(layer, par_stairs, robot[| OBJECT.OLDPOSX], robot[| OBJECT.OLDPOSY])){
    var thisRoomName = layer.roomName;
    print(thisRoomName);
    thisRoomNameArr = scr_split(thisRoomName, "_");
    
    var roomPrefix = thisRoomNameArr[0];
    var roomName = thisRoomNameArr[1];
    var floorType = thisRoomNameArr[2];
    var floorNumber = thisRoomNameArr[3];
    
    if (map_place(layer, obj_stairsAsc, robot[| OBJECT.OLDPOSX], robot[| OBJECT.OLDPOSY])){
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
    else if map_place(layer, obj_stairsDesc, robot[| OBJECT.OLDPOSX], robot[| OBJECT.OLDPOSY]){
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
    
    if handle_gotoRoom(scr_roomFromString(newRoomName), "gotoRoom"){ 
        //robot.moved = true; //this allows for objects to move before the room transitions
        robot[| OBJECT.MOVED] = true;
        obj_layerManager.switchMainLayer = true;
        obj_layerManager.playerLayer = get_layerFromRoomStr(newRoomName); //set player layer to new layer
        obj_layerManager.playerRoom = get_roomFromString(newRoomName);
        obj_layerManager.oldPlayerLayer = layer;   
        obj_layerManager.oldPlayerLayerRobot = robot;       
        //robot[| OBJECT.MOVED] = true;
    }
    
}
