///con_surface(var surface, obj_layer, var xPos = 0, var yPos = 0, var xScale = 1, var yScale = 1, var rot = 0, var color = c_white, var alpha = .5)

var surface = argument0;
var layer = argument1;
var xPos = argument2;
var yPos = argument3;
var xScale = argument4;
var yScale = argument5;
var rot = argument6;
var color = argument7;
var alpha = argument8;

var roomName = layer.roomName;

print(" -> con_surface of " + string(roomName));

var surfaceInf = instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, surface);
surfaceInf.layer = layer;
surfaceInf.xPos = xPos;
surfaceInf.yPos = yPos;
surfaceInf.xScale = xScale;
surfaceInf.yScale = yScale;
surfaceInf.rot = rot;
surfaceInf.color = color;
surfaceInf.alpha = alpha;

return surfaceInf;
