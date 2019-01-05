///handle_activeLayers(ds_list activeLayers)

var activeLayers = argument0;

scr_clearStepGlobals();

var inputString = get_input();

switch(inputString)
{
    case "move":
        break;
    case "restart":
        global.restartRoom = true;
        //global.playerCanMove = false;
        break;
    case "undo":
        global.undoRoom = true;
}   

//handle move, undo move
if (inputString != false)
{

    print("");
    print("----------------------------------------------");
    print("");
    print(" -> handle_activeLayers: START of LayerManager Turn " + string(obj_layerManager.turnNum));
    print("");
    

    //handle each active layer
    for (var l = 0; l < ds_list_size(activeLayers); l++)
    {
    
        var layer = activeLayers[| l];
 
        print("");
        print("-> handle_activeLayers: handling layer for room " + string(layer.roomName));
        
        if (global.restartRoom)
        {
            handle_restartRoom(layer);
            continue;
        }
        
        if (global.undoRoom)
        {
            handle_undoLayer(layer);
            continue;
        }
    
        /*
            TODO -> Check if the player can move before you handle every object.  The rules of dotpull work in the way
            that in order for objects to move, you have to move first.  
        */
        
        if (global.playerCanMove)
        {
        
            /*
                If there are objects in this layer, handle it normally (robot moves, object moves, repeat).
                Otherwise, if a layer is active, handle the objects in that layer, even if there's no robots
                there (this allows for active objects such as spikes to continue moving on a floor below the 
                player).  
            */
            
            print(" -> handle_activeLayers list_robots size: " + string(ds_list_size(layer.list_robots)));
            if (ds_list_size(layer.list_robots) > 0)
            {
                for (var r = 0; r < ds_list_size(layer.list_robots); r++) //foreach robot in this layer
                {
                    layer.robot = layer.list_robots[| r]; //robot enum
                                        
                    print("!!!!!!!!!!!!! " + string(strlen(layer.robot[| OBJECT.NAME]))); 
                    
                    if (global.restartRoom) break;
                    
                    if (!layer.robot[| ROBOT.ISDEAD])
                    {
                        print(" -> handle_activeLayers: robot " + string(layer.robot[| OBJECT.NAME]));
                        if (global.playerMoved || layer.robot[| OBJECT.NAME] == "obj_player")
                        {
                            handle_layerRobots(layer); //move is true if movement key is pressed
                        }
                    }
                    
                    if (layer.robot)
                    {
                        if (layer.robot[| OBJECT.MOVED]) 
                        {
                            print("player moved totes");
                            handle_layerObjects(layer);  //moved is true if player successfully moved
                            layer.robot[| OBJECT.MOVED] = false;
                            
                            //update camera position if this is the player
                            if (obj_layerManager.playerLayer == layer)
                            {
                                var layerPlayer = layer.robot;
                                state_centerCamera(layerPlayer[| OBJECT.X], layerPlayer[| OBJECT.Y]);
                            }
                            
                        }
                    }
                    
                    //TODO -> Correctly update the Layer if an object has moved (current stuff is hardcoded)
                    
                    //var stoopidTrigger = instance_place(16, 112, obj_trigger);
                    //if (stoopidTrigger) print("STOOOOPID STOOPID!!!");
                    
                    //save state
                    if (global.playerMoved || layer.isActive)
                    {  
                        handle_gameSave(obj_player);
                        layer.surfaceInf.updateSurface = true;
                        //handle_updateSurface(layer.surfaceInf);
                    }
                    
                    /*
                        if switchMainLayer is true, the LayerManager needs to handle a main layer switch here.
                    */
                    
                    /*if (obj_layerManager.switchMainLayer)
                    {
                        handle_switchPlayerLayer(layer, layer.robot);   
                    }*/
                } //foreach layer robot
            }
            else if (layer.isActive) //No robot present, but layer has active objects to move
            {
                /*
                    If the player layer's room is below this layer's, then do not draw the surface to the screen,
                    as it is above the player.  
                */
                if (scr_room1IsBelowRoom2(room_get_name(obj_layerManager.playerRoom), layer.roomName))
                {
                    layer.surfaceInf.isActive = false;
                    print(" -> handle_activeLayers: " + string(layer.roomName) + "'s surface is no longer active because it's above the player layer.");  
                }
                else
                {
                    handle_layerObjects(layer); 
                    //handle_updateSurface(layer.surfaceInf); 
                    layer.surfaceInf.updateSurface = true;
                } 
            }
        } //global.playerCanMove
        print("-> handle_activeLayers: FINISHED handling layer for room " + string(layer.roomName));
        
        /*for (var l2 = 0; l2 < ds_list_size(activeLayers); l2++)
        {
            var layerish = activeLayers[| l2];
            print(" -> handle_activeLayers: layer room name: " + string(layerish.roomName)); 
        }*/
        
    } //foreach active layer
    
    /*
        if switchMainLayer is true, the LayerManager needs to handle a main layer switch here.
    */
    
    if (obj_layerManager.switchMainLayer)
    {
        handle_switchPlayerLayer(obj_layerManager.oldPlayerLayer, obj_layerManager.oldPlayerLayerRobot);   
    }
    
    
    print("");
    print(" -> handle_activeLayers: END of LayerManager Turn " + string(obj_layerManager.turnNum));
    print("");
    
            
    if (global.playerMoved || obj_layerManager.switchMainLayer)
    {
        obj_layerManager.turnNum++; //increment turn counter
    }
    
    handle_activeSurfaces(activeLayers); /* handle updating Display of Room Elements. */
    
}
