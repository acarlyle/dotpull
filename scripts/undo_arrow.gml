///undo_arrow(obj_enum arrow)

/*
    Handles undo for this arrow obj
*/

var arrow = argument0;

if (arrow[| ARROW.ISROTATING]){
    switch(arrow[| ARROW.DIR]){
        case "up":
            arrow[| ARROW.DIR] = "left";
            arrow[| OBJECT.IMGIND] = 3;
            break;
        case "right":
            arrow[| ARROW.DIR] = "up";
            arrow[| OBJECT.IMGIND] = 0;
            break;
        case "down":
            arrow[| ARROW.DIR] = "right";
            arrow[| OBJECT.IMGIND] = 1;
            break;
        case "left":
            arrow[| ARROW.DIR] = "down";
            arrow[| OBJECT.IMGIND] = 2;
            break;
    }
}
