///handle_activeLayers(ds_list activeLayers)

var 
var activeLayers = argument0;

scr_clearStepGlobals();

var inputString = get_input();

switch(inputString){
    case "move":
        print("handle_activeLayers: movement input detected.  will process");
        break;
    case "restart":
        global.restartRoom = true;
        //global.playerCanMove = false;
        break;
}   

//handle move, restart room
if (inputString != false)
{

    //handle each active layer
    for (var l = 0; l < ds_list_size(activeLayers); l++){
    
        var layer = activeLayers[| l];
        
        print("");
        print("#####################");
        print("handle_activeLayers: handling layer for room " + string(layer.roomName));
        print("#####################");
        print("");
        
        if (global.restartRoom) handle_restartRoom(layer);
    
        //used for cutscene triggers
        if (global.playerCanMove && layer.list_robots){
        
            //if (object_is_ancestor(obj_platform, par_object)) print("YES");
        
        
            //print("48: " + self.roomMapArr[112 / 16, 48/16]);
            //print("32: " + self.roomMapArr[112 / 16, 32/16]);
            //print("16: " + self.roomMapArr[112 / 16, 16/16]);
        
            for (var r = 0; r < ds_list_size(layer.list_robots); r++) //foreach robot in this layer
            {
                layer.robot = layer.list_robots[| r]; //robot enum
                
                if (global.restartRoom) break;
                
                if (!layer.robot[| ROBOT.ISDEAD]){
                    print("handle_activeLayers: robot " + string(layer.robot[| OBJECT.NAME]));
                    if (global.playerMoved || layer.robot[| OBJECT.NAME] == "obj_player"){
                        handle_layerRobots(layer); //move is true if movement key is pressed
                    }
                }
                
                if (layer.robot){
                    if (layer.robot[| OBJECT.MOVED]) {
                        print("player moved totes");
                        handle_layerObjects(layer);  //moved is true if player successfully moved
                    }
                }
                
                //TODO -> Correctly update the Layer if an object has moved (current stuff is hardcoded)
                
                //var stoopidTrigger = instance_place(16, 112, obj_trigger);
                //if (stoopidTrigger) print("STOOOOPID STOOPID!!!");
                
                //save state
                if (global.playerMoved){
                    handle_gameSave(obj_player);
                    handle_updateLayer(layer);
                }
                //cleanup memory before switch rooms.  need to remove robot stuff from this layer
                if global.switchRooms{
                    handle_freeMemory();
                    handle_removeRobotFromLayer(layer, layer.robot);
                }
            }
        }
    }
}
