///undo_roborDeath(par_robot robot)

robot = argument0;

switch(string(object_get_name(robot.object_index))){
    case "obj_player":
        print("objPlayer sprite");
        sprite_index = spr_player;
        break;
    case "obj_roberta":
        print("roberta spr");
        sprite_index = spr_roberta;
        break;
}

robot.isDead = false;
