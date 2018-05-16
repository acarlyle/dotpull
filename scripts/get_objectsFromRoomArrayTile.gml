///get_objectsFromRoomArrayTile(array roomArr, var xPos, var yPos)

var roomArr = argument0;
var xPos = argument1;
var yPos = argument2;

var objectsArr;

return scr_split(roomArr[yPos / global.TILE_SIZE, xPos / global.TILE_SIZE], ";");
