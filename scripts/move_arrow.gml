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

if (arrow[| ARROW.ISROTATING]){
   switch(arrow[| ARROW.DIR]){
       case "up":
           arrow[| ARROW.DIR] = "right";
           break;
       case "right":
           arrow[| ARROW.DIR] = "down";
           break;
       case "down":
           arrow[| ARROW.DIR] = "left";
           break;
       case "left":
           arrow[| ARROW.DIR] = "up";
           break;
   }
   arrow[| OBJECT.IMGIND] = arrow[| OBJECT.IMGIND] + 1;
   print("move_arrow: done rotate");
}
