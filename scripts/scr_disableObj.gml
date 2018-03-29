///scr_disableObj(par_object obj)

var obj = argument0;

print(" -> scr_disableObj(" + string(object_get_name(argument0) + ")"));

obj.isDeactivated = true;
obj.deactivatedX = obj.x;
obj.deactivatedY = obj.y;
obj.x = global.DEACTIVATED_X;
obj.y = global.DEACTIVATED_Y;
