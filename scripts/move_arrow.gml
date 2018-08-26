///move_arrow(obj_layer layer, par_arrow arrow, par_robot robot)

/*
    This function handles:
        obj_arrow_down_rotate
        obj_arrow_up_rotate
        obj_arrow_left_rotate
        obj_arrow_right_rotate
        obj_arrow_down_static
        obj_arrow_up_static
        obj_arrow_left_static
        obj_arrow_right_static
*/

var layer = argument0;
var arrow = argument1;

if (arrow.isRotating){
   switch(arrow.dir){
       case "up":
           arrow.dir = "right";
           break;
       case "right":
           arrow.dir = "down";
           break;
       case "down":
           arrow.dir = "left";
           break;
       case "left":
           arrow.dir = "up";
           break;
   }
   sprite_index = asset_get_index("spr_arrow_" + arrow.dir);
   print("done rotate");
}
