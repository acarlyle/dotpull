///scr_pickupObject(par_object object)

var object = argument0;

print("-> scr_pickupObject(" + object_get_name(object.object_index) + ")");

audio_play_sound(snd_keyPickup, 10, false);

switch(object_get_name(object.object_index)){
    case "obj_baby":
        object.currentState = "inventory";
        object.isDeactivated = true;
        object.justDeactivated = true;
        object.deactivatedX = x;
        object.deactivatedY = y;
        ds_stack_push(object.moveHistory, string(object.x) + "," + string(object.y));
        ds_stack_push(object.stateHistory, "ground");
        ds_stack_push(obj_player.itemHistory, array(obj_player.numKeys, true));
        obj_player.hasBaby = true;
        object.x = global.DEACTIVATED_X;
        object.y = global.DEACTIVATED_Y;
        break;
}
