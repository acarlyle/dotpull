///move_key(obj_layer layer, obj_key key)

/*
    This code used to be in move_pullPushables, but it should
    be elsewhere (probably here).  
*/

/*if (!objMove && canFall && instance_place(x, y, obj_hole)){
    //print("and this object falls down");
    sprite_index = spr_key;
    isDeactivated = true;
    justDeactivated = true;
    deactivatedX = x;
    deactivatedY = y;
    ds_stack_push(moveHistory, string(x) + "," + string(y));
    x = 0;
    y = 0;
}
//else if (!instance_place(x, y, obj_hole) && canFall){
//    sprite_index = spr_key;
//    //print("no hole");
//}
else if(instance_place(x, y, obj_hole) && canFall){
    //print("HOLE");
    sprite_index = spr_keyFloating;
    image_speed = .3;
}*/
