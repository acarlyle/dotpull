///scr_objectsAdjacent(obj_enum objEnum1, obj_enum objEnum2)

/*
    Returns true if the objects' positions are adjacent ya dip
*/

var obj1 = argument0;
var obj2 = argument1;

var xDiff = abs(obj1[| OBJECT.X] - obj2[| OBJECT.X]);
var yDiff = abs(obj1[| OBJECT.Y] - obj2[| OBJECT.Y]);

if (xDiff <= global.TILE_SIZE && yDiff <= global.TILE_SIZE) return true;

return false;
