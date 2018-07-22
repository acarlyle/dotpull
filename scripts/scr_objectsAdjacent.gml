///scr_objectsAdjacent(var obj1, var obj2)

/*
    Returns true if the objects' positions are adjacent (duh).  
*/

var obj1 = argument0;
var obj2 = argument1;

var absPosX = abs(obj1.x - obj2.x);
var absPosY = abs(obj1.y - obj2.y);

if (absPosX == global.TILE_SIZE || absPosY == global.TILE_SIZE) return true;

return false;
