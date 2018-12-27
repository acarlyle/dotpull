///undo_roborDeath(par_robot robot)

robot = argument0;

switch(robot[| OBJECT.NAME])
{
    case "obj_player":
        print("objPlayer sprite");
        robot[| OBJECT.IMGIND] = 0; //TODO -> Death sprites
        break;
    
    case "obj_roberta":
        print("roberta spr");
        robot[| OBJECT.IMGIND] = 0; //TODO -> Death sprites
        break;
}

robot[| ROBOT.ISDEAD] = false;
