///scr_pathBetween(obj_layer layer, obj_enum objectFrom, obj_enum objectTo)

/*
    This script returns true if there's a open, unobstructed path between 2 objects.
*/

var layer = argument0;
var oEnumFrom = argument1;
var oEnumTo = argument2;

var badObjList = array(par_obstacle, par_robot); //objects that could be in the way (would return false)

print("scr_pathBetween: Checking from: " + string(oEnumFrom[| OBJECT.X]) + "," + string(oEnumFrom[| OBJECT.Y]) + " to: " + string(oEnumTo[| OBJECT.X])+ "," + string(oEnumTo[| OBJECT.Y]));

var xSign = sign(oEnumTo[| OBJECT.X] - oEnumFrom[| OBJECT.X]); //for movement direction(left || right)
var ySign = sign(oEnumTo[| OBJECT.Y] - oEnumFrom[| OBJECT.Y]); //for movement direction(up || down)
var mapPosX = oEnumFrom[| OBJECT.X];
var mapPosY = oEnumFrom[| OBJECT.Y];
var pathIsClear = true;

var xDiff = abs(oEnumFrom[| OBJECT.X] - oEnumTo[| OBJECT.X]);
var yDiff = abs(oEnumFrom[| OBJECT.Y] - oEnumTo[| OBJECT.Y]);

//check if objects are adjacent; if they are, there is no path between them
if (scr_objectsAdjacent(oEnumFrom, oEnumTo)){
    print("scr_pathBetween: Objects are adjacent.  There is no path between them.");
    return false;
}

while(pathIsClear){ //not checking for platforms because you can pull over gaps
    
    mapPosX += (global.TILE_SIZE * xSign);
    mapPosY += (global.TILE_SIZE * ySign);
    
    if (mapPosX == oEnumTo[| OBJECT.X]) xSign = 0;
    if (mapPosY == oEnumTo[| OBJECT.Y]) ySign = 0;
    
    if (xSign == 0 && ySign == 0){
        print("scr_pathBetween: Path found between " + string(oEnumFrom[| OBJECT.NAME]) + " to " + string(oEnumTo[| OBJECT.NAME]) + "!  Returning true.");
        return true; // objectTo reached!   
    }
    
    // TODO -> mirptr pathing
    /*if (scr_tileContains(layer, mapPosX, mapPosY, obj_mirptr)){
        var mirptr = map_place(layer, obj_mirptr, mapPosX, mapPosY);
        mapPosX = mirptrPtr.x;
        mapPosY = mirptrPtr.y;
    }*/
    
    print("scr_pathBetween: Checking at: " + string(mapPosX) + "," + string(mapPosY));
    
    if (scr_tileContains(layer, mapPosX, mapPosY, badObjList)){
        pathIsClear = false; //oh no (a) blockage
    }
    
}

print("scr_pathBetween: No path found between " + string(oEnumFrom[| OBJECT.NAME]) + " to " + string(oEnumTo[| OBJECT.NAME]) + "!  Returning false.");

return false; // darn!  a likely blockage !
