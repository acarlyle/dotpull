///undo_arrow(par_arrow arrow)

/*
    Handles undo for this arrow obj
*/

arrow = argument0;

if (arrow.isRotating){
    switch(arrow.dir){
        case "up":
            arrow.dir = "left";
            break;
        case "right":
            arrow.dir = "up";
            break;
        case "down":
            arrow.dir = "right";
            break;
        case "left":
            arrow.dir = "down";
            break;
    }
    arrow.sprite_index = asset_get_index("spr_arrow_" + arrow.dir);
}
